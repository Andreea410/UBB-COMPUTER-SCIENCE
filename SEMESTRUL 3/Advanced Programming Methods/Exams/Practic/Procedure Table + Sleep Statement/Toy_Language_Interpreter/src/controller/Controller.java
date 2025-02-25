package controller;
import exceptions.*;
import exceptions.EmptyStackException;
import model.adt.*;
import model.statements.ForkStatement;
import model.statements.IStmt;
import model.states.PrgState;
import model.types.IType;
import model.values.IValue;
import model.values.RefValue;
import model.values.StringValue;
import repository.IRepository;
import repository.Repository;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.*;
import java.util.concurrent.*;
import java.util.stream.Collectors;


public class Controller
{
    private final IRepository repository;
    ExecutorService executor;
    private PrgState prgState;

    public Controller(IRepository repo)
    {
        this.repository = repo;
    }

    public Controller(IRepository repo, PrgState prgState)
    {
        this.repository = repo;
        this.prgState = prgState;

    }

    public void allStep() throws InterruptedException{
        for (PrgState state: repository.getPrgStatesList()) {
            IMyDictionary<String, IType> typeTable = new MyDictionary<>();

            if(!state.getExeStack().isEmpty()) {
                state.getExeStack().peek().typeCheck(typeTable);
            }
        }

        executor = Executors.newFixedThreadPool(2);
        List<PrgState> programsList = removeCompletedPrgStates(repository.getPrgStatesList());

        if (programsList.isEmpty()) {
            System.out.println("No programs to execute.");
            executor.shutdownNow();
            return;
        }

        programsList.forEach(repository::clearLogFile);

        try {
            while (!programsList.isEmpty()) {
                conservativeGarbageCollector(programsList);
                OneStepForAllPrg(programsList);
                programsList.forEach(System.out::println);
                programsList = removeCompletedPrgStates(repository.getPrgStatesList());
            }
        } catch (ControllerException e) {
            System.out.println("Program finished successfully!");
        }

        executor.shutdownNow();
        repository.setPrgList(programsList);
    }


    public void OneStepForAllPrg(List<PrgState> prgStatess) throws ControllerException {

        prgStatess.forEach(p -> {
            try {
                repository.logPrgStateExec(p);
            } catch (RepoException e) {
                System.out.println("Error logging program state: " + e.getMessage());
            }
        });

        List<Callable<PrgState>> callableList = prgStatess.stream()
                .filter(p -> !p.getExeStack().isEmpty())
                .map((PrgState p) -> (Callable<PrgState>) (p::executeOneStep))
                .toList();

        List<PrgState> newPrgList;
        try {
            newPrgList = executor.invokeAll(callableList).stream()
                    .map(future -> {
                        try {
                            return future.get();
                        } catch (ExecutionException | InterruptedException e) {
                            System.out.println("Error executing thread: " + e.getMessage());
                            return null;
                        }
                    })
                    .filter(Objects::nonNull)
                    .toList();

        } catch (InterruptedException e) {
            throw new ControllerException(e.getMessage());
        }

        prgStatess.addAll(newPrgList);
        repository.setPrgList(prgStatess);
        prgStatess.forEach(p -> {
            try {
                repository.logPrgStateExec(p);
            } catch (RepoException e) {
                System.out.println("Error logging program state: " + e.getMessage());
            }
        });
    }

    public void runOneStep() throws EmptyStackException, IOException {
        this.executor = Executors.newFixedThreadPool(2);
        List<PrgState> programsList = removeCompletedPrgStates(repository.getPrgStatesList());

        if (programsList.isEmpty()) {
            throw new ControllerException("No programs to execute.");
        }


        programsList.forEach(System.out::println);
        conservativeGarbageCollector(programsList);
        OneStepForAllPrg(programsList);
        programsList.forEach(System.out::println);
    }


    public void addProgram(IStmt statement)
    {
        this.repository.addProgram(new PrgState(statement));
    }

    private Map<Integer, IValue> safeGarbageCollector(IMyList<Integer> symTableAddr, IMyHeap heap) {
        synchronized (heap) {
            IMyList<Integer> addresses = new MyList<>(symTableAddr.getList());
            boolean newAddressesFound;
            do {
                newAddressesFound = false;
                IMyList<Integer> newAddresses = getAddrFromSymTable(getReferencedValues(addresses, heap));

                for (Integer address : newAddresses.getList()) {
                    if (!addresses.getList().contains(address)) {
                        addresses.add(address);
                        newAddressesFound = true;
                    }
                }
            } while (newAddressesFound);

            Map<Integer, IValue> result = new HashMap<>();
            for (Map.Entry<Integer, IValue> entry : heap.getMap().entrySet()) {
                if (addresses.getList().contains(entry.getKey())) {
                    result.put(entry.getKey(), entry.getValue());
                }
            }
            return result;
        }
    }


    private void conservativeGarbageCollector(List<PrgState> programStates) {
        List<Integer> symTableAddresses = programStates.stream()
                .flatMap(p -> getAddrFromSymTable(p.getSymTable().getContent().values()).getList().stream())
                .collect(Collectors.toList());

        programStates.forEach(p -> {
            Map<Integer, IValue> newHeapContent = safeGarbageCollector(new MyList<>(symTableAddresses), p.getHeap());
            p.getHeap().setContent(newHeapContent);
        });
    }


    private List<IValue> getReferencedValues(IMyList<Integer> addresses, IMyHeap heap) {
        List<IValue> referencedValues = new ArrayList<>();
        for (Integer address : addresses.getList()) {
            IValue value = heap.getValue(address);
            if (value != null) {
                referencedValues.add(value);
            }
        }
        return referencedValues;
    }

    private IMyList<Integer> getAddrFromSymTable(Collection<IValue> symTableValues) {
        IMyList<Integer> addressList = new MyList<>();
        for (IValue value : symTableValues) {
            if (value instanceof RefValue) {
                addressList.add(((RefValue) value).getAddress());
            }
        }
        return addressList;
    }

    private List<PrgState> removeCompletedPrgStates(List<PrgState> prgStates) {
        return prgStates.stream()
                .filter(PrgState::isNotCompleted)
                .collect(Collectors.toList());
    }

    public List<PrgState> getProgramStateList() {
        return repository.getPrgStatesList();
    }

    public void setProgramStateList(List<PrgState> prgStates) {
        repository.setPrgList(prgStates);
    }

    private void updateHeap()
    {
        PrgState currentProgramState = this.getProgramStateList().get(0);
        currentProgramState.getHeap().setContent(safeGarbageCollector(getAddrFromSymTable(currentProgramState.getSymTable().getContent().values()), currentProgramState.getHeap()));
    }

    public Integer getProgramStateListCount() {
        return repository.getProgramStatesCount();
    }

    public void addProgram(PrgState prgState) {
        repository.addProgram(prgState);

    }

    public void setProcedureTable(IMyProcedureTable procedureTable) {
        repository.setProcedureTable(procedureTable);
    }

    public void addProcedure(String name, List<String> arguments, IStmt statement) {
        repository.addProcedure(name, arguments, statement);
    }
}

package model.statements;

import exceptions.ADTException;
import exceptions.StatementException;
import model.adt.IMyDictionary;
import model.adt.IMySemaphoreTable;
import model.adt.MyTuple;
import model.states.PrgState;
import model.types.IType;
import model.types.IntIType;
import model.values.IValue;
import model.values.IntIValue;

import java.io.IOException;
import java.util.List;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class AcquireStatement implements IStmt{
    private final String variable;
    private static final Lock lock = new ReentrantLock();

    public AcquireStatement(String variable) {
        this.variable = variable;
    }

    @Override
    public PrgState execute(PrgState prgState) throws StatementException, ADTException, IOException {
        lock.lock();

        IMyDictionary<String, IValue> symTable = prgState.getSymTable();
        IMySemaphoreTable semaphoreTable = prgState.getSemaphoreTable();

        if (symTable.contains(variable)) {

            if (symTable.getValue(variable).getType().equals(new IntIType())){
                IntIValue fi = (IntIValue) symTable.getValue(variable);
                int address = fi.getVal();

                if (semaphoreTable.contains(address)) {

                    MyTuple<Integer, List<Integer>, Integer> currentSemaphore = semaphoreTable.get(address);
                    int NL = currentSemaphore.getSecond().size();
                    int N1 = currentSemaphore.getFirst();
                    int N2 = currentSemaphore.getThird();

                    if (N1 - N2 > NL) {
                        if (!currentSemaphore.getSecond().contains(prgState.getId())) {
                            currentSemaphore.getSecond().add(prgState.getId());
                            semaphoreTable.update(address, new MyTuple<>(N1, currentSemaphore.getSecond(), N2));
                        }
                    } else {
                        prgState.getExeStack().push(this);
                    }

                } else {
                    throw new StatementException("Acquire: Index not an address in the semaphore table");
                }
            } else {
                throw new StatementException("Acquire: Index must be of int type!");
            }
        } else {
            throw new StatementException("Acquire: Index not in symbol table!");
        }
        lock.unlock();
        return null;

    }

    @Override
    public IStmt deepCopy() {
        return new AcquireStatement(this.variable);
    }

    @Override
    public IMyDictionary<String, IType> typeCheck(IMyDictionary<String, IType> typeEnv) throws StatementException {
        return typeEnv;
    }

    @Override
    public String toString() {
        return "Acquire(" + this.variable + ")";
    }
}

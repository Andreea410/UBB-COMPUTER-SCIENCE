package model.statements;

import exceptions.ADTException;
import exceptions.StatementException;
import javafx.util.Pair;
import model.adt.IMyDictionary;
import model.adt.IMySemaphore;
import model.states.PrgState;
import model.types.IType;
import model.types.IntIType;
import model.values.IValue;
import model.values.IntIValue;

import java.io.IOException;
import java.util.List;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class AcquireStatement implements IStmt {

    private final String variable;
    private final static Lock lock = new ReentrantLock();

    public AcquireStatement(String variable) {
        this.variable = variable;
    }

    @Override
    public PrgState execute(PrgState prgState) throws StatementException, ADTException, IOException {
        lock.lock();
        try {
            IMyDictionary<String, IValue> symTable = prgState.getSymTable();
            IMySemaphore semaphoreTable = prgState.getSemaphoreTable();

            if (!symTable.contains(variable))
                throw new StatementException("Variable " + variable + " is not in the symbol table");
            if (!symTable.getValue(variable).getType().equals(new IntIType()))
                throw new StatementException("Variable " + variable + " is not of type int");

            IntIValue value = (IntIValue) symTable.getValue(variable);
            int foundIndex = value.getVal();

            if (!semaphoreTable.contains(foundIndex))
                throw new StatementException("Semaphore " + foundIndex + " is not in the semaphore table");

            Pair<Integer, List<Integer>> semaphoreValue = semaphoreTable.get(foundIndex);

            int n = semaphoreValue.getValue().size();
            int n1 = semaphoreValue.getKey();

            if (n1 > n) {
                if (!semaphoreValue.getValue().contains(prgState.getId())) {
                    semaphoreValue.getValue().add(prgState.getId());
                    semaphoreTable.update(foundIndex, new Pair<>(n1, semaphoreValue.getValue()));
                }
            } else
                prgState.getExeStack().push(this);
        } finally {
            lock.unlock();
        }
        return null;
    }

    @Override
    public IStmt deepCopy() {
        return new AcquireStatement(variable);
    }

    @Override
    public IMyDictionary<String, IType> typeCheck(IMyDictionary<String, IType> typeEnv) throws StatementException {
        if (typeEnv.contains(variable)) {
            if (typeEnv.getValue(variable).equals(new IntIType()))
                return typeEnv;
            else
                throw new StatementException("Variable " + variable + " is not of type int");
        } else
            throw new StatementException("Variable " + variable + " is not in the symbol table");
    }

    @Override
    public String toString() {
        return "acquire(" + variable + ")";
    }
}
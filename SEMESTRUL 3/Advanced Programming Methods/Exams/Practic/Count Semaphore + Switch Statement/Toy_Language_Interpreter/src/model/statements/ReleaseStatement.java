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

public class ReleaseStatement implements IStmt {

    private final String variable;
    private final static Lock lock = new ReentrantLock();

    public ReleaseStatement(String variable) {
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
            if (semaphoreValue.getValue().contains(prgState.getId()))
                semaphoreValue.getValue().remove((Integer) prgState.getId());
            semaphoreTable.update(foundIndex, new Pair<>(semaphoreValue.getKey(), semaphoreValue.getValue()));
        } finally {
            lock.unlock();
        }
        return null;
    }

    @Override
    public IStmt deepCopy() {
        return new ReleaseStatement(variable);
    }

    @Override
    public IMyDictionary<String, IType> typeCheck(IMyDictionary<String, IType> typeEnv) throws StatementException {
        if (typeEnv.contains(variable) && typeEnv.getValue(variable).equals(new IntIType()))
            return typeEnv;
        else
            throw new StatementException("Variable " + variable + " is not of type int");
    }

    @Override
    public String toString() {
        return "release(" + variable + ")";
    }
}
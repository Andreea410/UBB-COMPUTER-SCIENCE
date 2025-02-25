package model.statements;

import exceptions.ADTException;
import exceptions.StatementException;
import model.adt.IMyDictionary;
import model.adt.IMySemaphoreTable;
import model.adt.MyTuple;
import model.statements.IStmt;
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
    private static final Lock lock = new ReentrantLock();

    public ReleaseStatement(String variable) {
        this.variable = variable;
    }

    @Override
    public PrgState execute(PrgState prgState) throws StatementException, ADTException, IOException {
        lock.lock();
        try {
            IMyDictionary<String, IValue> symTable = prgState.getSymTable();
            IMySemaphoreTable semaphoreTable = prgState.getSemaphoreTable();

            if(symTable.contains(variable))
            {
                if(symTable.getValue(variable).getType().equals(new IntIType()))
                {
                    IntIValue fi = (IntIValue) symTable.getValue(variable);
                    int address = fi.getVal();

                    if(semaphoreTable.contains(address))
                    {
                        MyTuple<Integer,List<Integer>,Integer> semaphore = semaphoreTable.get(address);
                        if(semaphore.getSecond().contains(prgState.getId()))
                            semaphore.getSecond().remove((Integer) prgState.getId());
                        semaphoreTable.update(address,new MyTuple<>(semaphore.getFirst(),semaphore.getSecond(),semaphore.getThird()));

                    }
                    else
                    {
                        throw new StatementException("Release: Index not in semaphore table!");
                    }
                }
                else
                {
                    throw new StatementException("Release: Index must be of int type!");
                }
            }
        }
        finally {
            lock.unlock();
        }
        return null;
    }

    private IntIValue validateAndGetInt(IMyDictionary<String, IValue> symTable, String var, String operation) throws StatementException {
        if (!symTable.contains(var)) throw new StatementException(operation + ": Index not in symbol table!");
        IValue value = symTable.getValue(var);
        if (!(value instanceof IntIValue)) throw new StatementException(operation + ": Index must be of int type!");
        return (IntIValue) value;
    }

    @Override
    public IStmt deepCopy() {
        return new ReleaseStatement(this.variable);
    }

    @Override
    public IMyDictionary<String, IType> typeCheck(IMyDictionary<String, IType> typeEnv) throws StatementException {
        return typeEnv;
    }

    @Override
    public String toString() {
        return "release(" + this.variable + ")";
    }
}
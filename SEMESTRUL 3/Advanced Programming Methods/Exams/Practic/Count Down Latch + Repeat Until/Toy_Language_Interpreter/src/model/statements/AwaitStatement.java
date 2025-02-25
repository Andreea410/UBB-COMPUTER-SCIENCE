package model.statements;

import exceptions.ADTException;
import exceptions.EmptyStackException;
import exceptions.KeyNotFoundException;
import exceptions.StatementException;
import model.adt.IMyDictionary;
import model.adt.IMyLatchTable;
import model.states.PrgState;
import model.types.IType;
import model.types.IntIType;
import model.values.IValue;
import model.values.IntIValue;

import java.io.IOException;
import java.security.KeyException;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class AwaitStatement implements IStmt {

    private final String variable;
    private final static Lock lock = new ReentrantLock();

    public AwaitStatement(String var) {
        this.variable = var;
    }

    @Override
    public PrgState execute(PrgState prgState) throws StatementException, ADTException, IOException {
        lock.lock();
        try {
            IMyDictionary<String, IValue> symTable = prgState.getSymTable();
            IMyLatchTable latchTable = prgState.getLatchTable();

            if (symTable.contains(variable)) {
                IntIValue fi = (IntIValue) symTable.getValue(variable);
                int foundIndex = fi.getVal();

                if (latchTable.containsKey(foundIndex)) {
                    if (latchTable.get(foundIndex) > 0) {
                        prgState.getExeStack().push(this);
                    }
                    else {
                        throw new KeyNotFoundException("Latch value is 0");
                    }
                } else {
                    throw new KeyNotFoundException("Key not found in latch table");
                }
            }
        } finally {
            lock.unlock();
        }
        return null;
    }


    @Override
    public IStmt deepCopy() {
        return new AwaitStatement(this.variable);
    }

    @Override
    public IMyDictionary<String, IType> typeCheck(IMyDictionary<String, IType> typeEnv) throws StatementException {
        if (!typeEnv.getValue(variable).equals(new IntIType())) {
            throw new StatementException("Variable is not of type int");
        }
        return typeEnv;
    }

    @Override
    public String toString() {
        return String.format("AwaitStatement(%s)", variable);
    }
}
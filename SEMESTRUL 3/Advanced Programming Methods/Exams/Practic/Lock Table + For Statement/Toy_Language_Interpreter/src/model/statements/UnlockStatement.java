package model.statements;

import exceptions.ADTException;
import exceptions.StatementException;
import model.adt.IMyDictionary;
import model.adt.IMyLockTable;
import model.states.PrgState;
import model.types.IType;
import model.types.IntIType;
import model.values.IValue;
import model.values.IntIValue;

import java.io.IOException;
import java.util.concurrent.locks.Lock;

public class UnlockStatement implements IStmt {
    private final String variable;
    private static final Lock lock = new java.util.concurrent.locks.ReentrantLock();

    public UnlockStatement(String var) {
        this.variable = var;
    }

    @Override
    public PrgState execute(PrgState state) {
        lock.lock();
        try {
            IMyDictionary<String, IValue> symbolTable = state.getSymTable();
            IMyLockTable lockTable = state.getLockTable();

            if (!symbolTable.contains(variable))
                throw new StatementException(String.format("Unlock: Variable %s not declared in symbol table", variable));
            if(!symbolTable.getValue(variable).getType().equals(new IntIType()))
                throw new StatementException(String.format("Unlock: Variable %s should be of type int", variable));

            IntIValue index = (IntIValue) symbolTable.getValue(variable);
            int freeAddress = index.getVal();

            if (!lockTable.containsKey(freeAddress))
                throw new StatementException(String.format("Unlock: Lock %s not declared in lock table", freeAddress));
            if (lockTable.lookup(freeAddress) == state.getId())
                lockTable.update(freeAddress, -1);
        }
        finally {
            lock.unlock();
        }
        return null;
    }

    @Override
    public IStmt deepCopy() {
        return new UnlockStatement(variable);
    }

    @Override
    public IMyDictionary<String, IType> typeCheck(IMyDictionary<String, IType> typeEnv) throws StatementException {
        if(!typeEnv.getValue(variable).equals(new IntIType()))
            throw new StatementException(String.format("Unlock: Variable %s should be of type int", variable));
        return typeEnv;
    }

    @Override
    public String toString() {
        return "unlock(" + variable + ")";
    }
}

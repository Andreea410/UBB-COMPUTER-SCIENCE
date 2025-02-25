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

public class LockStatement implements IStmt{
    private final String variable;
    private static final Lock lock = new java.util.concurrent.locks.ReentrantLock();

    public LockStatement(String var) {
        this.variable = var;
    }

    @Override
    public PrgState execute(PrgState prgState) throws StatementException, ADTException, IOException {
        lock.lock();
        try {
            IMyLockTable lockTable = prgState.getLockTable();
            IMyDictionary<String, IValue> symbolTable = prgState.getSymTable();

            if (!symbolTable.contains(variable))
                throw new StatementException(String.format("Lock: Variable %s not declared in symbol table", variable));
            if (!symbolTable.getValue(variable).getType().equals(new IntIType()))
                throw new StatementException(String.format("Lock: Variable %s should be of type int", variable));

            IntIValue index = (IntIValue) symbolTable.getValue(variable);
            int freeAddress = index.getVal();

            if (!lockTable.containsKey(freeAddress))
                if (!lockTable.containsKey(freeAddress)) {
                    lockTable.put(freeAddress, -1);
                }


            if (lockTable.lookup(freeAddress) == -1) {
                lockTable.update(freeAddress, prgState.getId());
                prgState.setLockTable(lockTable);
            }
            else
                prgState.getExeStack().push(this);

        }
        finally {
            lock.unlock();
        }
        return null;
    }

    @Override
    public IStmt deepCopy() {
        return new LockStatement(variable);
    }

    @Override
    public IMyDictionary<String, IType> typeCheck(IMyDictionary<String, IType> typeEnv) throws StatementException {
        if (typeEnv.getValue(variable).equals(new IntIType()))
            return typeEnv;
        else
            throw new StatementException(String.format("CreateLock: Variable %s should be of type int", variable));
    }

    @Override
    public String toString() {
        return "CreateLock(" + variable + ")";
    }
}

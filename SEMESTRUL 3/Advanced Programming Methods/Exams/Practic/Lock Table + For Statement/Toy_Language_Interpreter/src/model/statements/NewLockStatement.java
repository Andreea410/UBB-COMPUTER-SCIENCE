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

public class NewLockStatement implements IStmt{
    private final String variable;
    private static final Lock lock = new java.util.concurrent.locks.ReentrantLock();

    public NewLockStatement(String var) {
        this.variable = var;
    }

    @Override
    public PrgState execute(PrgState prgState) throws StatementException, ADTException, IOException {
        lock.lock();

        IMyLockTable lockTable = prgState.getLockTable();
        IMyDictionary<String, IValue> symbolTable = prgState.getSymTable();

        int freeAddress = lockTable.getFreeAddress();
        lockTable.put(lockTable.getFreeAddress(), -1);

        if(symbolTable.contains(variable) && symbolTable.getValue(variable).getType().equals(new IntIType()))
            symbolTable.insert(variable, new IntIValue(freeAddress));
        else throw new StatementException(String.format("CreateLock: Variable %s not declared in symbol table", variable));

        lock.unlock();
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
        else throw new StatementException(String.format("CreateLock: Variable %s should be of type int", variable));
    }

    @Override
    public String toString() {
        return "CreateLock(" + variable + ")";
    }
}


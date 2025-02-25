package model.statements;

import exceptions.ADTException;
import exceptions.StatementException;
import model.adt.IMyDictionary;
import model.adt.IMyLatchTable;
import model.expressions.ValueExpression;
import model.states.PrgState;
import model.types.IType;
import model.types.IntIType;
import model.values.IValue;
import model.values.IntIValue;

import java.io.IOException;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class CountDownStatement implements IStmt {

    public final String variable;
    private static final Lock lock = new ReentrantLock();

    public CountDownStatement(String var) {
        this.variable = var;
    }

    @Override
    public PrgState execute(PrgState prgState) throws StatementException, ADTException, IOException {
        lock.lock();
        try {
            IMyDictionary<String, IValue> symTable = prgState.getSymTable();
            IMyLatchTable latchTable = prgState.getLatchTable();

            if(symTable.contains(variable)) {
                IntIValue value = (IntIValue) symTable.get(variable);
                int foundIndex = value.getVal();
                if(latchTable.containsKey(foundIndex)) {
                    if (latchTable.get(foundIndex) > 0) {
                        latchTable.update(foundIndex, latchTable.get(foundIndex) - 1);
                    }
                    prgState.getExeStack().push(new PrintStm(new ValueExpression(new IntIValue(prgState.getId()))));
                }
                else {
                    throw new ADTException("Key not found in symbol table");
                }

            }
            else {
                throw new ADTException("Variable not found in symbol table");
            }
        } finally {
            lock.unlock();
        }
        return null;
    }

    @Override
    public IStmt deepCopy() {
        return new CountDownStatement(variable);
    }

    @Override
    public IMyDictionary<String, IType> typeCheck(IMyDictionary<String, IType> typeEnv) throws StatementException {
        if (!typeEnv.contains(variable)) {
            throw new StatementException("Variable is not defined in the type environment.");
        }
        if (!typeEnv.get(variable).equals(new IntIType())) {
            throw new StatementException("Variable is not of type int");
        }
        return typeEnv;
    }

    @Override
    public String toString() {
        return String.format("CountDown(%s)", variable);
    }
}

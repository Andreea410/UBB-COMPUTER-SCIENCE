package model.statements;

import exceptions.ADTException;
import exceptions.StatementException;
import javafx.util.Pair;
import model.adt.IMyDictionary;
import model.adt.IMyHeap;
import model.adt.IMySemaphore;
import model.expressions.IExp;
import model.states.PrgState;
import model.types.IType;
import model.types.IntIType;
import model.values.IValue;
import model.values.IntIValue;

import java.io.IOException;
import java.util.ArrayList;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class CreateSemaphoreStatement implements IStmt {
    private final String variable;
    private final IExp expression;
    private static final Lock lock = new ReentrantLock();

    public CreateSemaphoreStatement(String variable, IExp expression) {
        this.variable = variable;
        this.expression = expression;
    }

    @Override
    public PrgState execute(PrgState prgState) throws StatementException, ADTException, IOException {
        lock.lock();
        try {
            IMyDictionary<String, IValue> symTable = prgState.getSymTable();
            IMyHeap heap = prgState.getHeap();
            IMySemaphore semaphoreTable = prgState.getSemaphoreTable();

            IntIValue value = (IntIValue) expression.eval(symTable, heap);
            int number = value.getVal();
            int freeLocation = semaphoreTable.getFreeLocation();

            semaphoreTable.put(freeLocation, new Pair<>(number, new ArrayList<>()));

            if (symTable.contains(variable) && symTable.getValue(variable).getType().equals(new IntIType())) {
                symTable.update(variable, new IntIValue(freeLocation));
            } else {
                throw new StatementException("Variable " + variable + " is not of type int");
            }
        } finally {
            lock.unlock();
        }
        return null;
    }

    @Override
    public IStmt deepCopy() {
        return new CreateSemaphoreStatement(variable, expression.deepCopy());
    }

    @Override
    public IMyDictionary<String, IType> typeCheck(IMyDictionary<String, IType> typeEnv) throws StatementException {
        if (expression.typecheck(typeEnv).equals(new IntIType())) {
            typeEnv.insert(variable, new IntIType());
            return typeEnv;
        } else {
            throw new StatementException("Expression is not of type int");
        }
    }

    @Override
    public String toString() {
        return "createSemaphore(" + variable + ", " + expression + ")";
    }
}
package model.statements;

import exceptions.ADTException;
import exceptions.StatementException;
import model.adt.*;
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

public class NewSemaphoreStatement implements IStmt{
    private final String variable;
    private final IExp expression1;
    private final IExp expression2;
    private static Lock lock = new ReentrantLock();

    public NewSemaphoreStatement(String variable, IExp expression1, IExp expression2) {
        this.variable = variable;
        this.expression1 = expression1;
        this.expression2 = expression2;
    }

    @Override
    public PrgState execute(PrgState prgState) throws StatementException, ADTException, IOException {
        lock.lock();
        try {
            IMyDictionary<String, IValue> symTable = prgState.getSymTable();
            IMyHeap heap = prgState.getHeap();
            IMySemaphoreTable semaphoreTable = prgState.getSemaphoreTable();

            IntIValue initValue1 = (IntIValue) (expression1.eval(symTable, heap));
            IntIValue initValue2 = (IntIValue) (expression2.eval(symTable, heap));

            int number1 = initValue1.getVal();
            int number2 = initValue2.getVal();
            int freeAddress = semaphoreTable.getFreeAddress();

            semaphoreTable.add(freeAddress, new MyTuple<>(number1, new ArrayList<>(), number2));

            if (symTable.contains(variable) && symTable.getValue(variable).getType().equals(new IntIType())) {
                symTable.update(variable, new IntIValue(freeAddress));
            } else {
                throw new StatementException("NewSemaphore: Variable " + variable + " is not of type int");
            }
        }
        finally {
            lock.unlock();
        }
        return null;
    }

    @Override
    public IStmt deepCopy() {
        return new NewSemaphoreStatement(variable, expression1, expression2);
    }

    @Override
    public IMyDictionary<String, IType> typeCheck(IMyDictionary<String, IType> typeEnv) throws StatementException {
        IType typeVariable = typeEnv.getValue(variable);
        IType typeExpression1 = expression1.typecheck(typeEnv);
        IType typeExpression2 = expression2.typecheck(typeEnv);

        if (!typeVariable.equals(new IntIType()))
            throw new StatementException("CreateSemaphore: Variable " + variable + " is not of type int");

        if (!typeExpression1.equals(new IntIType()))
            throw new StatementException("CreateSemaphore: Expression 1 is not of type int");

        if (!typeExpression2.equals(new IntIType()))
            throw new StatementException("CreateSemaphore: Expression 2 is not of type int");

        return typeEnv;
    }

    @Override
    public String toString() {
        return "CreateSemaphore(" + variable + ", " + expression1.toString() + ", " + expression2.toString() + ")";
    }

}

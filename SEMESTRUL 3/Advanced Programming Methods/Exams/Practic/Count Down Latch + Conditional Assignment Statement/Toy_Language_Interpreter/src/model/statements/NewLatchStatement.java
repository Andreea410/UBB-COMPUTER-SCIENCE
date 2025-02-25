package model.statements;

import exceptions.ADTException;
import exceptions.StatementException;
import model.adt.IMyDictionary;
import model.adt.IMyHeap;
import model.adt.IMyLatchTable;
import model.adt.MyLatchTable;
import model.expressions.IExp;
import model.states.PrgState;
import model.types.IType;
import model.types.IntIType;
import model.values.IValue;
import model.values.IntIValue;

import java.io.IOException;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class NewLatchStatement implements IStmt{
    private final String variable;
    private final IExp expression;
    private static final Lock lock = new ReentrantLock();

    public NewLatchStatement(String var , IExp exp)
    {
        this.variable = var;
        this.expression = exp;
    }

    @Override
    public PrgState execute(PrgState prgState) throws StatementException, ADTException, IOException
    {
        lock.lock();
        IMyLatchTable latchTable = prgState.getLatchTable();
        IMyHeap heap = prgState.getHeap();
        IMyDictionary<String , IValue> symTable = prgState.getSymTable();

        IntIValue value = (IntIValue) expression.eval(symTable,heap);
        int number = value.getVal();

        int firstFree = latchTable.getFirstFree();
        latchTable.put(firstFree,number);

        if(!symTable.contains(variable))
            throw new StatementException("The variable is not defined");
        symTable.modify(variable,new IntIValue(firstFree));
        lock.unlock();
        return null;
    }


    @Override
    public IStmt deepCopy() {
        return new NewLatchStatement(variable, expression.deepCopy());
    }

    @Override
    public IMyDictionary<String, IType> typeCheck(IMyDictionary<String, IType> typeEnv) throws StatementException {
        if(!typeEnv.get(variable).equals(new IntIType()))
            throw new StatementException("Variable is not of type int");
        if(!expression.typecheck(typeEnv).equals(new IntIType()))
            throw new StatementException("Expression is not of type int");
        return typeEnv;
    }

    @Override
    public String toString()
    {
        return String.format("newLatch(%s,%s)",variable,expression);
    }



}

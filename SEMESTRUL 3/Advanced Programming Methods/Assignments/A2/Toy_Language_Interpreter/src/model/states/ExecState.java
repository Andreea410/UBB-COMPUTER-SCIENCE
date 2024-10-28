package model.states;
import exceptions.EmptyStackException;
import model.adt.MyStack;
import model.statements.IStmt;

import java.util.Stack;

public class ExecState implements IExecState{
    private MyStack<IStmt> execStack;

    public ExecState()
    {
        this.execStack = new MyStack<>();
    }

    @Override
    public void push(IStmt statement) {
        this.execStack.push(statement);
    }

    @Override
    public IStmt pop() throws EmptyStackException {
        return this.execStack.pop();
    }

    @Override
    public int size() {
        return this.execStack.getSize();
    }

    @Override
    public boolean isEmpty() {
        return this.execStack.isEmpty();
    }

    public MyStack<IStmt> getExecStack()
    {
        return this.execStack;
    }

    @Override
    public String toString()
    {
        return super.toString();
    }
}

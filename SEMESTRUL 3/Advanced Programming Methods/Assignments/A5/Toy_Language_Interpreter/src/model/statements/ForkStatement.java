package model.statements;

import exceptions.ADTException;
import exceptions.StatementException;
import model.adt.IMyStack;
import model.adt.MyStack;
import model.states.PrgState;

import java.io.IOException;

public class ForkStatement implements IStmt
{
    private final IStmt statement;

    public ForkStatement(IStmt statement)
    {
        this.statement = statement;
    }

    @Override
    public PrgState execute(PrgState prgState) throws StatementException, ADTException, IOException {
        IMyStack<IStmt> newExecutionStack = new MyStack<>();
        return new PrgState(newExecutionStack, prgState.getSymTable().deepCopy(), prgState.getOutput(), this.statement, prgState.getFileTable(), prgState.getHeap());
    }

    @Override
    public IStmt deepCopy() {
        return new ForkStatement(this.statement.deepCopy());
    }

    @Override
    public String toString()
    {
        return "Fork("+ statement.toString()+")";
    }
}

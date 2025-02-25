package model.statements;

import exceptions.ADTException;
import exceptions.StatementException;
import model.adt.IMyDictionary;
import model.adt.IMyStack;
import model.adt.MyDictionary;
import model.adt.MyStack;
import model.states.PrgState;
import model.types.IType;
import model.values.IValue;

import java.io.IOException;
import java.util.Map;

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
        IMyDictionary<String , IValue> newSymTable = new MyDictionary<>();
        for(Map.Entry<String, IValue> entry : prgState.getSymTable().getContent().entrySet())
        {
            newSymTable.insert(entry.getKey(), entry.getValue());
        }
        return new PrgState(newExecutionStack, newSymTable, prgState.getOutput(), this.statement, prgState.getFileTable(), prgState.getHeap(), prgState.getBarrierTable());
    }

    @Override
    public IStmt deepCopy() {
        return new ForkStatement(this.statement.deepCopy());
    }

    @Override
    public IMyDictionary<String, IType> typeCheck(IMyDictionary<String, IType> typeEnv) throws StatementException {
        statement.typeCheck(typeEnv.deepCopy());
        return typeEnv;
    }

    @Override
    public String toString()
    {
        return "Fork("+ statement.toString()+")";
    }
}

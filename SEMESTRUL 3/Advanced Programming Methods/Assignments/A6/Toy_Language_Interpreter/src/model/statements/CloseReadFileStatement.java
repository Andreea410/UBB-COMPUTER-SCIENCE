package model.statements;

import exceptions.StatementException;
import model.adt.IMyDictionary;
import model.expressions.IExp;
import model.states.PrgState;
import model.types.IType;
import model.types.StringType;
import model.values.IValue;
import model.values.StringValue;

import java.io.BufferedReader;
import java.io.IOException;

public class CloseReadFileStatement implements IStmt
{
    private final IExp expression;

    public CloseReadFileStatement(IExp expression)
    {
        this.expression = expression;
    }

    @Override
    public PrgState execute(PrgState prgState)
    {
        var table = prgState.getSymTable();
        IValue value = expression.eval(table, prgState.getHeap());

        if(!value.getType().equals(new StringType()))
            throw new StatementException("It is not a String type");

        StringValue filename = (StringValue)  value;
        var fileTable = prgState.getFileTable();

        if(!fileTable.contains(filename))
            throw new StatementException("Variable was not declared");

        try {
            BufferedReader reader = fileTable.getValue(filename);
            reader.close();
        }
        catch (IOException e)
        {
            throw new StatementException("The file can't be closed");
        }
        fileTable.remove(filename);
        return prgState;
    }

    @Override
    public IStmt deepCopy() {
        return new CloseReadFileStatement(this.expression.deepCopy());
    }

    @Override
    public IMyDictionary<String, IType> typeCheck(IMyDictionary<String, IType> typeEnv) throws StatementException {
        if (!expression.typecheck(typeEnv).equals(new StringType()))
            throw new StatementException("CLOSE READ FILE STATEMENT EXCEPTION: expression is not of type string");
        return typeEnv;
    }

    @Override
    public String toString() {
        return String.format("CloseReadFile(%s)", expression);
    }

}

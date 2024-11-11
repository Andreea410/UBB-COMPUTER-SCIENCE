package model.statements;

import exceptions.ADTException;
import exceptions.StatementException;
import model.expressions.IExp;
import model.states.PrgState;
import model.types.IntIType;
import model.types.StringType;
import model.values.IntIValue;
import model.values.StringValue;

import java.io.BufferedReader;
import java.io.IOException;

public class ReadFileStatement implements IStmt
{
    private final IExp expression;
    private final String variableName;

    public ReadFileStatement(IExp ex , String variableName)
    {
        this.expression = ex;
        this.variableName = variableName;
    }

    @Override
    public PrgState execute(PrgState prgState) throws StatementException, ADTException, IOException {
        var table = prgState.getSymTable();

        if(!table.contains(variableName))
        {
            throw new StatementException("The variable was not defined earlier");
        }
        if(!table.getValue(variableName).getType().equals(new IntIType()))
        {
            throw new StatementException("The type is incorrect");
        }
        var res = expression.eval(table);
        if(!res.getType().equals(new StringType()))
        {
            throw new StatementException("The result is not a String type");
        }

        BufferedReader reader = prgState.getFileTable().getValue((StringValue) res);
        try {
            String read = reader.readLine();
            if (read.isEmpty())
                read = "0";

            int parser = Integer.parseInt(read);
            table.insert(variableName, new IntIValue(parser));
            return prgState;
        }
        catch (IOException e)
        {
            throw new StatementException("Could not read the file: " + e.toString());
        }

    }

    @Override
    public IStmt deepCopy() {
        return new ReadFileStatement(this.expression.deepCopy() , this.variableName );
    }
}

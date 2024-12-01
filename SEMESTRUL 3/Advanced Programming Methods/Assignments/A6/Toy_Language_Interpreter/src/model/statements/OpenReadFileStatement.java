package model.statements;

import exceptions.ADTException;
import exceptions.StatementException;
import model.adt.IMyDictionary;
import model.expressions.IExp;
import model.states.PrgState;
import model.types.IType;
import model.types.StringType;
import model.values.StringValue;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

public class OpenReadFileStatement implements IStmt {

    private final IExp expression;

    public OpenReadFileStatement(IExp exp)
    {
        this.expression = exp;
    }

    @Override
    public PrgState execute(PrgState prgState) throws StatementException, ADTException, IOException {
        var table = prgState.getSymTable();
        var res = expression.eval(table,prgState.getHeap());

        if(!res.getType().equals(new StringType()))
            throw new StatementException("The type is incorrect");

        StringValue filename = (StringValue) res;
        var fileTable = prgState.getFileTable();

        if(fileTable.contains(filename))
            throw new StatementException("File is already opened.");

        try
        {
            BufferedReader reader = new BufferedReader(new FileReader(filename.getValue()));
            fileTable.insert(filename,reader);
            return prgState;
        }
        catch(IOException e)
        {
            throw new StatementException(e.toString());
        }
    }

    @Override
    public IStmt deepCopy()
    {
        return new OpenReadFileStatement(expression);
    }

    @Override
    public IMyDictionary<String, IType> typeCheck(IMyDictionary<String, IType> typeEnv) throws StatementException {
        if(!expression.typecheck(typeEnv).equals(new StringType()))
            throw new StatementException("OPEN READ FILE STATEMENT EXCEPTION: expression is not of stringType");

        return typeEnv;
    }

    @Override
    public String toString() {
        return String.format("OpenReadFile(%s)", expression);
    }


}

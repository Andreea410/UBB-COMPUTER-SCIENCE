package model.statements;

import exceptions.StatementException;
import model.adt.IMyDictionary;
import model.states.PrgState;
import model.types.IType;

public class NopStmt implements IStmt
{
    @Override
    public PrgState execute(PrgState prgState)
    {
        return null;
    }

    @Override
    public IStmt deepCopy() {
        return new NopStmt();
    }

    @Override
    public IMyDictionary<String, IType> typeCheck(IMyDictionary<String, IType> typeEnv) throws StatementException {
        return typeEnv;
    }

    @Override
    public String toString()
    {
        return "NopStatements";
    }
}

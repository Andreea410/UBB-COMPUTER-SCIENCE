package model.statements;

import exceptions.ADTException;
import exceptions.StatementException;
import model.expressions.IExp;
import model.states.PrgState;
import model.values.IValue;

public class AssignStmt implements IStmt{
    private final String variableName;
    private final IExp expression;

    public AssignStmt(String id , IExp e)
    {
        this.variableName = id;
        this.expression = e;
    }

    @Override
    public String toString()
    {
        return variableName+" = "+expression.toString();
    }

    @Override
    public PrgState execute(PrgState prgState) throws StatementException , ADTException
    {
        if(!prgState.getSymTable().contains(this.variableName))
            throw new StatementException("Variable was not found");
        IValue value = prgState.getSymTable().getValue(this.variableName);
        IValue evalValue = this.expression.eval(prgState.getSymTable());

        if(value.getType().equals(evalValue.getType()))
            throw new StatementException("Value type mismatch");
        prgState.getSymTable().insert(variableName,evalValue);
        return prgState;
    }





}

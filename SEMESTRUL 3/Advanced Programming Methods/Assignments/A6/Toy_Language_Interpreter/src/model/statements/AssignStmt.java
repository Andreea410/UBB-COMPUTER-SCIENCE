package model.statements;

import exceptions.ADTException;
import exceptions.StatementException;
import model.adt.IMyDictionary;
import model.expressions.IExp;
import model.states.PrgState;
import model.types.IType;
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
        IValue evalValue = this.expression.eval(prgState.getSymTable(), prgState.getHeap());

        if(!value.getType().equals(evalValue.getType()))
            throw new StatementException("Value type mismatch");
        prgState.getSymTable().insert(variableName,evalValue);
        return prgState;
    }

    @Override
    public IStmt deepCopy() {
        return new AssignStmt(this.variableName, this.expression.deepCopy());
    }

    @Override
    public IMyDictionary<String, IType> typeCheck(IMyDictionary<String, IType> typeEnv) throws StatementException {
        IType typeVar = typeEnv.getValue(variableName);
        IType typeExp = expression.typecheck(typeEnv);
        if(!typeVar.equals(typeExp))
            throw new StatementException("ASSIGN STATEMENT EXCEPTION: right side and left side have different types");
        return typeEnv;
    }


}

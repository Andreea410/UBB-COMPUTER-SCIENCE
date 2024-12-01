package model.statements;

import exceptions.ADTException;
import exceptions.StatementException;
import model.adt.IMyDictionary;
import model.expressions.IExp;
import model.states.PrgState;
import model.types.IType;
import model.types.RefType;
import model.values.IValue;
import model.values.RefValue;

import java.io.IOException;

public class HeapAllocationStatement implements IStmt
{

    private final IExp expression;
    private final String var;

    public HeapAllocationStatement(IExp expression , String var)
    {
        this.expression = expression;
        this.var = var ;
    }


    @Override
    public PrgState execute(PrgState prgState) throws StatementException, ADTException, IOException {

        if(!prgState.getSymTable().contains(var))
            throw new StatementException("Variable was not found");

        if (prgState.getSymTable().getValue(var) instanceof RefType)
            throw new StatementException("Variables must be RefType");

        IValue value = expression.eval(prgState.getSymTable(), prgState.getHeap());
        IType locationType = ((RefValue)prgState.getSymTable().getValue(var)).getLocationType();
        if(!locationType.equals(value.getType()))
            throw new StatementException("Wrong type for expression");

        int address = prgState.getHeap().add(value);
        prgState.getSymTable().insert(var ,new RefValue(address,value.getType()));
        return prgState;
    }

    @Override
    public IStmt deepCopy() {
        return new HeapAllocationStatement(this.expression.deepCopy() , this.var);
    }

    @Override
    public IMyDictionary<String, IType> typeCheck(IMyDictionary<String, IType> typeEnv) throws StatementException {
        IType typeVariable = typeEnv.getValue(var);
        IType typeExpression = expression.typecheck(typeEnv);

        if(!typeVariable.equals(new RefType(typeExpression)))
            throw new StatementException("HEAP ALLOCATION STATEMENT EXCEPTION: Variable and expression types are not compatible");
        return typeEnv;
    }

    @Override
    public String toString()
    {
        return String.format("(%s %s)",var,expression);
    }
}

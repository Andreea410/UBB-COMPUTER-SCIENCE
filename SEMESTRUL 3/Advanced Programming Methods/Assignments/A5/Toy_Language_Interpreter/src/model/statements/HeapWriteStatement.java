package model.statements;

import exceptions.ADTException;
import exceptions.StatementException;
import model.expressions.IExp;
import model.states.PrgState;
import model.values.IValue;
import model.values.RefValue;

import java.io.IOException;

public class HeapWriteStatement implements IStmt{
    private final String variable;
    private final IExp expression;

    public HeapWriteStatement(IExp expression , String variable)
    {
        this.variable = variable;
        this.expression = expression;
    }

    @Override
    public PrgState execute(PrgState prgState) throws StatementException, ADTException, IOException {
        if(!prgState.getSymTable().contains(variable))
            throw new StatementException(String.format("Heap error : %s is not defined.",variable));
        if(!(prgState.getSymTable().getValue(variable) instanceof RefValue))
            throw new StatementException(String.format("Heap error: %s is not of type Reference",variable));

        RefValue referenceValue = (RefValue) prgState.getSymTable().getValue(variable);
        IValue evaluated = expression.eval(prgState.getSymTable(), prgState.getHeap());
        if(!evaluated.getType().equals(referenceValue.getLocationType()))
            throw new StatementException(String.format("Heap Error: %s is not of type %s.",evaluated,referenceValue.getLocationType()));
        prgState.getHeap().update(referenceValue.getAddress(),evaluated);
        return prgState;
    }

    @Override
    public IStmt deepCopy() {
        return new HeapWriteStatement(this.expression.deepCopy() , this.variable);
    }

    @Override
    public String toString() {
        return String.format("WriteHeap( %s, %s)", variable, expression);
    }
}

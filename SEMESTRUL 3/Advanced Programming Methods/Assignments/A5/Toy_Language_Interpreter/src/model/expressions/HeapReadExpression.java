package model.expressions;

import exceptions.ADTException;
import exceptions.ExpressionException;
import model.adt.IMyDictionary;
import model.adt.IMyHeap;
import model.values.IValue;
import model.values.RefValue;

public class HeapReadExpression implements IExp
{
    private final IExp expression;

    public HeapReadExpression(IExp exp)
    {
        this.expression = exp;
    }

    @Override
    public IValue eval(IMyDictionary<String, IValue> symtbl, IMyHeap heap) throws ADTException, ExpressionException {
        IValue value = expression.eval(symtbl, heap);
        if(!(value instanceof RefValue))
            throw new ExpressionException("Heap Error: value is not of type RefValue");
        RefValue refValue = (RefValue) value;
        return heap.getValue(refValue.getAddress());
    }

    @Override
    public IExp deepCopy() {
        return null;
    }

    @Override
    public String toString() {
        return String.format("HeapRead(%s)", expression);
    }
}

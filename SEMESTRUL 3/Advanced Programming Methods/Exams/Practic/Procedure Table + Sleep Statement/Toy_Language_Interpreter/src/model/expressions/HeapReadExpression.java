package model.expressions;

import exceptions.ADTException;
import exceptions.ExpressionException;
import model.adt.IMyDictionary;
import model.adt.IMyHeap;
import model.adt.IMyStack;
import model.types.IType;
import model.types.RefType;
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
    public IValue eval(IMyDictionary<String, IValue> symtable, IMyHeap heap) throws ADTException, ExpressionException {
        IValue value = expression.eval(symtable, heap);
        if(!(value instanceof RefValue refValue))
            throw new ExpressionException("Heap Error: value is not of type RefValue");
        return heap.getValue(refValue.getAddress());
    }

    @Override
    public IExp deepCopy() {
        return null;
    }

    @Override
    public IType typecheck(IMyDictionary<String, IType> typeEnv) throws ExpressionException {
        IType type = expression.typecheck(typeEnv);
        if(!(type instanceof RefType refType))
            throw new ExpressionException("HEAP READ EXPRESSION EXCEPTION: expression is not of type RefType");
        return refType.getInner();
    }

    @Override
    public String toString() {
        return String.format("HeapRead(%s)", expression);
    }
}

package model.expressions;

import model.adt.IMyDictionary;
import model.adt.IMyHeap;
import model.types.IType;
import model.types.IntIType;
import model.values.IValue;
import model.values.IntIValue;
import exceptions.ADTException;
import exceptions.ExpressionException;

public class ArithmeticalExpression implements IExp {
    private final IExp left;
    private final IExp right;
    private final ArithmeticalOperator  operator;


    public ArithmeticalExpression(IExp l ,ArithmeticalOperator operator , IExp r)
    {
        this.left = l;
        this.operator = operator;
        this.right = r;
    }


    @Override
    public IValue eval(IMyDictionary<String , IValue> symTbl, IMyHeap heap) throws ADTException, ExpressionException
    {
        IValue valueLeft =left.eval(symTbl,heap);
        IValue valueRight = right.eval(symTbl,heap);
        if(!valueRight.getType().equals(new IntIType()))
            throw new ExpressionException("Second value is not int ");
        if(!valueLeft.getType().equals(new IntIType()))
            throw new ExpressionException("First value is not int ");

        IntIValue v1 = (IntIValue) valueLeft;
        IntIValue v2 = (IntIValue) valueRight;

        return switch (this.operator) {
            case ADD -> new IntIValue(v1.getVal() + v2.getVal());
            case SUBTRACT -> new IntIValue(v1.getVal() - v2.getVal());
            case MULTIPLY -> new IntIValue(v1.getVal() * v2.getVal());
            case DIVIDE -> {
                if (v2.getVal() == 0)
                    throw new ExpressionException("Divide by zero");
                yield new IntIValue(v1.getVal() / v2.getVal());
            }

        };
    }

    @Override
    public IExp deepCopy() {
        return new ArithmeticalExpression(this.left.deepCopy() , this.operator,this.right.deepCopy());
    }

    @Override
    public IType typecheck(IMyDictionary<String, IType> typeEnv) throws ExpressionException {
        IType type1,type2;
        type1 = left.typecheck(typeEnv);
        type2 = right.typecheck(typeEnv);
        if(!type1.equals(new IntIType()))
            throw new ExpressionException("ARITHMETICAL EXPRESSION EXCEPTION: left expression is not of type int");
        if(!type2.equals(new IntIType()))
            throw new ExpressionException("ARITHMETICAL EXPRESSION EXCEPTION: right expression is not of type int");
        return new IntIType();
    }

    @Override
    public String toString()
    {
        return this.left + " "+ operator.toString() +" "+ this.right;
    }

}

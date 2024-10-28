package model.expressions;

import model.adt.IMyDictionary;
import model.types.IntIType;
import model.values.IValue;
import model.values.IntIValue;
import exceptions.ADTException;
import exceptions.ExpressionException;

public class ArithmeticalExpression implements IExp {
    private IExp left;
    private IExp right;
    private final ArithmeticalOperator  operator;


    public ArithmeticalExpression(IExp l ,ArithmeticalOperator operator , IExp r)
    {
        this.left = l;
        this.operator = operator;
        this.right = r;
    }

    public IExp getLeft() {
        return left;
    }

    public void setLeft(IExp left) {
        this.left = left;
    }

    public IExp getRight() {
        return right;
    }

    public void setRight(IExp right) {
        this.right = right;
    }

    @Override
    public IValue eval(IMyDictionary<String , IValue> symTbl) throws ADTException, ExpressionException
    {
        IValue valueLeft =left.eval(symTbl);
        IValue valueRight = right.eval(symTbl);
        if(valueRight.getType().equals(new IntIType()))
            throw new ExpressionException("Second value is not int ");
        if(valueLeft.getType().equals(new IntIType()))
            throw new ExpressionException("First value is not int ");

        IntIValue v1 = (IntIValue) valueLeft;
        IntIValue v2 = (IntIValue) valueRight;

        switch (this.operator) {
//            case '+' -> new IntIValue(v1.getVal() + v2.getVal());
//            case '-' -> new IntIValue(v1.getVal() - v2.getVal());
//            case '*' -> new IntIValue(v1.getVal() * v2.getVal());
//            case ':' -> {
//                if (v2.getVal() == 0)
//                    throw new ExpressionException("Divide by zero");
//                yield new IntIValue(v1.getVal() / v2.getVal());
//            }
            default -> throw new ExpressionException("Unknown operator");
        }
    }

}

package model.expressions;
import exceptions.ADTException;
import exceptions.ExpressionException;
import model.adt.IMyDictionary;
import model.adt.IMyHeap;
import model.types.BoolIType;
import model.values.BoolValue;
import model.values.IValue;

public class LogicalExpression implements IExp{
    private final IExp left;
    private final IExp right;
    private final LogicalOperator operator;

    public LogicalExpression(IExp l, LogicalOperator opeartor, IExp r)
    {
        this.left =l;
        this.operator = opeartor;
        this.right = r;
    }

    @Override
    public IValue eval(IMyDictionary<String, IValue> symTable, IMyHeap heap) throws ADTException, ExpressionException
    {
       IValue evaluatedExpressionLeft = left.eval(symTable,heap);
       IValue evaluatedExpressionRight = right.eval(symTable,heap);
       if(!evaluatedExpressionLeft.getType().equals(new BoolIType()))
       {
           throw new ExpressionException("Left expression is not of type BoolType");
       }
       if(!evaluatedExpressionRight.getType().equals(new BoolIType()))
       {
           throw new ExpressionException("Right expression is not of type BoolType");
       }

        return switch (operator) {
            case LogicalOperator.AND ->
                    new BoolValue(((BoolValue) evaluatedExpressionLeft).getVal() && ((BoolValue) evaluatedExpressionRight).getVal());
            case LogicalOperator.OR ->
                    new BoolValue(((BoolValue) evaluatedExpressionLeft).getVal() || ((BoolValue) evaluatedExpressionRight).getVal());
            default -> throw new ExpressionException("Unknown operator");
        };


    }

    @Override
    public IExp deepCopy() {
        return new LogicalExpression(this.left.deepCopy() , this.operator , this.right.deepCopy());
    }

    @Override
    public String toString()
    {
        return left.toString()+ " " + this.operator + " " + right.toString();
    }

}

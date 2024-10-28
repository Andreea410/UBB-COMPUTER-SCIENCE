package model.expressions;
import exceptions.ADTException;
import exceptions.ExpressionException;
import model.adt.IMyDictionary;
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
    public IValue eval(IMyDictionary<String, IValue> symTable) throws ADTException, ExpressionException
    {
       IValue evaluatedExpressionLeft = left.eval(symTable);
       IValue evaluatedExpressionRight = right.eval(symTable);
       if(evaluatedExpressionLeft.getType().equals(new BoolIType()))
       {
           throw new ExpressionException("Left expression is not of type BoolType");
       }
       if(evaluatedExpressionRight.getType().equals(new BoolIType()))
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
    public String toString()
    {
        return left.toString()+ " " + this.operator + " " + right.toString();
    }

}

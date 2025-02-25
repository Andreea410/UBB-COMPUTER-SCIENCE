package model.expressions;
import exceptions.ADTException;
import exceptions.ExpressionException;
import model.adt.IMyDictionary;
import model.adt.IMyHeap;
import model.types.BoolIType;
import model.types.IType;
import model.values.BoolValue;
import model.values.IValue;

public class LogicalExpression implements IExp{
    private final IExp left;
    private final IExp right;
    private final LogicalOperator operator;

    public LogicalExpression(IExp l, LogicalOperator operator, IExp r)
    {
        this.left =l;
        this.operator = operator;
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

        };


    }

    @Override
    public IExp deepCopy() {
        return new LogicalExpression(this.left.deepCopy() , this.operator , this.right.deepCopy());
    }

    @Override
    public IType typecheck(IMyDictionary<String, IType> typeEnv) throws ExpressionException {
        IType type1 , type2;
        type1 = left.typecheck(typeEnv);
        type2 = right.typecheck(typeEnv);
        if(!type1.equals(new BoolIType()))
            throw new ExpressionException("LOGICAL EXPRESSION EXCEPTION: left expression is not of type BoolType");
        if(!type2.equals(new BoolIType()))
            throw new ExpressionException("LOGICAL EXPRESSION EXCEPTION: right expression is not of type BoolType");
        return new BoolIType();
    }

    @Override
    public String toString()
    {
        return left.toString()+ " " + this.operator + " " + right.toString();
    }

}

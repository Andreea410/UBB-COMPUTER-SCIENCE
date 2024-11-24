package model.expressions;

import exceptions.ADTException;
import exceptions.ExpressionException;
import model.adt.IMyDictionary;
import model.adt.IMyHeap;
import model.types.IntIType;
import model.values.BoolValue;
import model.values.IValue;
import model.values.IntIValue;

public class RelationalExpression implements IExp{

    public final IExp expression1;
    public final IExp expression2;

    String operator;

    public RelationalExpression(IExp exp1 , String operator , IExp exp2)
    {
        this.expression1 = exp1;
        this.operator = operator;
        this.expression2 = exp2;
    }

    @Override
    public IValue eval(IMyDictionary<String, IValue> symtbl, IMyHeap heap) throws ADTException, ExpressionException {
        IValue value1 = expression1.eval(symtbl,heap);
        IValue value2 = expression2.eval(symtbl,heap);

        if(!value1.getType().equals(new IntIType()))
            throw new ExpressionException("First value is not int.");
        if(!value2.getType().equals(new IntIType()))
            throw new ExpressionException("Second value is not int.");

        int intValue1 = ((IntIValue) value1).getVal();
        int intValue2 = ((IntIValue) value2).getVal();

        switch (operator)
        {
            case ">":
                return new BoolValue(intValue1 > intValue2);
            case "<":
                return new BoolValue(intValue1 < intValue2);
            case ">=":
                return new BoolValue(intValue1 >= intValue2);
            case "<=":
                return new BoolValue(intValue1 <= intValue2);
            case "==":
                return new BoolValue(intValue1 == intValue2);
            case "!=":
                return new BoolValue(intValue1 != intValue2);
            default:
                throw new ExpressionException("Unknown operator");
        }

    }

    @Override
    public IExp deepCopy() {
        return new RelationalExpression(this.expression1.deepCopy() , this.operator , this.expression2.deepCopy());
    }

    @Override
    public String toString()
    {
        return expression1.toString() + " " + this.operator + " " + this.expression2.toString();
    }
}

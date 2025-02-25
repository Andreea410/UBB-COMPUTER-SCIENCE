package model.expressions;

import exceptions.ADTException;
import exceptions.ExpressionException;
import model.adt.IMyDictionary;
import model.adt.IMyHeap;
import model.adt.IMyStack;
import model.types.BoolIType;
import model.types.IType;
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
    public IValue eval(IMyDictionary<String, IValue> symtable, IMyHeap heap) throws ADTException, ExpressionException {
        IValue value1 = expression1.eval(symtable,heap);
        IValue value2 = expression2.eval(symtable,heap);

        if(!value1.getType().equals(new IntIType()))
            throw new ExpressionException("First value is not int.");
        if(!value2.getType().equals(new IntIType()))
            throw new ExpressionException("Second value is not int.");

        int intValue1 = ((IntIValue) value1).getVal();
        int intValue2 = ((IntIValue) value2).getVal();

        return switch (operator) {
            case ">" -> new BoolValue(intValue1 > intValue2);
            case "<" -> new BoolValue(intValue1 < intValue2);
            case ">=" -> new BoolValue(intValue1 >= intValue2);
            case "<=" -> new BoolValue(intValue1 <= intValue2);
            case "==" -> new BoolValue(intValue1 == intValue2);
            case "!=" -> new BoolValue(intValue1 != intValue2);
            default -> throw new ExpressionException("Unknown operator");
        };

    }

    @Override
    public IType typecheck(IMyDictionary<String, IType> typeEnv) throws ExpressionException {
        IType type1 , type2;
        type1 = expression1.typecheck(typeEnv);
        type2 = expression2.typecheck(typeEnv);

        if(!type1.equals(new IntIType()))
            throw new ExpressionException("RELATIONAL EXPRESSION EXCEPTION: expression1 is not of type int");
        if(!type2.equals(new IntIType()))
            throw new ExpressionException("RELATIONAL EXPRESSION EXCEPTION: expression2 is not of type int");

        return new BoolIType();
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

package model.expressions;

import exceptions.ADTException;
import exceptions.ExpressionException;
import model.adt.IMyDictionary;
import model.adt.IMyHeap;
import model.types.IType;
import model.types.IntIType;
import model.values.IValue;
import model.values.IntIValue;

public class MulExpression implements IExp{
    private final IExp left;
    private final IExp right;

    public MulExpression(IExp left, IExp right) {
        this.left = left;
        this.right = right;
    }

    @Override
    public IValue eval(IMyDictionary<String, IValue> symbolTable, IMyHeap heap) throws ADTException, ExpressionException {
        IExp expression = new ArithmeticalExpression(new ArithmeticalExpression(left, ArithmeticalOperator.MULTIPLY, right), ArithmeticalOperator.SUBTRACT, new ArithmeticalExpression(left, ArithmeticalOperator.ADD, right));
        return expression.eval(symbolTable, heap);
    }

    @Override
    public IExp deepCopy() {
        return new MulExpression(this.left.deepCopy(), this.right.deepCopy());
    }

    @Override
    public IType typecheck(IMyDictionary<String, IType> typeEnv) throws ExpressionException {
        IType type1, type2;
        type1 = left.typecheck(typeEnv);
        type2 = right.typecheck(typeEnv);
        if (type1.equals(new IntIType())) {
            if (type2.equals(new IntIType())) {
                return new IntIType();
            } else {
                throw new ExpressionException("Second operand is not an integer");
            }
        } else {
            throw new ExpressionException("First operand is not an integer");
        }
    }

    @Override
    public String toString() {
        return String.format("%s * %s", left.toString(), right.toString());
    }
}

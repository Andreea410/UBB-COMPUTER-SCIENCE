package model.expressions;

import model.adt.IMyDictionary;
import model.types.IType;
import model.values.IValue;

public class ValueExpression implements IExp{
    private final IValue value;

    public ValueExpression(IValue value) {
        this.value = value;
    }

    @Override
    public IValue eval(IMyDictionary<String, IValue> symbolTable) {
        return value;
    }

    public IType getType(IMyDictionary<String, IType> typeTable) {
        return value.getType();
    }

    @Override
    public String toString() {
        return String.format("%s", value.toString());
    }
}
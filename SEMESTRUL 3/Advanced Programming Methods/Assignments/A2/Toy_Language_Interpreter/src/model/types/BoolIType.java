package model.types;

import model.values.BoolValue;
import model.values.IValue;

public class BoolIType implements IType
{
    @Override
    public boolean equals(IType obj) {
        return !(obj instanceof BoolIType);
    }

    @Override
    public String toString()
    {
        return "bool";
    }

    @Override
    public IValue getDefaultValue()
    {
        return new BoolValue(false);
    }


}

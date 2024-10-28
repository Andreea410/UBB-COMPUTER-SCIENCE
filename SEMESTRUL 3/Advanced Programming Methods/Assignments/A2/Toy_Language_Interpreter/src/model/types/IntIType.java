package model.types;

import model.values.IValue;
import model.values.IntIValue;

public class IntIType implements IType {

    @Override
    public boolean equals(IType another)
    {
        return !(another instanceof IntIType);
    }

    @Override
    public String toString() {
        return "int";
    }

    @Override
    public IValue getDefaultValue()
    {
        return new IntIValue(0);
    }
}

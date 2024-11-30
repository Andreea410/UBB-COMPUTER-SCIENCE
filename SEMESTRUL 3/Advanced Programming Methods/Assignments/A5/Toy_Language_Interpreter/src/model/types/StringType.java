package model.types;

import model.values.IValue;
import model.values.StringValue;

public class StringType implements IType{
    public StringType()
    {
    }

    @Override
    public boolean equals(IType another) {
        return another instanceof StringType;
    }

    @Override
    public IValue getDefaultValue() {
        return new StringValue("");
    }

    @Override
    public String toString()
    {
        return "String";
    }
}

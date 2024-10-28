package model.values;
import model.types.BoolIType;
import model.types.IType;

public class BoolValue implements IValue
{
    boolean val;

    public BoolValue(boolean v)
    {
        this.val = v;
    }

    @Override
    public String toString()
    {
        return "bool";
    }

    @Override
    public IType getType()
    {
        return new BoolIType();
    }

    public boolean getVal()
    {
        return val;
    }

    @Override
    public boolean equals(IValue other)
    {
        return other instanceof BoolValue && ((BoolValue)other).val == this.val;
    }



}

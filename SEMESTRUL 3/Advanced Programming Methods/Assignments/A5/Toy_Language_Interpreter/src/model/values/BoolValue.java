package model.values;
import model.types.BoolIType;
import model.types.IType;

public class BoolValue implements IValue
{
    Boolean val;

    public BoolValue(boolean v)
    {
        this.val = v;
    }

    @Override
    public String toString()
    {
        return val.toString();
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
        return (other instanceof BoolValue) && ((BoolValue)other).val == this.val;
    }



}

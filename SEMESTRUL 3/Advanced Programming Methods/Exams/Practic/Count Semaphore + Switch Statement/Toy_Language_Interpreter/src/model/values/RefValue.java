package model.values;
import model.types.IType;
import model.types.RefType;

public class RefValue implements IValue{
    private final int address;
    private final IType locationType;

    public RefValue(int address , IType locationType)
    {
        this.address = address;
        this.locationType = locationType;
    }

    public int getAddress()
    {
        return this.address;
    }

    public IType getLocationType()
    {
        return this.locationType;
    }

    @Override
    public IType getType()
    {
        return new RefType(locationType);
    }

    @Override
    public boolean equals(IValue value) {
        return value instanceof RefValue && ((RefValue)value).getAddress() == this.address;
    }

    @Override
    public String toString()
    {
        return String.format("(%d %s)",address,locationType);
    }

}

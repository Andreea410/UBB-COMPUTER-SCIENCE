package model.types;


import model.values.IValue;
import model.values.RefValue;

public class RefType implements IType{
    IType inner;

    public RefType(IType inner)
    {
        this.inner = inner;
    }

    @Override
    public boolean equals(IType another) {
        return another instanceof RefType && ((RefType)another).getInner().equals(this.inner);
    }

    @Override
    public IValue getDefaultValue() {
        return new RefValue(0,inner);
    }

    public IType getInner()
    {
        return this.inner;
    }

    @Override
    public String toString() {
        return "Ref(" + this.inner + ")";
    }
}

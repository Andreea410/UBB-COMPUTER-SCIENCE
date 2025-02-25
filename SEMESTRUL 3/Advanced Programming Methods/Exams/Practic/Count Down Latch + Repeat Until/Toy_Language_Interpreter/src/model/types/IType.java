package model.types;

import model.values.IValue;

public interface IType
{
    boolean equals(IType another) ;
    IValue getDefaultValue();
}

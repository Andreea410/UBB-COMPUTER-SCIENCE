package model.values;
import model.types.IType;

public interface IValue {
    IType getType() ;
    boolean equals(IValue value);
}

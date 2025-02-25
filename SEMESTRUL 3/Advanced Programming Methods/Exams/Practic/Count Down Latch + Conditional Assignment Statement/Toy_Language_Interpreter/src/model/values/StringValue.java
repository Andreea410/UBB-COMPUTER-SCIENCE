package model.values;

import model.types.IType;
import model.types.StringType;

public class StringValue implements IValue
{
    private String value;

    public StringValue(String val){
        this.value =val;
    }

    @Override
    public IType getType() {
        return new StringType();
    }
    public String getValue()
    {
        return this.value;
    }

    public void setValue(String value)
    {
        this.value = value;
    }

    @Override
    public boolean equals(IValue value) {
        return value.getType().equals(new StringType())&& ((StringValue) value).getValue().equals(this.value);
    }

    @Override
    public String toString()
    {
        return value;
    }
}

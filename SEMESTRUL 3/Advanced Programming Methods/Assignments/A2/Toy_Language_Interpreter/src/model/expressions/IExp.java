package model.expressions;
import exceptions.ADTException;
import exceptions.ExpressionException;
import model.adt.IMyDictionary;
import model.values.IValue;

public interface IExp {
    IValue eval(IMyDictionary<String, IValue> symtbl) throws ADTException, ExpressionException;

}

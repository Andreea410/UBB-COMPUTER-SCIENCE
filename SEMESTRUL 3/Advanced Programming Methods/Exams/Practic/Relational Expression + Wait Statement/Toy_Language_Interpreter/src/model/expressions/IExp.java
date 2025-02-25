package model.expressions;
import exceptions.ADTException;
import exceptions.ExpressionException;
import model.adt.IMyDictionary;
import model.adt.IMyHeap;
import model.types.IType;
import model.values.IValue;

public interface IExp {
    IValue eval(IMyDictionary<String, IValue> symtbl, IMyHeap heap) throws ADTException, ExpressionException;
    IExp deepCopy();
    IType typecheck(IMyDictionary<String,IType> typeEnv) throws ExpressionException;
}

package model.expressions;

import exceptions.ADTException;
import exceptions.ExpressionException;
import model.adt.IMyDictionary;
import model.adt.IMyHeap;
import model.types.IType;
import model.values.IValue;

public class VariableExpression implements IExp {

    private final String variable;

    public VariableExpression(String variable) {
        this.variable = variable;
    }

    @Override
    public IValue eval(IMyDictionary<String, IValue> symTbl, IMyHeap heap) throws ADTException , ExpressionException {
        return symTbl.getValue(variable);
    }

    @Override
    public IExp deepCopy() {
        return new VariableExpression(this.variable);
    }

    @Override
    public IType typecheck(IMyDictionary<String, IType> typeEnv) throws ExpressionException {
        return typeEnv.getValue(variable);
    }

    @Override
    public String toString(){
        return variable;
    }
}
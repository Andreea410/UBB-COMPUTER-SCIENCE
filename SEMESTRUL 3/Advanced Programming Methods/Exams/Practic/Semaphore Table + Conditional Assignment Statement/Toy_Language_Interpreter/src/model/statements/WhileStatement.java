package model.statements;

import exceptions.ADTException;
import exceptions.StatementException;
import model.adt.IMyDictionary;
import model.expressions.IExp;
import model.states.PrgState;
import model.types.BoolIType;
import model.types.IType;
import model.values.BoolValue;
import model.values.IValue;

import java.io.IOException;

public class WhileStatement implements IStmt{
    private final IExp expression;
    private final IStmt statement;

    public WhileStatement(IExp expression , IStmt statement)
    {
        this.expression = expression;
        this.statement = statement;
    }

    @Override
    public PrgState execute(PrgState prgState) throws StatementException, ADTException, IOException {
        IValue value = expression.eval(prgState.getSymTable(),prgState.getHeap());
        if(!value.getType().equals(new BoolIType()))
            throw new StatementException(String.format("While error: %s is not of type boolean",value));

        BoolValue boolValue = (BoolValue) value;
        if(boolValue.getVal())
        {
            prgState.getExeStack().push(new WhileStatement(this.expression,this.statement));
            prgState.getExeStack().push(statement);
        }
        return null;
    }

    @Override
    public IStmt deepCopy() {
        return null;
    }

    @Override
    public IMyDictionary<String, IType> typeCheck(IMyDictionary<String, IType> typeEnv) throws StatementException {
        IType type = expression.typecheck(typeEnv);

        if(!type.equals(new BoolIType()))
            throw new StatementException("WHILE STATEMENT EXCEPTION: The condition is not of type bool.");

        statement.typeCheck(typeEnv.deepCopy());
        return typeEnv;
    }

    @Override
    public String toString() {
        return String.format("While(%s) {%s}", expression, statement);
    }
}

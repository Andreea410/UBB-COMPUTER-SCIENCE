package model.statements;

import exceptions.ADTException;
import exceptions.StatementException;
import model.adt.IMyDictionary;
import model.adt.IMyStack;
import model.expressions.IExp;
import model.expressions.LogicalExpression;
import model.expressions.LogicalOperator;
import model.states.PrgState;
import model.types.IType;

import java.io.IOException;

public class RepeatUntilStatement implements IStmt{

    private final IStmt statement;
    private final IExp condition;

    public RepeatUntilStatement( IExp cond,IStmt stmt) {
        this.statement = stmt;
        this.condition = cond;
    }

    @Override
    public PrgState execute(PrgState prgState) throws StatementException, ADTException, IOException {
        IMyStack<IStmt> stack = prgState.getExeStack();
        IStmt whileStatement = new CompStmt(statement, new WhileStatement(new LogicalExpression(condition, LogicalOperator.NOT, condition), statement));

        stack.push(whileStatement);
        prgState.setExeStack(stack);
        return null;
    }

    @Override
    public IStmt deepCopy() {
        return new RepeatUntilStatement( condition.deepCopy(),statement.deepCopy());
    }

    @Override
    public IMyDictionary<String, IType> typeCheck(IMyDictionary<String, IType> typeEnv) throws StatementException {
        if(!condition.typecheck(typeEnv).equals(new model.types.BoolIType()))
            throw new StatementException("The condition of RepeatUntil is not a boolean");
        statement.typeCheck(typeEnv.deepCopy());
        return typeEnv;
    }

    @Override
    public String toString() {
        return "repeat " + statement.toString() + " until " + condition.toString();
    }
}

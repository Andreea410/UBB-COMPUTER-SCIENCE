package model.statements;

import exceptions.ADTException;
import exceptions.StatementException;
import model.adt.IMyDictionary;
import model.adt.IMyStack;
import model.expressions.IExp;
import model.expressions.VariableExpression;
import model.states.PrgState;
import model.types.BoolIType;
import model.types.IType;
import model.values.IValue;

import java.io.IOException;

public class ConditionalAssignStatement implements IStmt{
    private final String variable;
    private final IExp exp1;
    private final IExp exp2;
    private final IExp exp3;;

    public ConditionalAssignStatement(String var , IExp  e1 , IExp e2, IExp e3)
    {
        this.variable = var;
        this.exp1 = e1;
        this.exp2 = e2;
        this.exp3 = e3;
    }

    @Override
    public PrgState execute(PrgState prgState) throws StatementException, ADTException, IOException {
        IMyStack<IStmt> exeStack = prgState.getExeStack();
        IStmt statement = new IfStmt(exp1 , new AssignStmt(variable , exp2) , new AssignStmt(variable , exp3));
        exeStack.push(statement);
        prgState.setExeStack(exeStack);
        return null;
    }

    @Override
    public IStmt deepCopy() {
        return new ConditionalAssignStatement(this.variable,this.exp1.deepCopy(),this.exp2.deepCopy(),this.exp3.deepCopy());
    }

    @Override
    public IMyDictionary<String, IType> typeCheck(IMyDictionary<String, IType> typeEnv) throws StatementException {
        IType variableType = new VariableExpression(variable).typecheck(typeEnv);
        IType type1 = exp1.typecheck(typeEnv);
        IType type2 = exp2.typecheck(typeEnv);
        IType type3 = exp3.typecheck(typeEnv);
        if(type1.equals(new BoolIType()) && type2.equals(variableType) && type3.equals(variableType))
            return typeEnv;
        else
            throw new StatementException("The types from the conditional assign statement don t match");

    }

    @Override
    public String toString()
    {
        return this.variable + "=(" + this.exp1 + ")?" + this.exp2 +":"+this.exp3;
    }

}

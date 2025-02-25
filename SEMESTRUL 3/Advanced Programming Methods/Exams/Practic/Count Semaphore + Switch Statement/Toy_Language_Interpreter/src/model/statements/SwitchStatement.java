package model.statements;

import exceptions.ADTException;
import exceptions.StatementException;
import model.adt.IMyDictionary;
import model.adt.IMyStack;
import model.expressions.IExp;
import model.expressions.RelationalExpression;
import model.states.PrgState;
import model.types.IType;

import java.io.IOException;

public class SwitchStatement implements IStmt{
    private final IExp mainExpression;
    private final IExp case1;
    private final IStmt statementCase1;
    private final IExp case2;
    private final IStmt statementCase2;
    private final IStmt defaultStatement;

    public SwitchStatement(IExp mainExpression, IExp case1, IStmt statementCase1, IExp case2, IStmt stmtCase2, IStmt defaultStmt) {
        this.mainExpression = mainExpression;
        this.case1 = case1;
        this.statementCase1 = statementCase1;
        this.case2 = case2;
        this.statementCase2 = stmtCase2;
        this.defaultStatement = defaultStmt;
    }

    @Override
    public PrgState execute(PrgState prgState) throws StatementException, ADTException, IOException {
        IMyStack<IStmt> exeStack = prgState.getExeStack();
        IStmt ifStmt = new IfStmt(
                new RelationalExpression( mainExpression,"==", case1),
                statementCase1, new IfStmt(new RelationalExpression( mainExpression, "==",case2), statementCase2, defaultStatement)
        );

        exeStack.push(ifStmt);
        prgState.setExeStack(exeStack);

        return null;
    }

    @Override
    public IStmt deepCopy() {
        return new SwitchStatement(mainExpression.deepCopy(), case1.deepCopy(), statementCase1.deepCopy(), case2.deepCopy(), statementCase2.deepCopy(), defaultStatement.deepCopy());
    }

    @Override
    public IMyDictionary<String, IType> typeCheck(IMyDictionary<String, IType> typeEnv) throws StatementException {
        IType mainType = mainExpression.typecheck(typeEnv);
        IType case1Type = case1.typecheck(typeEnv);
        IType case2Type = case2.typecheck(typeEnv);

        if(mainType.equals(case1Type) && mainType.equals(case2Type))
            return typeEnv;
        else
            throw new StatementException("The types from the switch statement don t match");
    }
}

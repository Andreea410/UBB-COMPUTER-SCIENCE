package model.statements;

import exceptions.ADTException;
import exceptions.StatementException;
import model.adt.IMyDictionary;
import model.adt.IMyStack;
import model.expressions.IExp;
import model.expressions.RelationalExpression;
import model.expressions.VariableExpression;
import model.states.PrgState;
import model.types.IType;
import model.types.IntIType;

import java.io.IOException;

public class ForStatement implements IStmt{
    private final IExp expression1; // v = exp1
    private final IExp expression2; // v < exp2
    private final IExp expression3; // v = exp3
    private final IStmt statement; // for(..) stmt

    public ForStatement(IExp expression1, IExp expression2, IExp expression3, IStmt statement) {
        this.expression1 = expression1;
        this.expression2 = expression2;
        this.expression3 = expression3;
        this.statement = statement;
    }


    @Override
    public PrgState execute(PrgState prgState) throws StatementException, ADTException, IOException {
        IMyStack<IStmt> stack = prgState.getExeStack();

        IStmt newStatement = new CompStmt(
                new VariablesDeclarationStmt("v", new IntIType()),
                new CompStmt(
                        new AssignStmt("v", this.expression1),
                        new WhileStatement(
                                new RelationalExpression( new VariableExpression("v"), "<",this.expression2),
                                new CompStmt(statement, new AssignStmt("v", this.expression3))
                        )
                )
        );
        stack.push(newStatement);
        prgState.setExeStack(stack);
        return null;
    }

    @Override
    public IStmt deepCopy() {
        return new ForStatement(this.expression1.deepCopy(), this.expression2.deepCopy(), this.expression3.deepCopy(), this.statement.deepCopy());
    }

    @Override
    public IMyDictionary<String, IType> typeCheck(IMyDictionary<String, IType> typeEnv) throws StatementException {
        IMyDictionary<String,IType> table1 = new VariablesDeclarationStmt("v", new IntIType()).typeCheck(typeEnv.deepCopy());
        IType vType = table1.getValue("v");
        IType expression1Type = this.expression1.typecheck(table1);
        IType expression2Type = this.expression2.typecheck(table1);
        IType expression3Type = this.expression3.typecheck(table1);

        if(!vType.equals(new IntIType()))
            throw new StatementException("FOR STATEMENT EXCEPTION: Variable v is not of type int");
        if(!expression1Type.equals(new IntIType()))
            throw new StatementException("FOR STATEMENT EXCEPTION: Expression 1 is not of type int");
        if(!expression2Type.equals(new IntIType()))
            throw new StatementException("FOR STATEMENT EXCEPTION: Expression 2 is not of type int");
        if(!expression3Type.equals(new IntIType()))
            throw new StatementException("FOR STATEMENT EXCEPTION: Expression 3 is not of type int");
        return typeEnv;
    }

    @Override
    public String toString() {
        return "for(v = " + expression1 + "; v < " + expression2 + "; v = " + expression3 + "){" + statement + "}";
    }
}

package model.statements;
import exceptions.ExpressionException;
import exceptions.StatementException;
import model.adt.IMyDictionary;
import model.expressions.IExp;
import model.states.PrgState;
import model.types.IType;
import model.values.IValue;

public class PrintStm implements IStmt
{
    private final IExp expression;

    public PrintStm(IExp exp)
    {
        this.expression = exp;
    }

    @Override
    public String toString()
    {
        return "print(" + expression.toString()+")";
    }

    @Override
    public PrgState execute(PrgState prgState)
    {
        IValue result =  expression.eval(prgState.getSymTable(), prgState.getHeap());
        prgState.getOutput().add(result.toString());
        return null;
    }

    @Override
    public IStmt deepCopy() {
        return new PrintStm(this.expression.deepCopy());
    }

    @Override
    public IMyDictionary<String, IType> typeCheck(IMyDictionary<String, IType> typeEnv) throws StatementException , ExpressionException {
        expression.typecheck(typeEnv);
        return typeEnv;
    }

}

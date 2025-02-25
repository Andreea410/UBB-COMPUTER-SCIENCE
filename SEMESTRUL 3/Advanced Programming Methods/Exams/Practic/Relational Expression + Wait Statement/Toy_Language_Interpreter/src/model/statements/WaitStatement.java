package model.statements;

import exceptions.ADTException;
import exceptions.StatementException;
import model.adt.IMyDictionary;
import model.expressions.ValueExpression;
import model.states.PrgState;
import model.types.IType;
import model.types.IntIType;
import model.values.IntIValue;

import java.io.IOException;

public class WaitStatement implements IStmt {
    private final IntIValue number;

    public WaitStatement(IntIValue number) {
        this.number = number;
    }

    @Override
    public PrgState execute(PrgState prgState) throws StatementException, ADTException, IOException {
        if ((Integer) number.getVal() != 0) {
            prgState.getExeStack().push(new WaitStatement(new IntIValue((Integer) number.getVal() - 1)));
            prgState.getExeStack().push(new PrintStm(new ValueExpression(this.number)));
        }
        return null;
    }

    @Override
    public IStmt deepCopy() {
        return new WaitStatement(new IntIValue((Integer) number.getVal()));
    }

    @Override
    public IMyDictionary<String, IType> typeCheck(IMyDictionary<String, IType> typeEnv) throws StatementException {
        if (!number.getType().equals(new IntIType())) {
            throw new StatementException("WaitStatement requires an integer argument!");
        }
        return typeEnv;
    }

    @Override
    public String toString() {
        return "Wait(" + number.toString() + ")";
    }
}

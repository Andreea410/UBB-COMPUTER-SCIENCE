//Compund statement

package model.statements;
import exceptions.StatementException;
import model.states.PrgState;


public class CompStmt implements IStmt{
    private final IStmt statement1;
    private final IStmt statement2;

    public CompStmt(IStmt f , IStmt s)
    {
        statement1 = f;
        statement2 = s;
    }

    @Override
    public String toString()
    {
       return "("+statement1.toString() + ";" + statement2.toString()+")";
    }

    @Override
    public PrgState execute(PrgState prgState) throws StatementException
    {
        prgState.getExeStack().push(statement2);
        prgState.getExeStack().push(statement1);
        return prgState;
    }

    @Override
    public IStmt deepCopy() {
        return new CompStmt(this.statement1.deepCopy() , this.statement2.deepCopy());
    }


}

package model.statements;
import exceptions.ExpressionException;
import model.states.PrgState;
import model.types.IType;


public class VariablesDeclarationStmt implements IStmt {
    private final String name;
    private final IType type;

    public VariablesDeclarationStmt(String n , IType t)
    {
        this.name = n;
        this.type = t;
    }

    @Override
    public PrgState execute(PrgState prgState) throws ExpressionException
    {
        if(prgState.getSymTable().contains(this.name))
            throw new ExpressionException("A variable with the same name already exists");
        prgState.getSymTable().insert(name,this.type.getDefaultValue());
        return prgState;
    }

    @Override
    public String toString()
    {
        return name;
    }

}

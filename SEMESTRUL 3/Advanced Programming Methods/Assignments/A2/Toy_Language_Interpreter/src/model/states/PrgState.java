package model.states;
import model.adt.*;
import model.statements.IStmt;
import model.values.IValue;


public class PrgState {
    private IStmt statement;
    protected IMyStack<IStmt> exeStack;

    public IMyStack<IStmt> getExeStack() {
        return exeStack;
    }

    public void setExeStack(IMyStack<IStmt> exeStack) {
        this.exeStack = exeStack;
    }

    public IMyDictionary<String, IValue> getSymTable() {
        return symTable;
    }

    public void setSymTable(IMyDictionary<String, IValue> symTable) {
        this.symTable = symTable;
    }

    protected IMyDictionary<String , IValue> symTable;
    protected IMyList<String> output;
    protected IStmt originalProgram;

    public PrgState(IStmt statement)
    {
        this.statement = statement;
        this.exeStack = new MyStack<>();
        this.symTable = new MyDictionary<>();
        this.output = new MyList<>();

        exeStack.push(statement);
    }

    public PrgState(IMyStack<IStmt> e , IMyDictionary<String,IValue> dictionary , IMyList<String> list , IStmt InitialStatement)
    {
        this.exeStack = e;
        this.symTable = dictionary;
        this.output = list;
        exeStack.push(InitialStatement);
    }

    @Override
    public String toString()
    {
        return symTable.toString() + " " + exeStack.toString() + " " + output.toString();
    }

    public IMyList<String> getOutput()
    {
        return this.output;
    }
}

package model.states;
import exceptions.EmptyStackException;
import model.adt.*;
import model.statements.IStmt;
import model.values.IValue;
import model.values.StringValue;
import java.io.BufferedReader;
import java.io.IOException;



public class PrgState {
    //PROGRAM STATE STRUCTURE
    private final int id;
    private static int lastIndex;
    protected IMyStack<IStmt> exeStack;
    protected IMyDictionary<String , IValue> symTable;
    protected IMyList<String> output;
    protected IStmt originalProgram;
    private final IMyDictionary<StringValue, BufferedReader> fileTable;
    private IMyHeap heap;


    //CONSTRUCTOR
    public PrgState(IStmt statement)
    {
        this.exeStack = new MyStack<>();
        this.symTable = new MyDictionary<>();
        this.output = new MyList<>();
        this.fileTable = new MyDictionary<>();
        this.heap = new MyHeap();
        this.originalProgram = statement.deepCopy();
        exeStack.push(statement);
        this.id = getNewId();
    }

    //CONSTRUCTOR
    public PrgState(IMyStack<IStmt> e , IMyDictionary<String,IValue> dictionary , IMyList<String> list , IStmt InitialStatement , IMyDictionary<StringValue , BufferedReader> fileTable , IMyHeap heap)
    {
        this.exeStack = e;
        this.symTable = dictionary;
        this.output = list;
        this.fileTable = fileTable;
        this.heap = heap;
        this.originalProgram = InitialStatement.deepCopy();
        exeStack.push(InitialStatement);
        this.id = getNewId();
    }

    public IMyDictionary<StringValue,BufferedReader> getFileTable()
    {
        return this.fileTable;
    }

    public IMyHeap getHeap()
    {
        return this.heap;
    }

    public void setHeap(IMyHeap heap)
    {
        this.heap = heap;
    }

    public String HeapToString()
    {
        StringBuilder answer = new StringBuilder();
            for(Integer key: heap.getMap().keySet()){
                answer.append(key).append("(").append(heap.getValue(key).getType().toString())
                        .append(")").append(":-> ").
                        append(heap.getValue(key).toString()).append("\n");
            }
        return answer.toString();
    }

    @Override
    public String toString() {

        return "ID = " +
                this.id +
                "\n" +
                "Execution Stack = " +
                exeStack.toString() +
                "\n" +
                "SymTable = " +
                symTable.toString() +
                "\n" +
                "Output List = " +
                output.toString() +
                "\n" +
                "File Table = " +
                fileTable.toString() +
                "\n" +
                "Heap = " +
                HeapToString() +
                "\n" +
                "====================>" +
                "\n";
    }

    public IMyList<String> getOutput()
    {
        return this.output;
    }

    public boolean isNotCompleted()
    {
        return !this.exeStack.isEmpty();
    }

    public PrgState executeOneStep() throws EmptyStackException, IOException {
        if(exeStack.isEmpty())
            throw new EmptyStackException("Execution Stack Error: Execution stack is empty");

        IStmt currentStatement = exeStack.pop();
        return currentStatement.execute(this);

    }

    public IMyStack<IStmt> getExeStack() {
        return exeStack;
    }

    private synchronized int getNewId()
    {
        lastIndex++;
        return lastIndex;
    }


    public IMyDictionary<String, IValue> getSymTable() {
        return symTable;
    }

    public int getId()
    {
        return this.id;
    }
}

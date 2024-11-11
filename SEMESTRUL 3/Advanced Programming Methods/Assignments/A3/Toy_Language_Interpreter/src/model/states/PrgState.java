package model.states;
import model.adt.*;
import model.statements.IStmt;
import model.values.IValue;
import model.values.StringValue;

import java.io.BufferedReader;

import java.nio.Buffer;


public class PrgState {
    protected IMyStack<IStmt> exeStack;
    protected IMyDictionary<String , IValue> symTable;
    protected IMyList<String> output;
    protected IStmt originalProgram;
    private IMyDictionary<StringValue, BufferedReader> fileTable;

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

    public PrgState(IStmt statement)
    {
        this.exeStack = new MyStack<>();
        this.symTable = new MyDictionary<>();
        this.output = new MyList<>();
        this.fileTable = new MyDictionary<>();
        exeStack.push(statement);
    }

    public PrgState(IMyStack<IStmt> e , IMyDictionary<String,IValue> dictionary , IMyList<String> list , IStmt InitialStatement , MyDictionary<StringValue , BufferedReader> fileTable)
    {
        this.exeStack = e;
        this.symTable = dictionary;
        this.output = list;
        this.fileTable = fileTable;
        exeStack.push(InitialStatement);
    }

    public IMyDictionary<StringValue,BufferedReader> getFileTable()
    {
        return this.fileTable;
    }

    public String fileTableToString()
    {
        StringBuilder text = new StringBuilder();
        for(StringValue key : this.fileTable.getKeys())
            text.append(key).append("\n");
        return text.toString();
    }

    public String symTableToString() {
        StringBuilder symbolTableStringBuilder = new StringBuilder();

        for (String key : symTable.getKeys()) {
            symbolTableStringBuilder.append(String.format("%s -> %s\n", key, symTable.getValue(key).toString()));
        }

        return symbolTableStringBuilder.toString();
    }

    @Override
    public String toString() {
        return String.format("EXE_STACK\n%s\nSYM_TABLE\n%s\nOUT\n%s\nFILE_TABLE\n%s\n", exeStack.toString(), symTableToString(), output.toString(), fileTableToString());
    }

    public IMyList<String> getOutput()
    {
        return this.output;
    }


}

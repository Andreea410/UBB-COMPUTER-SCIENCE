package model.statements;

import exceptions.ADTException;
import exceptions.EmptyStackException;
import exceptions.StatementException;
import model.adt.IMyDictionary;
import model.adt.IMyStack;
import model.states.PrgState;
import model.types.IType;

import java.io.IOException;

public class ReturnStatement implements IStmt {

    @Override
    public PrgState execute(PrgState prgState) throws StatementException, ADTException, IOException, EmptyStackException {
        IMyStack<IStmt> exeStack = prgState.getExeStack();
        // Removing the top frame from the symbol table stack to simulate exiting the current procedure
        prgState.getSymTable().pop();
        return null;
    }


    @Override
    public IStmt deepCopy() {
        return new ReturnStatement();
    }

    @Override
    public IMyDictionary<String, IType> typeCheck(IMyDictionary<String, IType> typeEnv) throws StatementException {
        return typeEnv;
    }

    @Override
    public String toString() {
        return "return";
    }
}

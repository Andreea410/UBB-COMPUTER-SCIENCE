package model.statements;

import exceptions.ADTException;
import exceptions.StatementException;
import model.adt.IMyDictionary;
import model.states.PrgState;
import model.types.IType;

import java.io.IOException;

public interface IStmt {
    PrgState execute(PrgState prgState) throws StatementException, ADTException, IOException;
    IStmt deepCopy();
    IMyDictionary<String , IType> typeCheck(IMyDictionary<String , IType> typeEnv) throws StatementException;
}

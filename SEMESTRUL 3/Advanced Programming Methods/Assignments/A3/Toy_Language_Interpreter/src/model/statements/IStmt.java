package model.statements;

import exceptions.ADTException;
import exceptions.StatementException;
import model.states.PrgState;

import java.io.IOException;

public interface IStmt {
    PrgState execute(PrgState prgState) throws StatementException, ADTException, IOException;
    IStmt deepCopy();
}

package model.statements;

import exceptions.ADTException;
import exceptions.StatementException;
import model.states.PrgState;

public interface IStmt {
    PrgState execute(PrgState prgState) throws StatementException , ADTException;
}

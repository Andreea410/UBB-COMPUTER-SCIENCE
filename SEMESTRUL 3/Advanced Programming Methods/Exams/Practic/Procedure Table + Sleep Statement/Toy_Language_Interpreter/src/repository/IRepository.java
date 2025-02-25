package repository;

import exceptions.RepoException;
import model.adt.IMyProcedureTable;
import model.statements.IStmt;
import model.states.PrgState;

import java.util.List;

public interface IRepository
{
    List<PrgState> getStates();
    void addProgram(PrgState program);
    void logPrgStateExec(PrgState prgState) throws RepoException;
    List<PrgState> getPrgStatesList();
    void setPrgList(List<PrgState> programStates);
    void clearLogFile(PrgState prgState) throws RepoException;
    Integer getProgramStatesCount();
    void setProcedureTable(IMyProcedureTable procedureTable);
    public void addProcedure(String procName, List<String> procParams , IStmt procBody);

}

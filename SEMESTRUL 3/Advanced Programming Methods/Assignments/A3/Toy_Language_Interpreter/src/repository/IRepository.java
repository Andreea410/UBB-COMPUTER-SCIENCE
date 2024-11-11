package repository;

import exceptions.RepoException;
import model.states.PrgState;

import java.util.List;

public interface IRepository
{
    List<PrgState> getStates();
    PrgState getCurrentProgram();
    void addProgram(PrgState program);
    public void logPrgStateExec() throws RepoException;

}

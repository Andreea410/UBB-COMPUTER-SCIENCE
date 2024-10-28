package repository;

import model.states.PrgState;

public interface IRepository
{
    PrgState getCurrentProgram();
    void addProgram(PrgState program);
}

package repository;

import model.states.PrgState;

import java.util.LinkedList;
import java.util.List;

public class Repository implements IRepository
{
    private final List<PrgState> programs;
    private int currentProgramIndex;

    public Repository()
    {
        this.programs = new LinkedList<>();
        this.currentProgramIndex = 0;
    }

    @Override
    public PrgState getCurrentProgram()
    {
        return this.programs.get(this.currentProgramIndex);
    }

    @Override
    public void addProgram(PrgState program)
    {
        this.programs.add(program);
    }

}

package repository;

import exceptions.RepoException;
import model.statements.PrintStm;
import model.states.PrgState;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.LinkedList;
import java.util.List;

public class Repository implements IRepository
{
    private final List<PrgState> programs;
    private int currentProgramIndex;
    private final String filename;

    public Repository(String file)
    {
        this.programs = new LinkedList<>();
        this.currentProgramIndex = 0;
        this.filename = file;
    }

    @Override
    public List<PrgState> getStates()
    {
        return this.programs;
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

    @Override
    public void logPrgStateExec() throws RepoException
    {
        try
        {
            PrintWriter writer = new PrintWriter(new BufferedWriter(new FileWriter(filename , true)));
            writer.println(this.getCurrentProgram().toString());
            writer.close();
        } catch (IOException e) {
            throw new RepoException("File doesn't exit");
        }
    }

}

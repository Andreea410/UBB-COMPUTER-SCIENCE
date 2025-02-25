package repository;

import exceptions.RepoException;
import model.adt.IMyProcedureTable;
import model.statements.IStmt;
import model.states.PrgState;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.LinkedList;
import java.util.List;

public class Repository implements IRepository
{
    private List<PrgState> programs;
    private final String filename;

    public Repository(String file)
    {
        this.programs = new LinkedList<>();
        this.filename = file;
    }

    @Override
    public List<PrgState> getStates()
    {
        return this.programs;
    }

    @Override
    public void addProgram(PrgState program)
    {
        this.programs.add(program);
    }

    @Override
    public void logPrgStateExec(PrgState prgState) throws RepoException
    {
        try
        {
            PrintWriter writer = new PrintWriter(new BufferedWriter(new FileWriter(filename , true)));
            writer.println(prgState.toString());
            writer.close();
        } catch (IOException e) {
            throw new RepoException("File doesn't exit");
        }
    }

    @Override
    public void clearLogFile(PrgState prgState) throws RepoException {
        try {
            PrintWriter clearWriter = new PrintWriter(new FileWriter(filename));
            clearWriter.close();
        } catch (IOException e) {
            throw new RepoException("File doesn't exist");
        }
    }


    @Override
    public List<PrgState> getPrgStatesList() {
        return this.programs;
    }

    @Override
    public void setPrgList(List<PrgState> programStates) {
        this.programs.clear();
        this.programs = programStates;
    }

    @Override
    public Integer getProgramStatesCount() {
        return this.programs.size();
    }

    @Override
    public void setProcedureTable(IMyProcedureTable procedureTable) {
        for (PrgState program : programs) {
            program.setProcedureTable(procedureTable);
        }
    }

    @Override
    public void addProcedure(String name, List<String> arguments , IStmt statement) {
        for (PrgState program : programs) {
            program.addProcedure(name, arguments, statement);
        }
    }





}

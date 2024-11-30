package view.commands;

import controller.Controller;
import exceptions.CommandException;
import exceptions.EmptyStackException;

import java.io.IOException;

public class RunExampleCommand extends Command {

    private final Controller controller;

    public RunExampleCommand(String key , String description , Controller controller)
    {
        super(key , description);
        this.controller = controller;
    }

    @Override
    public void execute() throws CommandException {
        try {
            controller.allStep();
        }
        catch (InterruptedException e)
        {
            throw new CommandException(e.getMessage());
        }
    }
}

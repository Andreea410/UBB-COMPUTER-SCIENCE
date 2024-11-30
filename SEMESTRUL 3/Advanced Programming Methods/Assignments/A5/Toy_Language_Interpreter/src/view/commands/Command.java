package view.commands;

import exceptions.CommandException;
import exceptions.EmptyStackException;

import java.io.IOException;

public abstract class Command
{
    private String key;
    public String description;

    public Command(String key , String description)
    {
        this.key = key;
        this.description = description;
    }

    public abstract void execute() throws CommandException;

    public String getDescription() {
        return description;
    }

    public String getKey() {
        return key;
    }
}

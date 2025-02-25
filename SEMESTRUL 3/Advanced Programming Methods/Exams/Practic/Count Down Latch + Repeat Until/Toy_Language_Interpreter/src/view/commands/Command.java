package view.commands;

import exceptions.CommandException;


public abstract class Command
{
    private final String key;
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

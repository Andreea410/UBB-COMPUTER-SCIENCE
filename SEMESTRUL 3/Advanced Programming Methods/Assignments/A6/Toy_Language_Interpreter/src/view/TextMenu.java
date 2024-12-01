package view;

import exceptions.CommandException;
import view.commands.Command;
import java.util.HashMap;
import java.util.Map;
import java.util.NoSuchElementException;
import java.util.Scanner;

public class TextMenu {

    private final Map<String, Command> map;

    public TextMenu()
    {
        this.map = new HashMap<>();
    }

    public void addCommand(Command cm)
    {
        this.map.put(cm.getKey() , cm);
    }

    private void printMenu()
    {
        for(Command cm : this.map.values())
        {
            String line = String.format("%s : %s" , cm.getKey(),cm.getDescription());
            System.out.println(line);
        }
    }

    public void show(){
        Scanner sc = new Scanner(System.in);
        while(true)
        {
            printMenu();
            System.out.println("Option is: ");
            try {
                String line = sc.nextLine();
                Command cm = this.map.get(line);
                if (cm == null) {
                    System.out.println("Invalid command");
                    continue;
                }
                cm.execute();
            }
            catch (CommandException | NoSuchElementException | IllegalStateException e)
            {
                System.out.println(e.getMessage());
            }
        }
    }


}

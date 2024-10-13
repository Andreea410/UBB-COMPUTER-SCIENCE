package view;
import controller.Controller;
import model.Cube;
import model.Cylinder;
import model.IGeometricForm;
import model.Sphere;
import repository.Repo;

import java.security.KeyStore;
import java.util.Arrays;
import java.util.Scanner;

public class View
{
    Controller controller;

    public View(Controller c)
    {
        this.controller = c;
    }

    void displayMenu()
    {
        System.out.println("------Menu-------");
        System.out.println("1.Add the geometric forms");
        System.out.println("2.Display all items");
        System.out.println("3.Filter by volume");
        System.out.println("0.Exit");

    }

    int userOption()
    {
        System.out.println("Please choose an option from above: ");
        Scanner scanner =  new Scanner(System.in);
        int option = -1;
        option = scanner.nextInt();
        return option;

    }

    public void run()
    {
        int option = 1;
        while(option != 0) {
            displayMenu();
            option = userOption();
            switch (option)
            {
                case 0:
                    System.exit(0);
                case 1://add the geometric forms
                    populateList();
                    break;
                case 2://display all geometric forms
                    displayAll();
                    break;
                case 3:
                    filterForms();
                    break;
            }
        }
    }

    void populateList()
    {
        Sphere s = new Sphere(10);
        Cube c = new Cube(20);
        Cylinder cy = new Cylinder(30);
        Cube c1 = new Cube(23);
        Sphere s2 = new Sphere(28);

        try {
            controller.add(s);
            controller.add(c);
            controller.add(cy);
            controller.add(c1);
            controller.add(s2);

        }
        catch (Exception e)
        {
            System.out.println("Exception: " + e.getMessage());
        }

    }

    void displayAll()
    {
        if(controller.getRepo().getLength() == 0) {
            System.out.println("There are no elements in the list");
            return;
        }
        IGeometricForm[] all = controller.getRepo().getAll();
        for(int i = 0;i < controller.getRepo().getLength();i++)
        {
            System.out.println(all[i].toString());
        }
    }

    void filterForms()
    {
        if(controller.filteredList(25) == null) {
            System.out.println("There are no elements in the list");
            return;
        }
        IGeometricForm[] all = controller.filteredList(25);
        for(int i = 0;i < controller.filteredList(25).length;i++)
        {
            if(all[i] == null)
            {
                break;
            }
            System.out.println(all[i].toString());
        }
    }


}

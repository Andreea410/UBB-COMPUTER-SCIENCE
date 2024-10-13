//TIP To <b>Run</b> code, press <shortcut actionId="Run"/> or
// click the <icon src="AllIcons.Actions.Execute"/> icon in the gutter.

import controller.Controller;
import exceptions.RepoException;
import model.IGeometricForm;
import model.Sphere;
import repository.Repo;
import view.View;


public class Main {
    public static void main(String[] args) {
        Repo r = new Repo();
        Controller c = new Controller(r);
        View v = new View(c);
        v.run();

    }
}

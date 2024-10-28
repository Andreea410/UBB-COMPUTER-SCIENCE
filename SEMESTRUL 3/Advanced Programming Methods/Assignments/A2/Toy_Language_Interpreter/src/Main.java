import controller.Controller;
import repository.IRepository;
import repository.Repository;
import view.View;

public class Main {
    public static void main(String[] args) {
        IRepository repository = new Repository();
        Controller controller = new Controller(repository , false);
        View view = new View(controller);
        view.run();

    }
}



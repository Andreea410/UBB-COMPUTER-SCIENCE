module Toy.Language.Interpreter {
    requires javafx.controls;
    requires javafx.fxml;
    requires java.desktop;
    requires java.net.http;

    exports view.gui to javafx.graphics;
    exports view.gui.selectwindow to javafx.fxml;

    opens view.gui.selectwindow to javafx.fxml;

    opens view.gui.executewindow to javafx.fxml;
}

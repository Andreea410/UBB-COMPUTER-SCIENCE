package view.gui;

import javafx.application.Application;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;
import view.gui.executewindow.ExecuteStatementController;
import view.gui.selectwindow.SelectStatementController;

import java.io.IOException;

public class GUI extends Application {
    @Override
    public void start(Stage primaryStage) {

        try {
            FXMLLoader loader = new FXMLLoader(getClass().getResource("/view/gui/selectwindow/SelectStatementWindow.fxml"));
            Parent root = loader.load();
            Scene selectScene = new Scene(root, 720, 500);

            SelectStatementController controller = loader.getController();

            primaryStage.setTitle("Select Statement");
            primaryStage.setScene(selectScene);
            primaryStage.show();


        } catch (IOException e) {
            e.printStackTrace();
        }

    }

    public static void main(String[] args) {
        launch();
    }
}

package view.gui.executewindow;

import controller.Controller;
import javafx.application.Platform;
import javafx.beans.Observable;
import javafx.beans.property.SimpleIntegerProperty;
import javafx.beans.property.SimpleObjectProperty;
import javafx.beans.property.SimpleStringProperty;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.scene.control.*;
import model.adt.*;
import model.statements.IStmt;
import model.statements.IfStmt;
import model.states.PrgState;
import model.values.IValue;
import model.values.StringValue;

import java.awt.event.ActionEvent;
import java.awt.event.MouseEvent;
import java.io.BufferedReader;
import java.util.*;


public class ExecuteStatementController {

    private Controller controller;

    @FXML
    private TextField numberProgramStatesTextField;

    @FXML
    private TableView<MyPair<Integer,IValue>> heapTableView;
    @FXML
    private TableColumn<MyPair<Integer,IValue>,Integer> addressColumn;
    @FXML
    private TableColumn<MyPair<Integer,IValue>, IValue> valueColumn;
    @FXML
    private Label heapLabel;

    @FXML
    private ListView<String> outputListView;
    @FXML
    private Label outputLabel;

    @FXML
    private ListView<String> fileTableListView;
    @FXML
    private Label fileTableLabel;

    @FXML
    private ListView<Integer> identifiersListView;
    @FXML
    private Label identifiersLabel;

    @FXML
    private TableView<MyPair<String,IValue>> SymTableView;
    @FXML
    private TableColumn<MyPair<String,IValue>,String> variableNameColumn;
    @FXML
    private TableColumn<MyPair<String,IValue>,IValue> valueColumnSymTable;
    @FXML
    private Label symTableLabel;

    @FXML
    private TableView<Map.Entry<Integer,MyTuple<Integer,List<Integer>,Integer>>> semaphoreTableView;
    @FXML
    private TableColumn<Map.Entry<Integer,MyTuple<Integer,List<Integer>,Integer>>,Integer> semaphoreTableIndexColumn;
    @FXML
    private TableColumn<Map.Entry<Integer,MyTuple<Integer,List<Integer> , Integer>>,Integer> semaphoreTableValueColumn;
    @FXML
    private TableColumn<Map.Entry<Integer,MyTuple<Integer,List<Integer>,Integer>>,List<Integer>> semaphoreTableListValuesColumn;

    @FXML
    private ListView<String> executionStackListView;
    @FXML
    private Label executionStackLabel;

    @FXML
    private Button runOneStepButton;


    @FXML
    public void initialize(IStmt programStatement) {
        populateTables();
        identifiersListView.getSelectionModel().selectedItemProperty().addListener((observable, oldValue, newValue) -> {
            populateExecutionStack();
            populateSymTable();
        });
    }


    public void setController(Controller controller) {
        this.controller = controller;
        populateTables();
    }

    private void populateTables() {
        populateHeapTable();
        populateSymTable();
        populateExecutionStack();
        populateOutput();
        populateFileTable();
        populateIdentifiers();
        populateNumberProgramStates();
        populateSemaphoreTable();
    }


    //Functions to populate the tables

    @FXML
    private void changeProgramState(javafx.scene.input.MouseEvent mouseEvent)
    {
        populateExecutionStack();
        populateSymTable();
    }

    private PrgState getCurrentProgramState() {
        if (controller.getProgramStateList().isEmpty()) {
            return null;
        }
        int id = identifiersListView.getSelectionModel().getSelectedIndex();
        if (id == -1) {
            return controller.getProgramStateList().get(0);
        } else {
            return controller.getProgramStateList().get(id);
        }
    }


    //Functions to populate the tables

    private void populateHeapTable() {
        ObservableList<MyPair<Integer, IValue>> heapData = FXCollections.observableArrayList(
                controller.getProgramStateList().get(0).getHeap().getMap().entrySet().stream()
                        .map(entry -> new MyPair<>(entry.getKey(), entry.getValue()))
                        .toList()
        );

        addressColumn.setCellValueFactory(data -> new SimpleIntegerProperty(data.getValue().getFirst()).asObject());
        valueColumn.setCellValueFactory(data -> new SimpleObjectProperty<>(data.getValue().getSecond()));
        heapTableView.setItems(heapData);

    }




    private void populateSymTable() {
        int selectedProgramStateIndex = identifiersListView.getSelectionModel().getSelectedIndex();
        if (selectedProgramStateIndex == -1 || selectedProgramStateIndex >= controller.getProgramStateList().size()) {
            System.out.println("No program state selected.");
            return;
        }

        ObservableList<MyPair<String, IValue>> symTableData = FXCollections.observableArrayList(
                controller.getProgramStateList().get(selectedProgramStateIndex).getSymTable().getContent().entrySet().stream()
                        .map(entry -> new MyPair<>(entry.getKey(), entry.getValue()))
                        .toList()
        );

        variableNameColumn.setCellValueFactory(data -> new SimpleStringProperty(data.getValue().getFirst()));
        valueColumnSymTable.setCellValueFactory(data -> new SimpleObjectProperty<>(data.getValue().getSecond()));
        SymTableView.setItems(symTableData);
        SymTableView.refresh();

    }


    private void populateExecutionStack()
    {
        PrgState currentProgramState = getCurrentProgramState();
        IMyStack<IStmt> executionStack = Objects.requireNonNull(currentProgramState).getExeStack();
        ArrayList<IStmt> executionStackContent = new ArrayList<>();
        for(IStmt stmt: executionStack.getStack())
            executionStackContent.add(stmt);
        executionStackListView.getItems().clear();
        for(IStmt stmt: executionStackContent)
            executionStackListView.getItems().add(stmt.toString());

    }

    private void populateOutput()
    {
        PrgState currentProgramState = getCurrentProgramState();
        var output = Objects.requireNonNull(currentProgramState).getOutput();
        ArrayList<String> outputContent = new ArrayList<>();
        for(String entry: output.getList())
            outputContent.add(entry);
        outputListView.getItems().clear();
        for(String entry: outputContent)
            outputListView.getItems().add(entry);
    }

    private void populateFileTable()
    {
        PrgState currentProgramState = getCurrentProgramState();
        var fileTable = Objects.requireNonNull(currentProgramState).getFileTable();
        ArrayList<MyPair<StringValue, BufferedReader>> fileTableContent = new ArrayList<>();
        for(StringValue key: fileTable.getContent().keySet())
            fileTableContent.add(new MyPair<>(key,fileTable.getContent().get(key)));
        fileTableListView.getItems().clear();
        for(MyPair<StringValue,BufferedReader> entry: fileTableContent)
        {
            fileTableListView.getItems().add(entry.getFirst().toString());
            fileTableListView.getItems().add(entry.getSecond().toString());
        }
    }

    private void populateIdentifiers() {
        ObservableList<Integer> identifiers = FXCollections.observableArrayList();
        for (PrgState prgState : controller.getProgramStateList()) {
            if(!prgState.getExeStack().isEmpty())
                identifiers.add(prgState.getId());
        }
        identifiersListView.setItems(identifiers);
    }

    private void populateSemaphoreTable()
    {
        PrgState currentProgramState = getCurrentProgramState();
        IMySemaphoreTable semaphoreTable = Objects.requireNonNull(currentProgramState).getSemaphoreTable();
        ArrayList<Map.Entry<Integer,MyTuple<Integer,List<Integer>,Integer>> > semaphoreTableContent = new ArrayList<>();
        for(Map.Entry<Integer,MyTuple<Integer,List<Integer>,Integer>> entry: semaphoreTable.getContent().entrySet())
            semaphoreTableContent.add(entry);
        semaphoreTableView.getItems().clear();
        for(Map.Entry<Integer,MyTuple<Integer,List<Integer>,Integer>> entry: semaphoreTableContent)
        {
            semaphoreTableView.getItems().add(entry);
        }

        semaphoreTableListValuesColumn.setCellValueFactory(data -> new SimpleObjectProperty<>(data.getValue().getValue().getSecond()));
        semaphoreTableIndexColumn.setCellValueFactory(data -> new SimpleIntegerProperty(data.getValue().getKey()).asObject());
        semaphoreTableValueColumn.setCellValueFactory(data -> new SimpleIntegerProperty(data.getValue().getValue().getFirst()).asObject());

    }


    private void populateNumberProgramStates()
    {
        numberProgramStatesTextField.setText(String.valueOf(controller.getProgramStateList().size()));
    }

    private void showErrorMessage(String message)
    {
        Alert alert = new Alert(Alert.AlertType.ERROR);
        alert.setTitle("Error");
        alert.setHeaderText("Error");
        alert.setContentText(message);
        alert.showAndWait();
    }

    @FXML
    public void handleRunOneStep()
    {
        try {
            controller.runOneStep();
            populateTables();
        } catch (Exception e) {
            showErrorMessage(e.getMessage());
        }
    }


}

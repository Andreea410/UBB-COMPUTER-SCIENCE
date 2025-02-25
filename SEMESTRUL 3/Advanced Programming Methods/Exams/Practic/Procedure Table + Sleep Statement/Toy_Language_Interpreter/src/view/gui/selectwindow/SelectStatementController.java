package view.gui.selectwindow;

import controller.Controller;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Alert;
import javafx.scene.control.ListView;
import javafx.scene.control.Label;
import javafx.scene.control.Button;
import javafx.event.ActionEvent;
import javafx.stage.Stage;
import model.adt.IMyProcedureTable;
import model.adt.MyDictionary;
import model.adt.MyPair;
import model.adt.MyProcedureTable;
import model.expressions.*;
import model.statements.*;
import model.types.BoolIType;
import model.types.IntIType;
import model.types.RefType;
import model.types.StringType;
import model.values.BoolValue;
import model.values.IntIValue;
import model.values.StringValue;
import repository.IRepository;
import repository.Repository;
import view.gui.executewindow.ExecuteStatementController;

import java.io.IOException;
import java.net.URL;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.ResourceBundle;

public class SelectStatementController implements Initializable {

    //ATTRIBUTES
    private ExecuteStatementController executeController;
    IStmt selectedStatement;
    List<IStmt> statements = new ArrayList<>();

    //FXML ATRIBUTES
    @FXML
    private ListView<IStmt> statementsListView;

    @FXML
    private Label selectStatementLabel;

    @FXML
    private Button executeButton;

    //METHODS
    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
        populateStatements();
        for(IStmt statement : statements)
        {
            statementsListView.getItems().add(statement);
        }
        this.statementsListView.getSelectionModel().selectedItemProperty().addListener((observable, oldValue, newValue) -> {
            this.selectedStatement = statementsListView.getSelectionModel().getSelectedItem();
            this.selectStatementLabel.setText("Selected statement: " + this.selectedStatement);
        });
    }

    public void setExecuteController(ExecuteStatementController executeController) {
        this.executeController = executeController;
    }

    @FXML
    private void handleExecuteButtonAction(ActionEvent event) {
        int selectedStmtIndex = statementsListView.getSelectionModel().getSelectedIndex();
        if(selectedStmtIndex == -1) {
            Alert alert = new Alert(Alert.AlertType.ERROR);
            alert.setTitle("Error");
            alert.setHeaderText("No statement selected");
            alert.setContentText("Please select a statement from the list.");
            alert.showAndWait();
        }
        else {
            IStmt selectedStatement = statements.get(selectedStmtIndex);
            selectedStmtIndex++;
            IRepository repository = new Repository("log" + selectedStmtIndex + ".txt");
            Controller controller = new Controller(repository);
            controller.addProgram(selectedStatement);
            if(selectedStmtIndex == 11)
            {
                controller.setProcedureTable(createProcedureTable());
            }
            showExecutionWindow(selectedStatement,controller);
        }
    }

    private IMyProcedureTable createProcedureTable() {
        IMyProcedureTable procedureTable = new MyProcedureTable();

        List<String> varSum = new ArrayList<>();
        varSum.add("a");
        varSum.add("b");
        IStmt sumProc = new CompStmt(
                new VariablesDeclarationStmt("localV", new IntIType()),
                new CompStmt(
                        new AssignStmt("localV", new ArithmeticalExpression(new VariableExpression("a"), ArithmeticalOperator.ADD, new VariableExpression("b"))),
                        new PrintStm(new VariableExpression("localV"))
                )
        );
        procedureTable.put("sum", new MyPair<>(varSum, sumProc));

        List<String> varProd = new ArrayList<>();
        varProd.add("c");
        varProd.add("d");
        IStmt prodProc = new CompStmt(
                new VariablesDeclarationStmt("local-v", new IntIType()),
                new CompStmt(
                        new AssignStmt("local-v", new ArithmeticalExpression(new VariableExpression("c"), ArithmeticalOperator.MULTIPLY, new VariableExpression("d"))),
                        new PrintStm(new VariableExpression("local-v"))
                )
        );
        procedureTable.put("product", new MyPair<>(varProd, prodProc));

        return procedureTable;
    }


    private void showExecutionWindow(IStmt selectedStatement,Controller controller) {
        try {
            FXMLLoader loader = new FXMLLoader(getClass().getResource("/view/gui/executewindow/ExecuteStatementWindow.fxml"));
            Parent root = loader.load();

            selectedStatement.typeCheck(new MyDictionary<>());

            ExecuteStatementController executeStatementController = loader.getController();
            executeStatementController.setController(controller);
            executeStatementController.initialize(selectedStatement);

            Stage stage = new Stage();
            stage.setTitle("Execute Statement");
            stage.setScene(new Scene(root));
            stage.show();
        } catch (IOException e) {
            e.printStackTrace();
        }

    }


    private void populateStatements()
    {
        IStmt statement1 = new CompStmt(new VariablesDeclarationStmt("v", new IntIType()),
                new CompStmt(new AssignStmt("v", new ValueExpression(new IntIValue(2))),
                        new PrintStm(new VariableExpression("v"))));
        statements.add(statement1);

        // int a; int b; a=2+3*5; b=a+1; Print(b)
        IStmt statement2 = new CompStmt(new VariablesDeclarationStmt("a",new IntIType()),
                new CompStmt(new VariablesDeclarationStmt("b",new IntIType()),
                        new CompStmt(new AssignStmt("a", new ArithmeticalExpression(new ValueExpression(new IntIValue(2)), ArithmeticalOperator.ADD,new
                                ArithmeticalExpression(new ValueExpression(new IntIValue(3)),ArithmeticalOperator.MULTIPLY,new ValueExpression(new IntIValue(5))))),
                                new CompStmt(new AssignStmt("b",new ArithmeticalExpression(new VariableExpression("a"), ArithmeticalOperator.ADD,new ValueExpression(new
                                        IntIValue(1)))), new PrintStm(new VariableExpression("b"))))));
        statements.add(statement2);

        // bool a; int v; a=true; (If a Then v=2 Else v=3); Print(v)
        IStmt statement3 = new CompStmt(new VariablesDeclarationStmt("a", new BoolIType()),
                new CompStmt(new VariablesDeclarationStmt("v", new IntIType()),
                        new CompStmt(new AssignStmt("a", new ValueExpression(new BoolValue(true))),
                                new CompStmt(new IfStmt(new VariableExpression("a"),
                                        new AssignStmt("v", new ValueExpression(new IntIValue(2))),
                                        new AssignStmt("v", new ValueExpression(new IntIValue(3)))),
                                        new PrintStm(new VariableExpression("v"))))));

        statements.add(statement3);

        // string varf; varf = "test.in"; OpenReadFile("varf"); int varc; ReadFile("varf", "varc"); Print(varc); ReadFile("varf", "varc"); Print(varc); CloseReadFile("varf")
        IStmt statement4 = new CompStmt(new VariablesDeclarationStmt("varf", new StringType()),
                new CompStmt(new AssignStmt("varf", new ValueExpression(
                        new StringValue("test.in"))),
                        new CompStmt(new OpenReadFileStatement(new VariableExpression("varf")),
                                new CompStmt(new VariablesDeclarationStmt("varc", new IntIType()),
                                        new CompStmt(new ReadFileStatement(
                                                new VariableExpression("varf"), "varc"),
                                                new CompStmt(new PrintStm(new VariableExpression("varc")),
                                                        new CompStmt(new ReadFileStatement(
                                                                new VariableExpression("varf"), "varc"),
                                                                new CompStmt(
                                                                        new PrintStm(
                                                                                new VariableExpression("varc")),
                                                                        new CloseReadFileStatement(
                                                                                new VariableExpression("varf"))))))))));


        statements.add(statement4);

        /* Ref int v; new(v,20); Ref Ref int a; new(a,v); print(v); print(a) */
        IStmt statement5 = new CompStmt(new VariablesDeclarationStmt("v", new RefType(new IntIType())),
                new CompStmt(new HeapAllocationStatement(new ValueExpression(new IntIValue(20)),"v"),
                        new CompStmt(new VariablesDeclarationStmt("a", new RefType(new RefType(new IntIType()))),
                                new CompStmt(new HeapAllocationStatement(new VariableExpression("v"),"a"),
                                        new CompStmt(new PrintStm(new VariableExpression("v")), new PrintStm(new VariableExpression("a")))))));

        statements.add(statement5);

        /* Ref int v; new(v,20); Ref Ref int a; new(a,v); print(rH(v)); print(rH(rH(a))+5) */
        IStmt statement6= new CompStmt(new VariablesDeclarationStmt("v", new RefType(new IntIType())),
                new CompStmt(new HeapAllocationStatement(new ValueExpression(new IntIValue(20)),"v"),
                        new CompStmt(new VariablesDeclarationStmt("a", new RefType(new RefType(new IntIType()))),
                                new CompStmt(new HeapAllocationStatement(new VariableExpression("v"),"a"),
                                        new CompStmt(new PrintStm(new HeapReadExpression(new VariableExpression("v"))),
                                                new PrintStm(new ArithmeticalExpression(new HeapReadExpression(new HeapReadExpression(new VariableExpression("a"))),
                                                        ArithmeticalOperator.ADD,new ValueExpression(new IntIValue(5)) )))))));

        statements.add(statement6);

        /* Ref int v; new(v,20); print(rH(v)); wH(v,30); print(rH(v)+5); */
        IStmt statement7= new CompStmt(new VariablesDeclarationStmt("v", new RefType(new IntIType())),
                new CompStmt(new HeapAllocationStatement(new ValueExpression(new IntIValue(20)),"v"),
                        new CompStmt( new PrintStm(new HeapReadExpression(new VariableExpression("v"))),
                                new CompStmt(new HeapWriteStatement(new ValueExpression(new IntIValue(30)),"v"),
                                        new PrintStm(new ArithmeticalExpression( new HeapReadExpression(new VariableExpression("v")), ArithmeticalOperator.ADD,new ValueExpression(new IntIValue(5))))))));

        statements.add(statement7);

        /* Ref int v; new(v,20); Ref Ref int a; new(a,v); new(v,30); print(rH(rH(a))) */
        IStmt statement8 = new CompStmt(new VariablesDeclarationStmt("v", new RefType(new IntIType())),
                new CompStmt(new HeapAllocationStatement(new ValueExpression(new IntIValue(20)),"v"),
                        new CompStmt(new VariablesDeclarationStmt("a", new RefType(new RefType(new IntIType()))),
                                new CompStmt(new HeapAllocationStatement( new VariableExpression("v"),"a"),
                                        new CompStmt(new HeapAllocationStatement(new ValueExpression(new IntIValue(30)),"v"),
                                                new PrintStm(new HeapReadExpression(new HeapReadExpression(new VariableExpression("a")))))))));

        statements.add(statement8);

        //int v; v=4; (while (v>0) print(v);v=v-1);print(v)
        IStmt statement9 = new CompStmt(new VariablesDeclarationStmt("v", new IntIType()),
                new CompStmt(new AssignStmt("v", new ValueExpression(new IntIValue(4))),
                        new CompStmt(new WhileStatement(new RelationalExpression(new VariableExpression("v"),">",
                                new ValueExpression(new IntIValue(0))),
                                new CompStmt(new PrintStm(new VariableExpression("v")),
                                        new AssignStmt("v", new ArithmeticalExpression(new VariableExpression("v"),
                                                ArithmeticalOperator.SUBTRACT, new ValueExpression(new IntIValue(1)))))),
                                new PrintStm(new VariableExpression("v")))));

        statements.add(statement9);

        // int v; Ref int a; v=10; new(a,22); fork(wH(a,30); v=32; print(v); print(rH(a))); print(v); print(rH(a))
        IStmt statement10 = new CompStmt(new VariablesDeclarationStmt("v", new IntIType()),
                new CompStmt(new VariablesDeclarationStmt("a", new RefType(new IntIType())),
                        new CompStmt(new AssignStmt("v", new ValueExpression(new IntIValue(10))),
                                new CompStmt(new HeapAllocationStatement( new ValueExpression(new IntIValue(22)),"a"),
                                        new CompStmt(new ForkStatement(new CompStmt(new HeapWriteStatement(new ValueExpression(new IntIValue(30)),"a"),
                                                new CompStmt(new AssignStmt("v", new ValueExpression(new IntIValue(32))),
                                                        new CompStmt(new PrintStm(new VariableExpression("v")), new PrintStm(new HeapReadExpression(new VariableExpression("a"))))))),
                                                new CompStmt(new PrintStm(new VariableExpression("v")), new PrintStm(new HeapReadExpression(new VariableExpression("a")))))))));


        statements.add(statement10);

        IStmt sumProc = new CompStmt(
                new VariablesDeclarationStmt("localV", new IntIType()),
                new CompStmt(
                        new AssignStmt("localV", new ArithmeticalExpression(new VariableExpression("a"), ArithmeticalOperator.ADD, new VariableExpression("b"))),
                        new PrintStm(new VariableExpression("localV"))
                )
        );

        IMyProcedureTable procedureTable = new MyProcedureTable();
        List<String> varSum = new ArrayList<>();
        varSum.add("a");
        varSum.add("b");
        procedureTable.put("sum", new MyPair<>(varSum, sumProc));

        IStmt prodProc = new CompStmt(
                new VariablesDeclarationStmt("local-v", new IntIType()),
                new CompStmt(
                        new AssignStmt("local-v", new ArithmeticalExpression(new VariableExpression("c"), ArithmeticalOperator.MULTIPLY, new VariableExpression("d"))),
                        new PrintStm(new VariableExpression("local-v"))
                )
        );

        List<String> varProd = new ArrayList<>();
        varProd.add("c");
        varProd.add("d");
        procedureTable.put("product", new MyPair<>(varProd, prodProc));

        IStmt statement11 = new CompStmt(
                new VariablesDeclarationStmt("v", new IntIType()),
                new CompStmt(
                        new VariablesDeclarationStmt("w", new IntIType()),
                        new CompStmt(
                                new AssignStmt("v", new ValueExpression(new IntIValue(2))),
                                new CompStmt(
                                        new AssignStmt("w", new ValueExpression(new IntIValue(5))),
                                        new CompStmt(
                                                new CallProcedureStatement("sum", new ArrayList<>(Arrays.asList(new ArithmeticalExpression(new VariableExpression("v"), ArithmeticalOperator.MULTIPLY, new ValueExpression(new IntIValue(10))), new VariableExpression("w")))),
                                                new CompStmt(
                                                        new PrintStm(new VariableExpression("v")),
                                                        new ForkStatement(
                                                                new CompStmt(
                                                                        new CallProcedureStatement("product", new ArrayList<>(Arrays.asList(new VariableExpression("v"), new VariableExpression("w")))),
                                                                        new ForkStatement(
                                                                                new CallProcedureStatement("sum", new ArrayList<>(Arrays.asList(new VariableExpression("v"), new VariableExpression("w"))))
                                                                        )
                                                                )
                                                        )
                                                )
                                        )
                                )
                        )
                )
        );


        statements.add(statement11);

        IStmt statement12 = new CompStmt(new VariablesDeclarationStmt("v" , new IntIType()),new CompStmt (new AssignStmt("v" , new ValueExpression(new IntIValue(10))),
                new CompStmt(new ForkStatement(
                        new CompStmt(new AssignStmt("v" , new ArithmeticalExpression(new VariableExpression("v"), ArithmeticalOperator.SUBTRACT, new ValueExpression(new IntIValue(1)))),
                                new CompStmt(new AssignStmt("v" , new ArithmeticalExpression(new VariableExpression("v"), ArithmeticalOperator.SUBTRACT, new ValueExpression(new IntIValue(1)))),
                                        new PrintStm(new VariableExpression("v"))))),
                        new CompStmt(new SleepStatement(10)
                                ,new PrintStm(new ArithmeticalExpression(new VariableExpression("v"), ArithmeticalOperator.MULTIPLY, new ValueExpression(new IntIValue(10))))))));
        statements.add(statement12);
    }


}

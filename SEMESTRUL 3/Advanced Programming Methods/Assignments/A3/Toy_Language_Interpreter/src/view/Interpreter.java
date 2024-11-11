package view;

import controller.Controller;
import exceptions.EmptyStackException;
import model.expressions.ArithmeticalExpression;
import model.expressions.ArithmeticalOperator;
import model.expressions.ValueExpression;
import model.expressions.VariableExpression;
import model.statements.*;
import model.types.BoolIType;
import model.types.IntIType;
import model.types.StringType;
import model.values.BoolValue;
import model.values.IntIValue;
import model.values.StringValue;
import repository.IRepository;
import repository.Repository;
import view.commands.ExitCommand;
import view.commands.RunExampleCommand;

import java.io.IOException;

public class Interpreter
{
    public static void main(String[] args) throws EmptyStackException, IOException {
        //int v; v=2; Print(v)
        IStmt statement1 = new CompStmt(new VariablesDeclarationStmt("v", new IntIType()),
                new CompStmt(new AssignStmt("v", new ValueExpression(new IntIValue(2))),
                        new PrintStm(new VariableExpression("v"))));
        IRepository repo1 = new Repository("log1.txt");
        Controller controller1 = new Controller(repo1 , true);
        controller1.addProgram(statement1);

        // int a; int b; a=2+3*5; b=a+1; Print(b)
        IStmt statement2 = new CompStmt(new VariablesDeclarationStmt("a",new IntIType()),
                new CompStmt(new VariablesDeclarationStmt("b",new IntIType()),
                        new CompStmt(new AssignStmt("a", new ArithmeticalExpression(new ValueExpression(new IntIValue(2)),ArithmeticalOperator.ADD,new
                                ArithmeticalExpression(new ValueExpression(new IntIValue(3)),ArithmeticalOperator.MULTIPLY,new ValueExpression(new IntIValue(5))))),
                                new CompStmt(new AssignStmt("b",new ArithmeticalExpression(new VariableExpression("a"), ArithmeticalOperator.ADD,new ValueExpression(new
                                        IntIValue(1)))), new PrintStm(new VariableExpression("b"))))));
        IRepository repo2 = new Repository("log2.txt");
        Controller controller2 = new Controller(repo2 , true);
        controller2.addProgram(statement2);

        // bool a; int v; a=true; (If a Then v=2 Else v=3); Print(v)
        IStmt statement3 = new CompStmt(new VariablesDeclarationStmt("a", new BoolIType()),
                new CompStmt(new VariablesDeclarationStmt("v", new IntIType()),
                        new CompStmt(new AssignStmt("a", new ValueExpression(new BoolValue(true))),
                                new CompStmt(new IfStmt(new VariableExpression("a"),
                                        new AssignStmt("v", new ValueExpression(new IntIValue(2))),
                                        new AssignStmt("v", new ValueExpression(new IntIValue(3)))),
                                        new PrintStm(new VariableExpression("v"))))));
        IRepository repo3 = new Repository("log3.txt");
        Controller controller3 = new Controller(repo3,true);
        controller3.addProgram(statement3);

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


        IRepository repo4 = new Repository("log4.txt");
        Controller controller4 = new Controller(repo4,true);
        controller4.addProgram(statement4);

        TextMenu menu = new TextMenu();
        menu.addCommand(new RunExampleCommand("1",statement1.toString() , controller1));
        menu.addCommand(new RunExampleCommand("2",statement2.toString() , controller2));
        menu.addCommand(new RunExampleCommand("3",statement3.toString() , controller3));
        menu.addCommand(new RunExampleCommand("4",statement4.toString() , controller4));
        menu.addCommand(new ExitCommand("5" , "Exit"));

        menu.show();

    }

}

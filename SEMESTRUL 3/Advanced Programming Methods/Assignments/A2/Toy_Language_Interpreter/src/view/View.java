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
import model.values.BoolValue;
import model.values.IntIValue;

import javax.management.ValueExp;
import java.util.Scanner;

public class View
{
    private final Controller controller;

    public View(Controller c)
    {
        this.controller = c;
    }


    public void run()
    {
        try
        {
            runProgram1();
        } catch (EmptyStackException e) {
            throw new RuntimeException(e);
        }
    }

    private void runProgram1() throws EmptyStackException{
        IStmt statement = new CompStmt(new VariablesDeclarationStmt("v", new IntIType()),
                new CompStmt(new AssignStmt("v", new ValueExpression(new IntIValue(2))),
                        new PrintStm(new VariableExpression("v"))));

        runStatement(statement);
    }

    private void runProgram2() throws EmptyStackException {
        IStmt statement = new CompStmt(new VariablesDeclarationStmt("a",new IntIType()),
                new CompStmt(new VariablesDeclarationStmt("b",new IntIType()),
                        new CompStmt(new AssignStmt("a", new ArithmeticalExpression(new ValueExpression(new IntIValue(2)),ArithmeticalOperator.ADD,new
                                ArithmeticalExpression(new ValueExpression(new IntIValue(3)),ArithmeticalOperator.MULTIPLY,new ValueExpression(new IntIValue(5))))),
                                new CompStmt(new AssignStmt("b",new ArithmeticalExpression(new VariableExpression("a"), ArithmeticalOperator.ADD,new ValueExpression(new
                                        IntIValue(1)))), new PrintStm(new VariableExpression("b"))))));
        runStatement(statement);
    }

    private void runProgram3() throws EmptyStackException {
        IStmt statement = new CompStmt(new VariablesDeclarationStmt("a", new BoolIType()),
                new CompStmt(new VariablesDeclarationStmt("v", new IntIType()),
                        new CompStmt(new AssignStmt("a", new ValueExpression(new BoolValue(true))),
                                new CompStmt(new IfStmt(new VariableExpression("a"),
                                        new AssignStmt("v", new ValueExpression(new IntIValue(2))),
                                        new AssignStmt("v", new ValueExpression(new IntIValue(3)))),
                                        new PrintStm(new VariableExpression("v"))))));
        runStatement(statement);
    }

    private void runStatement(IStmt statement) throws EmptyStackException {
        this.controller.addProgram(statement);


        controller.executeAllSteps();
        System.out.println("Result: " + controller.getRepository().getCurrentProgram().toString());
    }
}

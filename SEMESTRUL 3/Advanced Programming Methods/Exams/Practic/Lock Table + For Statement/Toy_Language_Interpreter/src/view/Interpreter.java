package view;

import controller.Controller;
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
import view.commands.ExitCommand;
import view.commands.RunExampleCommand;

public class Interpreter
{
    public static void main(String[] args){
        //int v; v=2; Print(v)
        IStmt statement1 = new CompStmt(new VariablesDeclarationStmt("v", new IntIType()),
                new CompStmt(new AssignStmt("v", new ValueExpression(new IntIValue(2))),
                        new PrintStm(new VariableExpression("v"))));
        IRepository repo1 = new Repository("log1.txt");
        Controller controller1 = new Controller(repo1 );
        controller1.addProgram(statement1);

        // int a; int b; a=2+3*5; b=a+1; Print(b)
        IStmt statement2 = new CompStmt(new VariablesDeclarationStmt("a",new IntIType()),
                new CompStmt(new VariablesDeclarationStmt("b",new IntIType()),
                        new CompStmt(new AssignStmt("a", new ArithmeticalExpression(new ValueExpression(new IntIValue(2)),ArithmeticalOperator.ADD,new
                                ArithmeticalExpression(new ValueExpression(new IntIValue(3)),ArithmeticalOperator.MULTIPLY,new ValueExpression(new IntIValue(5))))),
                                new CompStmt(new AssignStmt("b",new ArithmeticalExpression(new VariableExpression("a"), ArithmeticalOperator.ADD,new ValueExpression(new
                                        IntIValue(1)))), new PrintStm(new VariableExpression("b"))))));
        IRepository repo2 = new Repository("log2.txt");
        Controller controller2 = new Controller(repo2 );
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
        Controller controller3 = new Controller(repo3);
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
        Controller controller4 = new Controller(repo4);
        controller4.addProgram(statement4);

        /* Ref int v; new(v,20); Ref Ref int a; new(a,v); print(v); print(a) */
        IStmt statement5 = new CompStmt(new VariablesDeclarationStmt("v", new RefType(new IntIType())),
                new CompStmt(new HeapAllocationStatement(new ValueExpression(new IntIValue(20)),"v"),
                        new CompStmt(new VariablesDeclarationStmt("a", new RefType(new RefType(new IntIType()))),
                                new CompStmt(new HeapAllocationStatement(new VariableExpression("v"),"a"),
                                        new CompStmt(new PrintStm(new VariableExpression("v")), new PrintStm(new VariableExpression("a")))))));

        IRepository repo5 = new Repository("log5.txt");
        Controller controller5 = new Controller(repo5);
        controller5.addProgram(statement5);

        /* Ref int v; new(v,20); Ref Ref int a; new(a,v); print(rH(v)); print(rH(rH(a))+5) */
        IStmt statement6= new CompStmt(new VariablesDeclarationStmt("v", new RefType(new IntIType())),
                new CompStmt(new HeapAllocationStatement(new ValueExpression(new IntIValue(20)),"v"),
                        new CompStmt(new VariablesDeclarationStmt("a", new RefType(new RefType(new IntIType()))),
                                new CompStmt(new HeapAllocationStatement(new VariableExpression("v"),"a"),
                                        new CompStmt(new PrintStm(new HeapReadExpression(new VariableExpression("v"))),
                                                new PrintStm(new ArithmeticalExpression(new HeapReadExpression(new HeapReadExpression(new VariableExpression("a"))),
                                                        ArithmeticalOperator.ADD,new ValueExpression(new IntIValue(5)) )))))));

        IRepository repo6 = new Repository("log6.txt");
        Controller controller6 = new Controller(repo6);
        controller6.addProgram(statement6);

        /* Ref int v; new(v,20); print(rH(v)); wH(v,30); print(rH(v)+5); */
        IStmt statement7= new CompStmt(new VariablesDeclarationStmt("v", new RefType(new IntIType())),
                new CompStmt(new HeapAllocationStatement(new ValueExpression(new IntIValue(20)),"v"),
                        new CompStmt( new PrintStm(new HeapReadExpression(new VariableExpression("v"))),
                                new CompStmt(new HeapWriteStatement(new ValueExpression(new IntIValue(30)),"v"),
                                        new PrintStm(new ArithmeticalExpression( new HeapReadExpression(new VariableExpression("v")), ArithmeticalOperator.ADD,new ValueExpression(new IntIValue(5))))))));

        IRepository repo7 = new Repository("log7.txt");
        Controller controller7 = new Controller(repo7);
        controller7.addProgram(statement7);

        /* Ref int v; new(v,20); Ref Ref int a; new(a,v); new(v,30); print(rH(rH(a))) */
        IStmt statement8 = new CompStmt(new VariablesDeclarationStmt("v", new RefType(new IntIType())),
                new CompStmt(new HeapAllocationStatement(new ValueExpression(new IntIValue(20)),"v"),
                        new CompStmt(new VariablesDeclarationStmt("a", new RefType(new RefType(new IntIType()))),
                                new CompStmt(new HeapAllocationStatement( new VariableExpression("v"),"a"),
                                        new CompStmt(new HeapAllocationStatement(new ValueExpression(new IntIValue(30)),"v"),
                                                new PrintStm(new HeapReadExpression(new HeapReadExpression(new VariableExpression("a")))))))));

        IRepository repo8 = new Repository("log8.txt");
        Controller controller8 = new Controller(repo8);
        controller8.addProgram(statement8);

        //int v; v=4; (while (v>0) print(v);v=v-1);print(v)
        IStmt statement9 = new CompStmt(new VariablesDeclarationStmt("v", new IntIType()),
                new CompStmt(new AssignStmt("v", new ValueExpression(new IntIValue(4))),
                        new CompStmt(new WhileStatement(new RelationalExpression(new VariableExpression("v"),">",
                                new ValueExpression(new IntIValue(0))),
                                new CompStmt(new PrintStm(new VariableExpression("v")),
                                        new AssignStmt("v", new ArithmeticalExpression(new VariableExpression("v"),
                                                ArithmeticalOperator.SUBTRACT, new ValueExpression(new IntIValue(1)))))),
                        new PrintStm(new VariableExpression("v")))));

        IRepository repo9 = new Repository("log9.txt");
        Controller controller9 = new Controller(repo9);
        controller9.addProgram(statement9);

        // int v; Ref int a; v=10; new(a,22); fork(wH(a,30); v=32; print(v); print(rH(a))); print(v); print(rH(a))
        IStmt statement10 = new CompStmt(new VariablesDeclarationStmt("v", new IntIType()),
                new CompStmt(new VariablesDeclarationStmt("a", new RefType(new IntIType())),
                        new CompStmt(new AssignStmt("v", new ValueExpression(new IntIValue(10))),
                                new CompStmt(new HeapAllocationStatement( new ValueExpression(new IntIValue(22)),"a"),
                                        new CompStmt(new ForkStatement(new CompStmt(new HeapWriteStatement(new ValueExpression(new IntIValue(30)),"a"),
                                                new CompStmt(new AssignStmt("v", new ValueExpression(new IntIValue(32))),
                                                        new CompStmt(new PrintStm(new VariableExpression("v")), new PrintStm(new HeapReadExpression(new VariableExpression("a"))))))),
                                                new CompStmt(new PrintStm(new VariableExpression("v")), new PrintStm(new HeapReadExpression(new VariableExpression("a")))))))));


        IRepository repo10 = new Repository("log10.txt");
        Controller controller10 = new Controller(repo10);
        controller10.addProgram(statement10);

        //Ref int a ; new (a,20) ; (for(v = 0; v<3; v=v+1) fork(print(v);v=v*rh(a)) ); print(rH(a))
        IStmt statement11 = new CompStmt(new VariablesDeclarationStmt("a", new RefType(new IntIType())),
                new CompStmt(new HeapAllocationStatement(new ValueExpression(new IntIValue(20)),"a"),
                        new CompStmt(new ForStatement(new ValueExpression(new IntIValue(0)), new ValueExpression(new IntIValue(3)),
                                new ArithmeticalExpression(new VariableExpression("v"), ArithmeticalOperator.ADD, new ValueExpression(new IntIValue(1))),
                                new ForkStatement(
                                        new CompStmt(new PrintStm(new VariableExpression("v")),
                                        new AssignStmt("v", new ArithmeticalExpression(new VariableExpression("v"), ArithmeticalOperator.MULTIPLY, new HeapReadExpression(new VariableExpression("a"))))))),
                                new PrintStm(new HeapReadExpression(new VariableExpression("a"))))));

        IRepository repo11 = new Repository("log11.txt");
        Controller controller11 = new Controller(repo11);
        controller11.addProgram(statement11);

        //Ref int v1; Ref int v2 ; int x; int q; new(v1,20); new(v2,30); newLock(x); fork(fork(lock(x); wH(v1,rh(v1)-1)); unlock(x)); fork(fork(lock(x); wH(v1,rh(v1)-1); unlock(x)); lock(x); wh(v1 , rh(v1)*10); unlock(x)); newLock(q); lock(x); print(rH(v1)); unlock(x); newLock(q); lock(q); print(rH(v2)); unlock(q)

        IStmt statement12 = new CompStmt(new VariablesDeclarationStmt("v1", new RefType(new IntIType())),
                new CompStmt(new VariablesDeclarationStmt("v2", new RefType(new IntIType())),
                        new CompStmt(new VariablesDeclarationStmt("x", new IntIType()),
                                new CompStmt(new VariablesDeclarationStmt("q", new IntIType()),
                                        new CompStmt(new HeapAllocationStatement( new ValueExpression(new IntIValue(20)),"v1"),
                                                new CompStmt(new HeapAllocationStatement(new ValueExpression(new IntIValue(30)),"v2"),
                                                        new CompStmt(new NewLockStatement("x"),
                                                                new CompStmt(new ForkStatement(
                                                                        new CompStmt(new ForkStatement(
                                                                                new CompStmt(new LockStatement("x"),
                                                                                        new CompStmt(new HeapWriteStatement( new ArithmeticalExpression(new HeapReadExpression(new VariableExpression("v1")), ArithmeticalOperator.SUBTRACT,new ValueExpression(new IntIValue(1))),"v1"),
                                                                                                new UnlockStatement("x")))
                                                                        ),
                                                                                new CompStmt(new LockStatement("x"),
                                                                                        new CompStmt(new HeapWriteStatement( new ArithmeticalExpression( new HeapReadExpression(new VariableExpression("v1")), ArithmeticalOperator.MULTIPLY,new ValueExpression(new IntIValue(10))),"v1"),
                                                                                                new UnlockStatement("x"))))
                                                                ),
                                                                        new CompStmt( new NewLockStatement("q"),
                                                                                new CompStmt(new ForkStatement(
                                                                                        new CompStmt( new ForkStatement(
                                                                                                new CompStmt(new LockStatement("q"),
                                                                                                        new CompStmt(new HeapWriteStatement( new ArithmeticalExpression(new HeapReadExpression(new VariableExpression("v2")), ArithmeticalOperator.ADD,new ValueExpression(new IntIValue(5))),"v2"),
                                                                                                                new UnlockStatement("q")))
                                                                                        ),
                                                                                                new CompStmt(new LockStatement("q"),
                                                                                                        new CompStmt(new HeapWriteStatement( new ArithmeticalExpression( new HeapReadExpression(new VariableExpression("v2")), ArithmeticalOperator.MULTIPLY,new ValueExpression(new IntIValue(10))),"v2"),
                                                                                                                new UnlockStatement("q"))))
                                                                                ),
                                                                                        new CompStmt(new NopStmt(),
                                                                                                new CompStmt(new NopStmt(),
                                                                                                        new CompStmt(new NopStmt(),
                                                                                                                new CompStmt(new NopStmt(),
                                                                                                                        new CompStmt(new LockStatement("x"),
                                                                                                                                new CompStmt(new PrintStm(new HeapReadExpression(new VariableExpression("v1"))),
                                                                                                                                        new CompStmt(new UnlockStatement("x"),
                                                                                                                                                new CompStmt(new LockStatement("q"),
                                                                                                                                                        new CompStmt(new PrintStm(new HeapReadExpression(new VariableExpression("v2"))),
                                                                                                                                                                new UnlockStatement("q"))))))))))))))))))));

        IRepository repo12 = new Repository("log12.txt");
        Controller controller12 = new Controller(repo12);
        controller12.addProgram(statement12);

        TextMenu menu = new TextMenu();
        menu.addCommand(new RunExampleCommand("1", statement1.toString(), controller1));
        menu.addCommand(new RunExampleCommand("2", statement2.toString(), controller2));
        menu.addCommand(new RunExampleCommand("3", statement3.toString(), controller3));
        menu.addCommand(new RunExampleCommand("4", statement4.toString(), controller4));
        menu.addCommand(new RunExampleCommand("5", statement5.toString(), controller5));
        menu.addCommand(new RunExampleCommand("6", statement6.toString(), controller6));
        menu.addCommand(new RunExampleCommand("7", statement7.toString(), controller7));
        menu.addCommand(new RunExampleCommand("8", statement8.toString(), controller8));
        menu.addCommand(new RunExampleCommand("9", statement9.toString(), controller9));
        menu.addCommand(new RunExampleCommand("10", statement10.toString(), controller10));
        menu.addCommand(new RunExampleCommand("11", statement11.toString(), controller11));
        menu.addCommand(new RunExampleCommand("12", statement12.toString(), controller12));
        menu.addCommand(new ExitCommand("0", "Exit"));

        menu.show();


    }

}

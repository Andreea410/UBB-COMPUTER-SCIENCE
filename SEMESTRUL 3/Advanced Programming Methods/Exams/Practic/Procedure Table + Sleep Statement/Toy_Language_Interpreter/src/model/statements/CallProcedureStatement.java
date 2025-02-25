package model.statements;

import exceptions.ADTException;
import exceptions.StatementException;
import model.adt.*;
import model.expressions.IExp;
import model.states.PrgState;
import model.types.IType;
import model.values.IValue;

import java.io.IOException;
import java.util.List;

public class CallProcedureStatement implements IStmt{

    private final String procedureName;
    private final List<IExp> expressions;

    public CallProcedureStatement(String procedureName, List<IExp> expressions) {
        this.procedureName = procedureName;
        this.expressions = expressions;
    }

    @Override
    public PrgState execute(PrgState prgState) throws StatementException, ADTException, IOException {
        IMyDictionary<String,IValue> symTable = prgState.getSymTable();
        IMyHeap heap = prgState.getHeap();
        IMyProcedureTable procedureTable = prgState.getProcedureTable();

        if (!procedureTable.containsKey(procedureName)) {
            throw new StatementException("Procedure " + procedureName + " not found");
        }

        List<String> procedureArguments = procedureTable.get(procedureName).getFirst();
        IStmt procedureStatement = procedureTable.get(procedureName).getSecond();
        IMyDictionary<String, IValue> newSymTable = new MyDictionary<>();

        for(String variable: procedureArguments) {
           int position = procedureArguments.indexOf(variable);
           newSymTable.insert(variable, expressions.get(position).eval(symTable, heap));
        }

        prgState.getSymTable().push(newSymTable);
        prgState.getExeStack().push(new ReturnStatement());
        prgState.getExeStack().push(procedureStatement);
        return null;
    }

    @Override
    public IStmt deepCopy() {
        return new CallProcedureStatement(procedureName, expressions);
    }

    @Override
    public IMyDictionary<String, IType> typeCheck(IMyDictionary<String, IType> typeEnv) throws StatementException {
        return typeEnv;
    }

    @Override
    public String toString() {
        return "call " + procedureName + "(" + expressions.toString() + ")";
    }
}

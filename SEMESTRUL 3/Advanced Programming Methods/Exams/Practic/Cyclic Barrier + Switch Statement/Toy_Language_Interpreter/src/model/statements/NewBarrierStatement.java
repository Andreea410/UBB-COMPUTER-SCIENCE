package model.statements;

import exceptions.ADTException;
import exceptions.StatementException;
import model.adt.IMyBarrierTable;
import model.adt.IMyDictionary;
import model.adt.IMyHeap;
import model.adt.MyPair;
import model.expressions.IExp;
import model.states.PrgState;
import model.types.IType;
import model.types.IntIType;
import model.values.IValue;
import model.values.IntIValue;

import java.io.IOException;
import java.util.ArrayList;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class NewBarrierStatement implements IStmt{
    private final String varName;
    private final IExp exp ;
    private final static Lock lock = new ReentrantLock();

    public NewBarrierStatement(String varName, IExp exp) {
        this.varName = varName;
        this.exp = exp;
    }

    @Override
    public PrgState execute(PrgState prgState) throws StatementException, ADTException, IOException {
        lock.lock();
        try {


            IMyDictionary<String, IValue> symTable = prgState.getSymTable();
            IMyHeap heap = prgState.getHeap();
            IMyBarrierTable barrierTable = prgState.getBarrierTable();

            IntIValue threads = (IntIValue) exp.eval(symTable, heap);
            int nr = threads.getVal();
            int freeAddress = barrierTable.getFreeLocation();

            barrierTable.put(freeAddress, new MyPair<>(nr, new ArrayList<>()));
            if (!symTable.contains(varName))
                throw new StatementException("Variable not in symbol table");
            symTable.insert(varName, new IntIValue(freeAddress));
        }
        finally {
            lock.unlock();
        }
        return null;
    }

    @Override
    public IStmt deepCopy() {
        return new NewBarrierStatement(varName, exp.deepCopy());
    }

    @Override
    public IMyDictionary<String, IType> typeCheck(IMyDictionary<String, IType> typeEnv) throws StatementException {
        if(!typeEnv.getValue(varName).equals(new IntIType()))
            throw new StatementException("Variable not of type int");
        if(!exp.typecheck(typeEnv).equals(new IntIType()))
            throw new StatementException("Expression not of type int");
        return typeEnv;
    }

    @Override
    public String toString() {
        return "newBarrier(" + varName + ", " + exp + ")";
    }
}

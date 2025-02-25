package model.statements;

import exceptions.ADTException;
import exceptions.StatementException;
import model.adt.IMyBarrierTable;
import model.adt.IMyDictionary;
import model.adt.MyPair;
import model.states.PrgState;
import model.types.IType;
import model.types.IntIType;
import model.values.IValue;
import model.values.IntIValue;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class AwaitStatement implements IStmt{

    private final String var;
    private final static Lock lock = new ReentrantLock();

    public AwaitStatement(String var) {
        this.var = var;
    }

    @Override
    public PrgState execute(PrgState prgState) throws StatementException, ADTException, IOException {
        lock.lock();
        try {
            IMyDictionary<String, IValue> symTable = prgState.getSymTable();
            IMyBarrierTable barrierTable = prgState.getBarrierTable();

            if (!symTable.contains(var))
                throw new StatementException("Variable not in symbol table");

            IntIValue index = (IntIValue) symTable.getValue(var);
            int i = index.getVal();

            if (!barrierTable.containsKey(i))
                throw new StatementException("Index not in barrier table");

            MyPair<Integer, List<Integer>> currentBarrier = barrierTable.get(i);
            ArrayList<Integer> threads = (ArrayList<Integer>) currentBarrier.getSecond();

            int length = currentBarrier.getSecond().size();
            int nr = currentBarrier.getFirst();

            if(nr > length)
            {
                if(threads.contains(prgState.getId()))
                    prgState.getExeStack().push(this);
                else
                {
                    threads.add(prgState.getId());
                    barrierTable.put(i, new MyPair<>(nr, threads));
                    prgState.setBarrierTable(barrierTable);
                    prgState.getExeStack().push(this);
                }
            }
            else
                throw new StatementException("Barrier is full");
        }
        finally {
            lock.unlock();
        }
        return null;
    }

    @Override
    public IStmt deepCopy() {
        return new AwaitStatement(var);
    }

    @Override
    public IMyDictionary<String, IType> typeCheck(IMyDictionary<String, IType> typeEnv) throws StatementException {
        if(!typeEnv.getValue(var).equals(new IntIType()))
            throw new StatementException("Variable not of type int");
        return typeEnv;
    }

    @Override
    public String toString() {
        return "await(" + var + ")";
    }
}

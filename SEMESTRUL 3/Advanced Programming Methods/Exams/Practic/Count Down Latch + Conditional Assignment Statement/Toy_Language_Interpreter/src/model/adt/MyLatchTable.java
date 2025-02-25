package model.adt;

import exceptions.ADTException;
import exceptions.KeyNotFoundException;

import java.util.HashMap;

public class MyLatchTable implements IMyLatchTable
{
    private HashMap<Integer,Integer> latchTable;
    private int firstFree = 0;

    public MyLatchTable()
    {
        this.latchTable = new HashMap<>();
    }

    @Override
    public void put(int key, int value) throws ADTException {
        synchronized (this)
        {
            if(!latchTable.containsKey(key))
                latchTable.put(key,value);
            else
                throw new ADTException("Latch table already contains the key!");
        }
    }

    @Override
    public int get(int key) throws KeyNotFoundException {
        synchronized (this)
        {
            if(!latchTable.containsKey(key))
                throw new KeyNotFoundException("Latch table does not contain the key!");
            return latchTable.get(key);
        }
    }

    @Override
    public boolean containsKey(int key) {
        synchronized (this) {
            return latchTable.containsKey(key);
        }
    }

    @Override
    public HashMap<Integer, Integer> getLatchtable() {
        synchronized (this) {
            return this.latchTable;
        }
    }

    @Override
    public int getFirstFree() {
        firstFree++;
        return firstFree;
    }

    @Override
    public void update(int key, int newValue) throws KeyNotFoundException {
        synchronized (this)
        {
            if(!latchTable.containsKey(key))
                throw new KeyNotFoundException("Key was not found");
            latchTable.replace(key , newValue);
        }
    }

    @Override
    public HashMap<Integer, Integer> getMap() {
        synchronized (this) {
            return this.latchTable;
        }

    }

    @Override
    public String toString()
    {
        StringBuilder latchTableStringBuilder = new StringBuilder();
        for (int key: latchTable.keySet()) {
            latchTableStringBuilder.append(String.format("%d -> %d\n", key, latchTable.get(key)));
        }
        return latchTableStringBuilder.toString();
    }


}

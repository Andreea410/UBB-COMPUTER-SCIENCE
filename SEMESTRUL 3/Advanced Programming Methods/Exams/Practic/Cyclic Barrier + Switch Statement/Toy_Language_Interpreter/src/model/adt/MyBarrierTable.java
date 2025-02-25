package model.adt;

import exceptions.ADTException;
import exceptions.KeyNotFoundException;

import java.util.HashMap;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;

public class MyBarrierTable implements IMyBarrierTable{
    private HashMap<Integer, MyPair<Integer,List<Integer>>> barrierTable;
    private AtomicInteger freeLocation;

    public MyBarrierTable() {
        this.barrierTable = new HashMap<>();
        this.freeLocation = new AtomicInteger(0);
    }

    @Override
    public int getFreeLocation() {
        return this.freeLocation.incrementAndGet();
    }

    @Override
    public void put(int key, MyPair<Integer, List<Integer>> value) {
        if (this.barrierTable.containsKey(key))
            throw new ADTException("Key already exists in the barrier table");
        this.barrierTable.put(key, value);
    }

    @Override
    public MyPair<Integer, List<Integer>> get(int key) {
        return this.barrierTable.get(key);
    }

    @Override
    public void remove(int key) {
        this.barrierTable.remove(key);
    }

    @Override
    public boolean containsKey(int key) {
        return this.barrierTable.containsKey(key);
    }

    @Override
    public void update(int key, MyPair<Integer, List<Integer>> value) {
        if (!this.barrierTable.containsKey(key))
            throw new KeyNotFoundException("Key does not exist in the barrier table");
        this.barrierTable.put(key, value);
    }

    @Override
    public String toString() {
        StringBuilder s = new StringBuilder();
        for (var elem: this.barrierTable.keySet()) {
            if (elem != null)
                s.append(elem.toString()).append(" -> ").append(this.barrierTable.get(elem).toString()).append('\n');
        }
        return s.toString();
    }

    @Override
    public HashMap<Integer, MyPair<Integer, List<Integer>>> getContent() {
        return this.barrierTable;
    }


}

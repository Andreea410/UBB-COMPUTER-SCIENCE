package model.adt;

import exceptions.KeyNotFoundException;

import java.util.HashMap;
import java.util.concurrent.atomic.AtomicInteger;

public class MyLockTable implements IMyLockTable{

    private HashMap<Integer, Integer> lockTable;
    private AtomicInteger freeLocation;

    public MyLockTable() {
        this.lockTable = new HashMap<>();
        this.freeLocation = new AtomicInteger(0);
    }

    @Override
    public boolean containsKey(int key) {
        synchronized (this) {
            return this.lockTable.containsKey(key);
        }
    }

    @Override
    public void put(int key, int value) {
        synchronized (this) {
            this.lockTable.put(key, value);
        }
    }

    @Override
    public int lookup(int key) {
        synchronized (this) {
            if (!this.lockTable.containsKey(key)) {
                throw new KeyNotFoundException("Key not found in lock table");
            }
            return this.lockTable.get(key);
        }
    }

    @Override
    public void update(int key, int value) {
        synchronized (this) {
            if (!this.lockTable.containsKey(key)) {
                throw new KeyNotFoundException("Key not found in lock table");
            }
            this.lockTable.put(key, value);
        }
    }

    @Override
    public int getFreeAddress() {
        synchronized (this) {
            return this.freeLocation.incrementAndGet();
        }
    }

    @Override
    public HashMap<Integer, Integer> getContent() {
        synchronized (this) {
            return this.lockTable;
        }
    }

    @Override
    public void setContent(HashMap<Integer, Integer> newContent) {
        synchronized (this) {
            this.lockTable = newContent;
        }
    }

    @Override
    public String toString() {
        synchronized (this) {
            StringBuilder s = new StringBuilder();
            for (var elem : this.lockTable.keySet()) {
                if (elem != null)
                    s.append(elem.toString()).append(" -> ").append(this.lockTable.get(elem).toString()).append('\n');
            }
            return s.toString();
        }
    }
}

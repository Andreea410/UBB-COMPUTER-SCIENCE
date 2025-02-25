package model.adt;

import exceptions.ADTException;
import exceptions.KeyNotFoundException;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.atomic.AtomicInteger;

public class MySemaphoreTable implements IMySemaphoreTable{

    private Map<Integer,MyTuple<Integer, List<Integer>,Integer>> semaphoreTable;
    AtomicInteger freeLocation;

    public MySemaphoreTable() {
        this.semaphoreTable = new HashMap<>();
        this.freeLocation = new AtomicInteger(0);
    }

    @Override
    public void add( int key , MyTuple<Integer,List<Integer>,Integer> value) throws ADTException {
        synchronized (this)
        {
            if (this.semaphoreTable.containsKey(key))
                throw new ADTException("Key already exists in the semaphore table");
            this.semaphoreTable.put(key, value);
        }
    }

    @Override
    public void remove(int index) {
        synchronized (this)
        {
            if(semaphoreTable.containsKey(index))
                this.semaphoreTable.remove(index);
            throw new KeyNotFoundException("Key not found in the semaphore table");
        }
    }

    @Override
    public MyTuple<Integer,List<Integer>,Integer> get(int index) {
        synchronized (this)
        {
            if(semaphoreTable.containsKey(index))
                return semaphoreTable.get(index);
            throw new KeyNotFoundException("Key not found in the semaphore table");
        }
    }

    @Override
    public boolean contains(int index) {
        synchronized (this)
        {
            return semaphoreTable.containsKey(index);
        }
    }

    @Override
    public String toString() {
        synchronized (this)
        {
            StringBuilder s = new StringBuilder();
            for(var elem: this.semaphoreTable.keySet()) {
                if (elem != null)
                    s.append(elem.toString()).append(" -> ").append(this.semaphoreTable.get(elem).toString()).append('\n');
            }
            return s.toString();
        }
    }

    @Override
    public int getFreeAddress() {
        synchronized (this)
        {
            return this.freeLocation.incrementAndGet();
        }
    }

    @Override
    public Map<Integer, MyTuple<Integer, List<Integer>, Integer>> getContent() {
        synchronized (this)
        {
            return this.semaphoreTable;
        }
    }

    @Override
    public void update(int key, MyTuple<Integer, List<Integer>, Integer> value) throws ADTException {
        synchronized (this)
        {
            if (!this.semaphoreTable.containsKey(key))
                throw new ADTException("Key does not exist in the semaphore table");
            this.semaphoreTable.put(key, value);
        }
    }
}

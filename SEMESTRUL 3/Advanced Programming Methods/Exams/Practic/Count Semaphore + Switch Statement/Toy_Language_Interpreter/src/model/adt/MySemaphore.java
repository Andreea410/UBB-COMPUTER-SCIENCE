package model.adt;

import exceptions.KeyNotFoundException;
import javafx.util.Pair;

import java.util.HashMap;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;

public class MySemaphore implements IMySemaphore {
    private final HashMap<Integer, Pair<Integer, List<Integer>>> semaphore;
    AtomicInteger freeLocation;

    public MySemaphore() {
        semaphore = new HashMap<>();
        freeLocation = new AtomicInteger(0);
    }

    @Override
    public void put(int key, Pair<Integer, List<Integer>> value) {
        synchronized (semaphore) {
            if (semaphore.containsKey(key))
                throw new KeyNotFoundException("The key already exists");
            semaphore.put(key, value);
        }
    }

    @Override
    public void update(int foundIndex, Pair<Integer, List<Integer>> integerListPair) {
        synchronized (semaphore) {
            if (!semaphore.containsKey(foundIndex))
                throw new KeyNotFoundException("The key does not exist");
            semaphore.put(foundIndex, integerListPair);
        }
    }

    @Override
    public Pair<Integer, List<Integer>> get(int key) {
        synchronized (this) {
            if (!semaphore.containsKey(key))
                throw new KeyNotFoundException("The key does not exist");
            return semaphore.get(key);
        }
    }

    @Override
    public void remove(int key) {
        synchronized (this) {
            if (!semaphore.containsKey(key))
                throw new KeyNotFoundException("The key does not exist");
            semaphore.remove(key);
        }
    }

    @Override
    public boolean contains(int key) {
        synchronized (this) {
            return semaphore.containsKey(key);
        }
    }

    @Override
    public int getFreeLocation() {
        synchronized (this) {
            return freeLocation.incrementAndGet();
        }
    }

}

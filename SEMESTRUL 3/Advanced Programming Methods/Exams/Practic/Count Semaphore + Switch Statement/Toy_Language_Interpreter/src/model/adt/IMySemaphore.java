package model.adt;

import javafx.util.Pair;

import java.util.HashMap;
import java.util.List;

public interface IMySemaphore {
    void put(int key , Pair<Integer, List<Integer>> value);
    Pair<Integer, List<Integer>> get(int key);
    void remove(int key);
    boolean contains(int key);
    int getFreeLocation();

    void update(int foundIndex, Pair<Integer, List<Integer>> integerListPair);
}

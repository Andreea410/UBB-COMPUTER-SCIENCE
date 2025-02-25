package model.adt;

import java.util.HashMap;
import java.util.List;

public interface IMyBarrierTable {
    int getFreeLocation();
    void put(int key, MyPair<Integer,List<Integer>> value);
    MyPair<Integer,List<Integer>> get(int key);
    void remove(int key);
    boolean containsKey(int key);
    void update(int key, MyPair<Integer,List<Integer>> value);
    HashMap<Integer, MyPair<Integer,List<Integer>>> getContent();

}

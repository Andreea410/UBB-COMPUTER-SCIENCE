package model.adt;

import java.util.HashMap;

public interface IMyLockTable{
    boolean containsKey(int key);
    void put(int key, int value);
    int lookup(int key);
    void update(int key, int value);
    int getFreeAddress();

    HashMap<Integer,Integer> getContent();
    void setContent(HashMap<Integer,Integer> newContent);
}

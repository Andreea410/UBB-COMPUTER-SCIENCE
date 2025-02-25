package model.adt;

import exceptions.ADTException;
import exceptions.KeyNotFoundException;

import java.util.HashMap;
import java.util.Map;

public interface IMyLatchTable {
    void put (int key , int value) throws ADTException;
    int get(int key) throws KeyNotFoundException;
    boolean containsKey(int key);
    HashMap<Integer,Integer> getLatchtable();
    int getFirstFree();
    void update(int key , int newValue) throws KeyNotFoundException;
    HashMap<Integer,Integer> getMap();

    Map<Object, Object> getContent();
}
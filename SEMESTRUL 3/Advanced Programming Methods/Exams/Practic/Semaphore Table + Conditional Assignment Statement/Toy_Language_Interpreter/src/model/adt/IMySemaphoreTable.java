package model.adt;

import exceptions.ADTException;

import java.util.List;
import java.util.Map;

public interface IMySemaphoreTable {
    void add( int key , MyTuple<Integer, List<Integer>,Integer> value) throws ADTException;
    void remove(int index);
    MyTuple<Integer,List<Integer>,Integer> get(int index);
    boolean contains(int index);
    String toString();
    void update(int key, MyTuple<Integer, List<Integer>, Integer> value) throws ADTException;

    int getFreeAddress();

    Map<Integer,MyTuple<Integer, List<Integer>,Integer>> getContent();
}

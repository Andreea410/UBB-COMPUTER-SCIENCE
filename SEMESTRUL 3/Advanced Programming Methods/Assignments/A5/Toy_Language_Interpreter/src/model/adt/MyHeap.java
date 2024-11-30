package model.adt;

import exceptions.ADTException;
import model.values.IValue;

import java.util.HashMap;
import java.util.Map;

public class MyHeap implements IMyHeap{
    private Map<Integer,IValue> map;
    private Integer firstFree;

    public MyHeap(Map<Integer,IValue> map)
    {
        this.map = map;
        firstFree = 1 ;
    }

    public MyHeap()
    {
         this.map = new HashMap<>();
         firstFree = 1;
    }

    @Override
    public Integer getFirstFree() {
        return firstFree;
    }


    @Override
    public IValue getValue(Integer key) {
        return map.get(key);
    }

    @Override
    public Integer add(IValue value) {
        map.put(firstFree,value);
        firstFree+=1;
        return firstFree-1;
    }

    @Override
    public void update(Integer position, IValue value)
    {
        if(!map.containsKey(position))
            throw new ADTException(String.format("Heap Error: %d is not in the heap",position));
        map.put(position,value);
    }
    @Override
    public Map<Integer, IValue> getMap() {
        return this.map;
    }

    @Override
    public boolean containsKey(Integer key) {
        return map.containsKey(key);
    }

    public Integer getKey(IValue value)
    {
        for (Integer key: this.map.keySet())
        {
            if (map.get(key)==value)
                return key;
        }
        return null;

    }

    @Override
    public void setContent(Map<Integer,IValue> newMap)
    {
        this.map.clear();
        for(Integer i : newMap.keySet())
            this.map.put(i, newMap.get(i));
    }
}

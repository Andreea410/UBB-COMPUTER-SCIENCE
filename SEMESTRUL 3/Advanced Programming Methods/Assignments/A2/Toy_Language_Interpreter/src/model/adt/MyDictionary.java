package model.adt;
import exceptions.KeyNotFoundException;

import java.util.Map;
import java.util.HashMap;

public class MyDictionary<K,V> implements IMyDictionary<K,V>
{
    private final Map<K,V> map;

    public MyDictionary()
    {
        this.map = new HashMap<K,V>();
    }

    @Override
    public void insert(K key , V value)
    {
        this.map.put(key , value);
    }

    @Override
    public V getValue(K key) throws KeyNotFoundException
    {
        if(!contains(key))
            throw new KeyNotFoundException("The key doesn t exist");
        return this.map.get(key);
    }

    @Override
    public boolean contains(K key)
    {
        return map.containsKey(key);
    }

    @Override
    public void remove(K key) throws KeyNotFoundException
    {
        if(!contains(key))
            throw new KeyNotFoundException("The key doesn t exist");
        this.map.remove(key);
    }

    @Override
    public String toString()
    {
        StringBuilder str = new StringBuilder();
        for(K key : this.map.keySet())
        {
            str.append(key).append("-> ").append(this.map.get(key)).append("\n");
        }
        return "My dictionary contains " + str;
    }

}

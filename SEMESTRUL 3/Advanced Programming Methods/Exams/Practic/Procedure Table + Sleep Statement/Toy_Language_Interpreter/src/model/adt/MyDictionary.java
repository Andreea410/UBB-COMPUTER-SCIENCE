package model.adt;
import exceptions.KeyNotFoundException;
import java.util.Map;
import java.util.HashMap;
import java.util.Set;

public class MyDictionary<K,V> implements IMyDictionary<K,V>
{
    private final Map<K,V> map;

    public MyDictionary()
    {
        this.map = new HashMap<>();
    }

    public MyDictionary(Map<K,V> newMap)
    {
        this.map = newMap;
    }

    @Override
    public void insert(K key , V value)
    {
        synchronized (map) {
            this.map.put(key, value);
        }
    }

    @Override
    public V getValue(K key) throws KeyNotFoundException
    {
        synchronized (map) {
            if (!contains(key))
                throw new KeyNotFoundException("The key does not exist");
            return this.map.get(key);
        }
    }

    @Override
    public boolean contains(K key)
    {
        synchronized (map){
            return map.containsKey(key);
        }
    }

    @Override
    public void remove(K key) throws KeyNotFoundException
    {
        synchronized (map) {
            if (!contains(key))
                throw new KeyNotFoundException("The key does not exist");
            this.map.remove(key);
        }
    }


    @Override
    public String toString()
    {
        StringBuilder str = new StringBuilder("{");
        for(K key : this.map.keySet())
        {
            str.append(key).append("-> ").append(this.map.get(key)).append(" | ");
        }
        if (!map.isEmpty()) {
            str.setLength(str.length() - 3);
        }
        str.append("}");
        return str.toString();
    }

    @Override
    public Set<K> getKeys()
    {
        synchronized (map) {
            return this.map.keySet();
        }
    }

    public Map<K,V> getContent()
    {
        return this.map;
    }

    @Override
    public IMyDictionary<K, V> deepCopy() {
        IMyDictionary<K,V> newDictionary = new MyDictionary<>();
        for(K key : this.getKeys())
            newDictionary.insert(key , getValue(key));
        return  newDictionary;

    }

    @Override
    public void pop() {
        synchronized (map) {
            if (!map.isEmpty()) {
                K key = map.keySet().iterator().next();
                map.remove(key);
            }
        }
    }

    @Override
    public void push(IMyDictionary<K, V> newMap) {
        synchronized (map) {
            for (K key : newMap.getKeys()) {
                map.put(key, newMap.getValue(key));
            }
        }
    }

    @Override
    public boolean isEmpty() {
        return false;
    }


}

package model.adt;
import exceptions.KeyNotFoundException;
import java.util.Map;
import java.util.Set;

public interface IMyDictionary<K,V>
{
    void insert(K key , V value);
    V getValue(K key) throws KeyNotFoundException;
    void remove(K key) throws KeyNotFoundException;
    boolean contains(K key);
    void update(K key, V value) throws KeyNotFoundException;
    Set<K> getKeys();
    Map<K,V> getContent();
    IMyDictionary<K,V> deepCopy();

}

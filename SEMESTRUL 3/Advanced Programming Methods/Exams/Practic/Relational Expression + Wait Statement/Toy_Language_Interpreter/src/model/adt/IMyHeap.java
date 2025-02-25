package model.adt;
import model.values.IValue;
import java.util.Map;

public interface IMyHeap
{
    void update(Integer position , IValue value);
    IValue getValue(Integer key);
    Integer add(IValue value);
    Map<Integer , IValue> getMap();
    void setContent(Map<Integer,IValue> newMap);
}

package model.adt;
import model.values.IValue;
import java.util.Map;

public interface IMyHeap
{
    Integer getFirstFree();
    public void update(Integer position , IValue value);
    public IValue getValue(Integer key);
    public Integer add(IValue value);
    Map<Integer , IValue> getMap();
    public boolean containsKey(Integer key);
    public void setContent(Map<Integer,IValue> newMap);
}

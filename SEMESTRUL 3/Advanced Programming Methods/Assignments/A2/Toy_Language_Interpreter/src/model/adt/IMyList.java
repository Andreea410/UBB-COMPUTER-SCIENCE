package model.adt;
import java.util.List;

public interface IMyList<T>
{
    void add(T element);
    List<T> getAll();

}

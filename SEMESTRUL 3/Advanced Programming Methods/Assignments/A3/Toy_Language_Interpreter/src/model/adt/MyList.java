package model.adt;

import java.util.LinkedList;
import java.util.List;

public class MyList<T> implements IMyList<T>
{
    private final List<T> list;

    public MyList()
    {
        this.list = new LinkedList<>();
    }

    @Override
    public List<T> getAll() {
        return list;
    }

    @Override
    public void add(T element)
    {
        synchronized (list) {
            list.add(element);
        }
    }

    @Override
    public String toString()
    {
        StringBuilder str = new StringBuilder();
        for(T element : this.list)
            str.append(element.toString()).append("\n");
        return "My list contains " + str;
    }

    public List<T> getList()
    {
        return this.list;
    }
}

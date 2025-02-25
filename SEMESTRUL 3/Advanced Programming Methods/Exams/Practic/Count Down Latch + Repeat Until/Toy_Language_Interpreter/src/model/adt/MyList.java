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

    public MyList(List<T> newList)
    {
        this.list = newList;
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
        StringBuilder str = new StringBuilder("{");
        for(T element : this.list)
            str.append(element.toString()).append("|");
        if(!this.list.isEmpty())
            str.setLength(str.length()-1);
        str.append("}");
        return str.toString();
    }

    @Override
    public List<T> getList()
    {
        return this.list;
    }
}

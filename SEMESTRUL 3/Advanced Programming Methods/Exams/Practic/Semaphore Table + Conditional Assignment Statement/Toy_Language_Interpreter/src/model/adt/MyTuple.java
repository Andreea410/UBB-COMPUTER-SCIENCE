package model.adt;

public class MyTuple <T,S,U>
{
    private T first;
    private S second;
    private U third;

    public MyTuple(T first, S second, U third)
    {
        this.first = first;
        this.second = second;
        this.third = third;
    }

    public T getFirst()
    {
        return first;
    }

    public S getSecond()
    {
        return second;
    }

    public U getThird()
    {
        return third;
    }

    public void setFirst(T first)
    {
        this.first = first;
    }

    public void setSecond(S second)
    {
        this.second = second;
    }

    public void setThird(U third)
    {
        this.third = third;
    }

    @Override
    public String toString()
    {
        return "(" + first.toString() + ", " + second.toString() + ", " + third.toString() + ")";
    }
}

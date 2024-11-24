package model.adt;
import java.util.ArrayDeque;
import java.util.Deque;
import java.util.Stack;
import exceptions.EmptyStackException;

public class MyStack<T> implements IMyStack<T>{

    private final Stack<T> stack;

    public MyStack()
    {
        this.stack = new Stack<>();
    }

    @Override
    public T pop() throws EmptyStackException{
        synchronized (stack) {
            if (stack.isEmpty())
                throw new EmptyStackException("Stack is empty");
            return this.stack.pop();
        }
    }

    @Override
    public void push(T v)
    {
        synchronized (stack) {
            stack.push(v);
        }
    }

    @Override
    public int getSize()
    {
        return stack.size();
    }

    @Override
    public Stack<T> getStack()
    {
        return this.stack;
    }

    @Override
    public boolean isEmpty()
    {
        return this.stack.isEmpty();
    }

    @Override
    public String toString()
    {
        StringBuilder str = new StringBuilder();
        for(T element: this.stack)
            str.append(element.toString()).append("\n");
        return "My stack contains : " + str;
    }
}

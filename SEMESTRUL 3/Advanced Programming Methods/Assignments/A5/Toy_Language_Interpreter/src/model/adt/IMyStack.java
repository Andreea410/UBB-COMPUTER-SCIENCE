package model.adt;


import exceptions.EmptyStackException;

import java.util.Stack;

public interface IMyStack<T>
{
    T pop() throws EmptyStackException;
    void push(T v);
    boolean isEmpty();
}

package model.adt;

import model.statements.IStmt;

import java.util.List;
import java.util.Map;

public interface IMyProcedureTable
{
    boolean containsKey(String key);
    void put(String key, MyPair<List<String>, IStmt> value);
    MyPair<List<String>, IStmt> get(String key);
    void update(String key, MyPair<List<String>, IStmt> value);
    void remove(String key);
    String toString();
    Map<String, MyPair<List<String>, IStmt>> getContent();
}

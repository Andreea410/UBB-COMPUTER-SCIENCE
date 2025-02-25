package model.adt;

import exceptions.KeyNotFoundException;
import model.statements.IStmt;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MyProcedureTable implements IMyProcedureTable {
    private HashMap<String, MyPair<List<String>, IStmt>> procedureTable;

    public MyProcedureTable() {
        this.procedureTable = new HashMap<>();
    }

    @Override
    public boolean containsKey(String key) {
        return this.procedureTable.containsKey(key);
    }

    @Override
    public void put(String key, MyPair<List<String>, IStmt> value) {
        this.procedureTable.put(key, value);
    }

    @Override
    public MyPair<List<String>, IStmt> get(String key) {
        if (this.procedureTable.containsKey(key)) {
            return this.procedureTable.get(key);
        }
        throw new KeyNotFoundException("Key not found in procedure table");
    }

    @Override
    public void update(String key, MyPair<List<String>, IStmt> value) {
        if (this.procedureTable.containsKey(key)) {
            this.procedureTable.put(key, value);
        }
        throw new KeyNotFoundException("Key not found in procedure table");
    }

    @Override
    public void remove(String key) {
        if (this.procedureTable.containsKey(key)) {
            this.procedureTable.remove(key);
        }
        throw new KeyNotFoundException("Key not found in procedure table");
    }

    @Override
    public String toString() {
        StringBuilder s = new StringBuilder();
        for (var elem: this.procedureTable.keySet()) {
            if (elem != null) {
                s.append(elem).append(" -> ").append(this.procedureTable.get(elem).toString()).append('\n');
            }
        }
        return s.toString();
    }

    @Override
    public Map<String, MyPair<List<String>, IStmt>> getContent() {
        return this.procedureTable;
    }
}

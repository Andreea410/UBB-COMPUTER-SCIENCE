import java.util.*;
import java.util.concurrent.locks.ReentrantLock;

public class DSMVariable {
    private int value;
    private final Set<Integer> subscribers = new HashSet<>();
    private final ReentrantLock lock = new ReentrantLock();

    public DSMVariable(int initialValue) {
        this.value = initialValue;
    }

    public void subscribe(int nodeId) {
        subscribers.add(nodeId);
    }

    public Set<Integer> getSubscribers() {
        return subscribers;
    }

    public int getValue() {
        return value;
    }

    public void setValue(int v) {
        this.value = v;
    }

    public ReentrantLock getLock() {
        return lock;
    }
}

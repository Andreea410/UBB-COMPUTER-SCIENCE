import java.util.*;

public class DSMLibrary {

    private static final Map<Integer, DSMVariable> variables = new HashMap<>();

    private static final Map<Integer, Node> nodes = new HashMap<>();

    public static void registerNode(Node node) {
        nodes.put(node.getNodeId(), node);
    }

    public static void createVariable(int varId) {
        variables.put(varId, new DSMVariable(0));
    }

    public static void subscribe(int varId, int nodeId) {
        variables.get(varId).subscribe(nodeId);
    }

    private static synchronized void notifySubscribers(int varId, int newValue) {
        DSMVariable var = variables.get(varId);
        for (int subscriberId : var.getSubscribers()) {
            nodes.get(subscriberId).receiveUpdate(varId, newValue);
        }
    }

    public static int read(int varId, int nodeId) {
        return variables.get(varId).getValue();
    }

    public static void write(int varId, int newValue, int nodeId) {
        DSMVariable var = variables.get(varId);

        if (!var.getSubscribers().contains(nodeId))
            return;

        var.getLock().lock();
        var.setValue(newValue);
        var.getLock().unlock();

        notifySubscribers(varId, newValue);
    }

    public static boolean compareAndExchange(int varId, int expected, int updated, int nodeId) {
        DSMVariable var = variables.get(varId);

        if (!var.getSubscribers().contains(nodeId))
            return false;

        var.getLock().lock();
        boolean success = false;

        if (var.getValue() == expected) {
            var.setValue(updated);
            success = true;
        }

        var.getLock().unlock();

        if (success)
            notifySubscribers(varId, updated);

        return success;
    }
}

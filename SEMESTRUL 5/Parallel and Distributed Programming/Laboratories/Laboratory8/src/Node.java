public class Node extends Thread {

    private final int id;

    public Node(int id) {
        this.id = id;
    }

    public int getNodeId() {
        return id;
    }

    public void receiveUpdate(int varId, int value) {
        System.out.println("Node " + id + ": Variable " + varId + " changed to " + value);
    }

    @Override
    public void run() {
    }
}

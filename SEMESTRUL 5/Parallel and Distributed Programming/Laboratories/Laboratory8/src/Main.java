public class Main {

    public static void main(String[] args) throws InterruptedException {

        // Create nodes (simulated computers)
        Node n1 = new Node(1);
        Node n2 = new Node(2);
        Node n3 = new Node(3);

        DSMLibrary.registerNode(n1);
        DSMLibrary.registerNode(n2);
        DSMLibrary.registerNode(n3);

        n1.start(); n2.start(); n3.start();

        DSMLibrary.createVariable(1);
        DSMLibrary.createVariable(2);

        DSMLibrary.subscribe(1, 1);
        DSMLibrary.subscribe(1, 2);

        DSMLibrary.subscribe(2, 2);
        DSMLibrary.subscribe(2, 3);

        DSMLibrary.write(1, 42, 1);
        DSMLibrary.write(2, 100, 2);
        DSMLibrary.write(2, 43, 2);

        DSMLibrary.compareAndExchange(2, 43, 101, 3);
        boolean ok = DSMLibrary.compareAndExchange(1, 42, 20, 1);

        if (ok) System.out.println("CAS succeeded!");
        else System.out.println("CAS failed!");

        int v1 = DSMLibrary.read(1, 1);
        int v2 = DSMLibrary.read(2, 3);

        System.out.println("Value var1 at node1 = " + v1);
        System.out.println("Value var2 at node3 = " + v2);
    }
}

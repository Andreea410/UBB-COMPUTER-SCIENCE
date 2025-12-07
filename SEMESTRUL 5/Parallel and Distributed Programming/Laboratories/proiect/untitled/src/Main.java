import java.util.Vector;

public class Main {
    public static void main(String[] args) throws Exception {

        Graph graph = new Graph(12);
        int maxColors = 4;

        long t1 = System.currentTimeMillis();
        Vector<Integer> seq = GraphColoringSequential.solve(graph, maxColors);
        long t2 = System.currentTimeMillis();
        System.out.println("Sequential: " + seq + " | time=" + (t2 - t1) + "ms");

        long t3 = System.currentTimeMillis();
        Vector<Integer> thr = GraphColoringThreads.solve(graph, maxColors, 4);
        long t4 = System.currentTimeMillis();
        System.out.println("Threads: " + thr + " | time=" + (t4 - t3) + "ms");

        System.out.println("\nTo run MPI: mpjrun.bat -np 4 -cp bin MainMPI\n");
    }
}

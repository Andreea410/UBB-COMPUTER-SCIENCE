import mpi.MPI;
import java.util.Vector;

public class MainMPI {
    public static void main(String[] args) throws Exception {

        MPI.Init(args);

        Graph graph = new Graph(12);
        int maxColors = 4;

        Vector<Integer> sol =
                GraphColoringMPI.solveDistributed(graph, maxColors);

        if (!sol.isEmpty()) {
            System.out.println("MPI solution: " + sol);
        }

        MPI.Finalize();
    }
}

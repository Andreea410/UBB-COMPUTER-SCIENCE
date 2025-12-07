import mpi.MPI;
import java.util.Vector;
import java.util.Collections;

public class GraphColoringMPI {

    public static Vector<Integer> solveDistributed(Graph graph, int maxColors) throws Exception {

        int rank = MPI.COMM_WORLD.Rank();
        int size = MPI.COMM_WORLD.Size();
        int nodes = graph.getNodesNo();

        Vector<Integer> result = new Vector<>();

        if (rank == 0) {

            int workers = size - 1;

            // Send initial color tasks
            for (int c = 0; c < maxColors; c++) {
                int target = (c % workers) + 1;
                MPI.COMM_WORLD.Send(new int[]{c}, 0, 1, MPI.INT, target, 1);
            }

            // Receive first valid solution
            int[] sol = new int[nodes];
            MPI.COMM_WORLD.Recv(sol, 0, nodes, MPI.INT, MPI.ANY_SOURCE, 2);

            for (int x : sol) result.add(x);

            // Broadcast STOP signal
            for (int w = 1; w < size; w++) {
                MPI.COMM_WORLD.Send(new int[]{-1}, 0, 1, MPI.INT, w, 1);
            }

        } else {

            while (true) {
                int[] msg = new int[1];
                MPI.COMM_WORLD.Recv(msg, 0, 1, MPI.INT, 0, 1);

                if (msg[0] == -1)   // STOP
                    break;

                Vector<Integer> color = new Vector<>(Collections.nCopies(nodes, -1));
                color.set(0, msg[0]);

                // Try to solve
                if (backtrack(1, graph, color, maxColors)) {
                    int[] sol = color.stream().mapToInt(i -> i).toArray();
                    MPI.COMM_WORLD.Send(sol, 0, nodes, MPI.INT, 0, 2);
                }
            }
        }

        return result;
    }

    private static boolean backtrack(int node, Graph graph, Vector<Integer> color, int maxColors) {
        if (node == graph.getNodesNo())
            return true;

        for (int c = 0; c < maxColors; c++) {
            color.set(node, c);
            if (isValid(node, graph, color))
                if (backtrack(node + 1, graph, color, maxColors))
                    return true;
        }
        return false;
    }

    private static boolean isValid(int node, Graph graph, Vector<Integer> color) {
        for (int i = 0; i < node; i++)
            if (graph.isEdge(node, i) && color.get(node).equals(color.get(i)))
                return false;
        return true;
    }
}

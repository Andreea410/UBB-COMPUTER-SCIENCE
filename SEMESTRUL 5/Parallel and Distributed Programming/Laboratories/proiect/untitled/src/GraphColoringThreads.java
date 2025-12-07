import java.util.Vector;
import java.util.concurrent.atomic.AtomicBoolean;

public class GraphColoringThreads {

    public static Vector<Integer> solve(Graph graph, int maxColors, int threadsNo) throws InterruptedException {

        int n = graph.getNodesNo();
        Vector<Integer> result = new Vector<>(java.util.Collections.nCopies(n, -1));
        AtomicBoolean found = new AtomicBoolean(false);

        Thread[] threads = new Thread[threadsNo];

        for (int t = 0; t < threadsNo; t++) {
            final int startColor = t;

            threads[t] = new Thread(() -> {
                Vector<Integer> colors = new Vector<>(java.util.Collections.nCopies(n, -1));

                colors.set(0, startColor);

                if (backtrack(1, graph, colors, maxColors, found)) {
                    synchronized (result) {
                        if (!found.get()) {
                            for (int i = 0; i < n; i++) result.set(i, colors.get(i));
                            found.set(true);
                        }
                    }
                }
            });

            threads[t].start();
        }

        for (Thread thread : threads) thread.join();
        return result;
    }

    private static boolean backtrack(int node, Graph graph, Vector<Integer> colors, int maxColors, AtomicBoolean found) {
        if (found.get()) return true;

        if (node == graph.getNodesNo()) return true;

        for (int c = 0; c < maxColors; c++) {
            colors.set(node, c);
            if (isValid(node, graph, colors)) {
                if (backtrack(node + 1, graph, colors, maxColors, found)) {
                    return true;
                }
            }
        }
        colors.set(node, -1);
        return false;
    }

    private static boolean isValid(int node, Graph graph, Vector<Integer> colors) {
        for (int i = 0; i < node; i++) {
            if (graph.isEdge(node, i) && colors.get(node).equals(colors.get(i))) {
                return false;
            }
        }
        return true;
    }
}

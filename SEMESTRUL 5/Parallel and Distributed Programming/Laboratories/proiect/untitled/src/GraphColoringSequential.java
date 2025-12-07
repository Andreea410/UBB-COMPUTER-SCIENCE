import java.util.Vector;

public class GraphColoringSequential {

    public static Vector<Integer> solve(Graph graph, int maxColors) {
        int n = graph.getNodesNo();
        Vector<Integer> colors = new Vector<>(java.util.Collections.nCopies(n, -1));

        if (backtrack(0, graph, colors, maxColors)) {
            return colors;
        }

        return colors;
    }

    private static boolean backtrack(int node, Graph graph, Vector<Integer> colors, int maxColors) {
        int n = graph.getNodesNo();
        if (node == n) return true;

        for (int c = 0; c < maxColors; c++) {
            colors.set(node, c);

            if (isValid(node, graph, colors)) {
                if (backtrack(node + 1, graph, colors, maxColors)) {
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

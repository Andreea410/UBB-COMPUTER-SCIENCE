import java.util.*;

public class Graph {
    private int nodesNo;
    private Map<Integer, Set<Integer>> vertices;

    public Graph(int nodesNo) {
        this.nodesNo = nodesNo;

        vertices = new HashMap<>();
        for (int node = 0; node < nodesNo; node++) {
            vertices.put(node, new HashSet<>());
        }

        generateRandomVertices();
    }

    private void generateRandomVertices() {
        Random random = new Random();
        for (int fromVertex = 0; fromVertex < nodesNo; fromVertex++) {
            for (int toVertex = 0; toVertex < nodesNo; toVertex++) {
                if (fromVertex != toVertex && random.nextBoolean()) {
                    vertices.get(fromVertex).add(toVertex);
                }
            }
        }
    }

    public Graph(int[][] adjacencyList) {
        this.nodesNo = adjacencyList.length;

        vertices = new HashMap<>();
        for (int node = 0; node < nodesNo; node++) {
            vertices.put(node, new HashSet<>());
        }

        for (int fromVertex = 0; fromVertex < nodesNo; fromVertex++) {
            for (int toVertex = 0; toVertex < nodesNo; toVertex++) {
                if (adjacencyList[fromVertex][toVertex] == 1) {
                    vertices.get(fromVertex).add(toVertex);
                }
            }
        }
    }

    public boolean addVertex(int fromVertex, int toVertex) {
        return vertices.get(fromVertex).add(toVertex);
    }

    public boolean isEdge(int fromVertex, int toVertex) {
        return vertices.get(fromVertex).contains(toVertex);
    }

    public int getNodesNo() {
        return nodesNo;
    }

    public void setNodesNo(int nodesNo) {
        this.nodesNo = nodesNo;
    }

    public Map<Integer, Set<Integer>> getVertices() {
        return vertices;
    }

    public void setVertices(Map<Integer, Set<Integer>> vertices) {
        this.vertices = vertices;
    }

    @Override
    public String toString() {
        return "Graph{" +
                "nodesNo=" + nodesNo +
                ", vertices=" + vertices +
                '}';
    }
}
class Worker implements Runnable {
    private final double[][] A;
    private final double[][] B;
    private final double[][] C;
    private final int threadId;
    private final int numThreads;
    private final int start;
    private final int end;
    private final String mode;

    public Worker(double[][] A, double[][] B, double[][] C, int start, int end, int threadId, int numThreads, String mode) {
        this.A = A;
        this.B = B;
        this.C = C;
        this.start = start;
        this.end = end;
        this.threadId = threadId;
        this.numThreads = numThreads;
        this.mode = mode;
    }

    @Override
    public void run() {
        int nRows = C.length;
        int nCols = C[0].length;
        int totalElements = nRows * nCols;

        switch (mode.toLowerCase()) {
            case "row":
                for (int index = start; index < end && index < totalElements; index++) {
                    int row = index / nCols;
                    int col = index % nCols;
                    C[row][col] = MatrixMultiplier.computeElement(A, B, row, col);
                    System.out.printf("Thread %d computed element (%d,%d)%n", threadId, row, col);
                }
                break;

            case "col":
                for (int index = start; index < end && index < totalElements; index++) {
                    int col = index / nRows;
                    int row = index % nRows;
                    C[row][col] = MatrixMultiplier.computeElement(A, B, row, col);
                    System.out.printf("Thread %d computed element (%d,%d)%n", threadId, row, col);
                }
                break;

            case "kth":
                for (int index = threadId; index < totalElements; index += numThreads) {
                    int row = index / nCols;
                    int col = index % nCols;
                    C[row][col] = MatrixMultiplier.computeElement(A, B, row, col);
                    System.out.printf("Thread %d computed element (%d,%d)%n", threadId, row, col);
                }
                break;

            default:
                System.err.println("Unknown mode: " + mode);
                break;
        }
    }
}

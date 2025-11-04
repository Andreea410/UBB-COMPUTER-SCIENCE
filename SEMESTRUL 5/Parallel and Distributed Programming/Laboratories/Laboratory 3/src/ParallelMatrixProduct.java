public class ParallelMatrixProduct {
    public static void main(String[] args) throws InterruptedException {
        if (args.length < 3) {
            System.out.println("Usage: java ParallelMatrixProduct <matrixSize> <numThreads> <mode>");
            System.out.println("Modes: row | col | kth");
            return;
        }

        int n = Integer.parseInt(args[0]);
        int numThreads = Integer.parseInt(args[1]);
        String mode = args[2];

        System.out.printf("Running matrix multiplication %dx%d using %d threads in '%s' mode%n",
                n, n, numThreads, mode);

        double[][] A = MatrixMultiplier.generateMatrix(n, n);
        double[][] B = MatrixMultiplier.generateMatrix(n, n);
        double[][] C = new double[n][n];

        int totalElements = n * n;
        int elementsPerThread = (int) Math.ceil((double) totalElements / numThreads);
        Thread[] threads = new Thread[numThreads];

        long startTime = System.nanoTime();

        for (int i = 0; i < numThreads; i++) {
            int start = i * elementsPerThread;
            int end = Math.min(start + elementsPerThread, totalElements);
            threads[i] = new Thread(new Worker(A, B, C, start, end, i, numThreads, mode));
            threads[i].start();
        }

        for (Thread t : threads) {
            t.join();
        }

        long endTime = System.nanoTime();

        System.out.printf("Execution time: %.3f ms%n", (endTime - startTime) / 1e6);
    }
}

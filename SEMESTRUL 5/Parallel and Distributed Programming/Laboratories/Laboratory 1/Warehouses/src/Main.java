import java.util.concurrent.BrokenBarrierException;
import java.util.concurrent.CyclicBarrier;

public class Main {
    private final static int NUM_WAREHOUSES = 5;
    private final static int NUM_PRODUCTS = 3;
    private final static int NUM_THREADS = 4;
    private final static int OPERATIONS_PER_THREAD = 1000000;

    private final static CyclicBarrier barrier = new CyclicBarrier(NUM_THREADS + 1);

    public static void main(String[] args) throws InterruptedException {
        WarehouseSystem system = new WarehouseSystem(NUM_WAREHOUSES, NUM_PRODUCTS);

        int[] initialTotals = new int[NUM_PRODUCTS];
        for (int i = 0; i < NUM_PRODUCTS; i++) {
            initialTotals[i] = system.totalForProduct(i);
        }

        System.out.println("Initial totals per product:");
        for (int i = 0; i < NUM_PRODUCTS; i++) {
            System.out.printf("Product %d: %d%n", i, initialTotals[i]);
        }

        Thread[] workers = new Thread[NUM_THREADS];
        long startTime = System.currentTimeMillis();

        for (int t = 0; t < NUM_THREADS; t++) {
            workers[t] = new Thread(() -> {
                try {
                    for (int i = 0; i < OPERATIONS_PER_THREAD; i++) {
                        system.randomMoveOperation();

                        if ((i + 1) % 100 == 0) {
                            barrier.await();
                        }
                    }
                    barrier.await();

                } catch (InterruptedException | BrokenBarrierException e) {
                    throw new RuntimeException(e);
                }
            }, "Worker-" + t);
            workers[t].start();
        }

        Thread checker = new Thread(() -> {
            boolean done = false;
            while (!done) {
                try {
                    barrier.await();
                    if (invariantCheck(system, initialTotals))
                        System.out.println("\nAll invariants respected!");
                    else {
                        System.out.println("\nInvariant(s) broken — check your locks!");
                        throw new RuntimeException("Invariant is broken");
                    }

                    done = allThreadsTerminated(workers);
                } catch (InterruptedException | BrokenBarrierException e) {
                    break;
                }
            }
        }, "Checker");

        checker.start();

        for (Thread t : workers) {
            t.join();
        }

        checker.join();
        long endTime = System.currentTimeMillis();

        long durationMs = endTime - startTime;
        System.out.println("\n=== FINAL CHECK ===");
        if (invariantCheck(system, initialTotals))
            System.out.println("\nAll invariants respected!");
        else
            System.out.println("\nInvariant(s) broken — check your locks!");

        System.out.println("Execution time: " + durationMs + " ms");
    }

    private static boolean allThreadsTerminated(Thread[] threads) {
        for (Thread t : threads) {
            if (t.isAlive()) return false;
        }
        return true;
    }

    public static boolean invariantCheck(WarehouseSystem system, int[] initialTotals) {
        System.out.println("\n=== Inventory Check ===");
        for (int i = 0; i < initialTotals.length; i++) {
            int total = system.totalForProduct(i);
            System.out.printf("Product %d: total = %d (initial = %d)%n", i, total, initialTotals[i]);
            if (total != initialTotals[i]) {
                System.out.println("Invariant violated for product " + i);
                return false;
            }
        }
        return true;
    }
}

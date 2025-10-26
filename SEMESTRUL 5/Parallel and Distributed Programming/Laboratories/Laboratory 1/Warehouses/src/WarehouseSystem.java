import java.util.Random;
import java.util.concurrent.locks.ReentrantReadWriteLock;

public class WarehouseSystem {
    private final Warehouse[] warehouses;
    private final int numProducts;
    private final Random random = new Random();
    private final ReentrantReadWriteLock rwLock = new ReentrantReadWriteLock();

    public WarehouseSystem(int numWarehouses, int numProducts) {
        this.numProducts = numProducts;
        this.warehouses = new Warehouse[numWarehouses];

        for (int i = 0; i < numWarehouses; i++) {
            int[] quantities = new int[numProducts];
            for (int j = 0; j < numProducts; j++) {
                quantities[j] = random.nextInt(201);
            }
            warehouses[i] = new Warehouse(quantities);
        }
    }

    public void move(int src, int dst, int productId, int amount) {
        if (src == dst) return;

        rwLock.writeLock().lock();
        try {
            if (warehouses[src].removeProduct(productId, amount)) {
                warehouses[dst].addProduct(productId, amount);
            }
            System.out.println("Moved " + productId + " from warehouse " + src + " to warehouse " + dst);
        } finally {
            rwLock.writeLock().unlock();
        }
    }


    public void randomMoveOperation() {
        int src = random.nextInt(warehouses.length);
        int dst;
        do {
            dst = random.nextInt(warehouses.length);
        } while (dst == src);

        int productId = random.nextInt(numProducts);
        int amount = random.nextInt(10) + 1;

        move(src, dst, productId, amount);
    }

    public int totalForProduct(int productId) {
        rwLock.readLock().lock();
        try {
            int total = 0;
            for (Warehouse w : warehouses) {
                total += w.getProductQuantity(productId);
            }
            return total;
        } finally {
            rwLock.readLock().unlock();
        }
    }
}

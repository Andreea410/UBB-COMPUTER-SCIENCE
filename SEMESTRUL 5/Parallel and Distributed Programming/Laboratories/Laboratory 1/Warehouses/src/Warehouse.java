import java.util.concurrent.locks.ReentrantLock;

public class Warehouse {
    private final int[] products;

    public Warehouse(int[] initialQuantities) {
        this.products = initialQuantities.clone();
    }

    public int getProductQuantity(int productId) {
        return products[productId];
    }

    public boolean removeProduct(int productId, int amount) {
        if (products[productId] >= amount) {
            products[productId] -= amount;
            return true;
        }
        return false;
    }

    public void addProduct(int productId, int amount) {
        products[productId] += amount;
    }
}

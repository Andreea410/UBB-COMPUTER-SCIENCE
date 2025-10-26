import java.util.*;
import java.util.concurrent.locks.*;

class SharedQueue {
    private final Queue<Integer> queue = new LinkedList<>();
    private final int maxSize;
    private boolean done = false;

    private final Lock lock = new ReentrantLock();
    private final Condition notFull = lock.newCondition();
    private final Condition notEmpty = lock.newCondition();

    private long result = 0;

    public SharedQueue(int maxSize) {
        this.maxSize = maxSize;
    }

    public void produce(int value) throws InterruptedException {
        lock.lock();
        try {
            while (queue.size() == maxSize) {
                notFull.await();
            }
            queue.add(value);
            notEmpty.signal();
        } finally {
            lock.unlock();
        }
    }

    public Integer consume() throws InterruptedException {
        lock.lock();
        try {
            while (queue.isEmpty() && !done) {
                notEmpty.await();
            }
            if (queue.isEmpty()) return null;
            int value = queue.poll();
            notFull.signal();
            return value;
        } finally {
            lock.unlock();
        }
    }

    public void setDone() {
        lock.lock();
        try {
            done = true;
            notEmpty.signalAll();
        } finally {
            lock.unlock();
        }
    }

    public void addToResult(long value) {
        lock.lock();
        try {
            result += value;
        } finally {
            lock.unlock();
        }
    }

    public long getResult() {
        return result;
    }
}

class Producer implements Runnable {
    private final Integer[] v1, v2;
    private final SharedQueue queue;

    public Producer(Integer[] v1, Integer[] v2, SharedQueue queue) {
        this.v1 = v1;
        this.v2 = v2;
        this.queue = queue;
    }

    @Override
    public void run() {
        try {
            for (int i = 0; i < v1.length; i++) {
                int product = v1[i] * v2[i];
                queue.produce(product);
                 System.out.println("Produced: " + product);
            }
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        } finally {
            queue.setDone();
        }
    }
}

class Consumer implements Runnable {
    private final SharedQueue queue;

    public Consumer(SharedQueue queue) {
        this.queue = queue;
    }

    @Override
    public void run() {
        try {
            Integer value;
            while ((value = queue.consume()) != null) {
                queue.addToResult(value);
                 System.out.println("Consumed: " + value);
            }
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        }
    }
}

public class ScalarProduct {
    public static void main(String[] args) throws InterruptedException {
        int size = 5;
        int queueSize = 5;

        Integer[] v1 = new Integer[size];
        Integer[] v2 = new Integer[size];
        for (int i = 0; i < size; i++) {
            v1[i] = i % 10;
            v2[i] = i % 10;
        }

        Vector<Integer> v1_to_print = new Vector<Integer>(List.of(v1));
        Vector<Integer> v2_to_print = new Vector<Integer>(List.of(v2));

        System.out.println(v1_to_print);
        System.out.println(v2_to_print);

        SharedQueue queue = new SharedQueue(queueSize);

        long start = System.nanoTime();

        Thread producer = new Thread(new Producer(v1, v2, queue));
        Thread consumer = new Thread(new Consumer(queue));

        producer.start();
        consumer.start();

        producer.join();
        consumer.join();

        long end = System.nanoTime();
        double timeSeconds = (end - start) / 1e9;

        System.out.println("Result = " + queue.getResult());
        System.out.println("Time = " + timeSeconds + " seconds");
    }
}

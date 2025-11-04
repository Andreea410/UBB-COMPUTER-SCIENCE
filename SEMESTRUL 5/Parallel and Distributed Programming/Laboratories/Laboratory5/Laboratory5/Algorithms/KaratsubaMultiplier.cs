using System.Diagnostics;

namespace lab_5.Algorithms;

static class KaratsubaMultiplier
{
    private const int PARALLEL_THRESHOLD = 32;

    public static long Benchmark(int[] a, int[] b, bool parallel)
    {
        Stopwatch sw = Stopwatch.StartNew();
        int[] result = new int[a.Length * 2];
        if (parallel)
            MultiplyParallel(a, b, result, a.Length);
        else
            MultiplySequential(a, b, result, a.Length);
        sw.Stop();
        return sw.ElapsedMilliseconds;
    }

    public static void MultiplySequential(int[] a, int[] b, int[] result, int n)
    {
        if (n <= 2)
        {
            for (int i = 0; i < n; i++)
                for (int j = 0; j < n; j++)
                    result[i + j] += a[i] * b[j];
            return;
        }

        int k = n / 2;
        var (aLow, aHigh) = Split(a, k);
        var (bLow, bHigh) = Split(b, k);

        int[] z0 = new int[2 * k];
        int[] z1 = new int[2 * k];
        int[] z2 = new int[2 * k];

        MultiplySequential(aLow, bLow, z0, k);
        MultiplySequential(aHigh, bHigh, z2, k);

        int[] sumA = Sum(aLow, aHigh);
        int[] sumB = Sum(bLow, bHigh);

        MultiplySequential(sumA, sumB, z1, k);
        Subtract(z1, z0, z2);

        Combine(result, z0, z1, z2, k);
    }

    public static void MultiplyParallel(int[] a, int[] b, int[] result, int n)
    {
        if (n <= PARALLEL_THRESHOLD)
        {
            MultiplySequential(a, b, result, n);
            return;
        }

        int k = n / 2;
        var (aLow, aHigh) = Split(a, k);
        var (bLow, bHigh) = Split(b, k);

        int[] z0 = new int[2 * k];
        int[] z1 = new int[2 * k];
        int[] z2 = new int[2 * k];

        var t1 = Task.Run(() => MultiplyParallel(aLow, bLow, z0, k));
        var t2 = Task.Run(() => MultiplyParallel(aHigh, bHigh, z2, k));

        int[] sumA = Sum(aLow, aHigh);
        int[] sumB = Sum(bLow, bHigh);
        MultiplyParallel(sumA, sumB, z1, k);

        Task.WaitAll(t1, t2);
        Subtract(z1, z0, z2);
        Combine(result, z0, z1, z2, k);
    }

    private static (int[], int[]) Split(int[] arr, int mid)
    {
        int[] low = new int[mid];
        int[] high = new int[mid];
        Array.Copy(arr, 0, low, 0, mid);
        Array.Copy(arr, mid, high, 0, mid);
        return (low, high);
    }

    private static int[] Sum(int[] a, int[] b)
    {
        int[] sum = new int[a.Length];
        for (int i = 0; i < a.Length; i++)
            sum[i] = a[i] + b[i];
        return sum;
    }

    private static void Subtract(int[] target, int[] z0, int[] z2)
    {
        for (int i = 0; i < target.Length; i++)
            target[i] -= (z0[i] + z2[i]);
    }

    private static void Combine(int[] result, int[] z0, int[] z1, int[] z2, int k)
    {
        for (int i = 0; i < z0.Length; i++) result[i] += z0[i];
        for (int i = 0; i < z1.Length; i++) result[i + k] += z1[i];
        for (int i = 0; i < z2.Length; i++) result[i + 2 * k] += z2[i];
    }
}

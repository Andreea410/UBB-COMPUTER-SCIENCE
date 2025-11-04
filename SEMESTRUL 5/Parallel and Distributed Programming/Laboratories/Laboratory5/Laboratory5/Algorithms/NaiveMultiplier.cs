using System.Diagnostics;
using System.Threading;

namespace lab_5.Algorithms;

static class NaiveMultiplier
{
    public static int[] MultiplySequential(int[] a, int[] b)
    {
        int[] result = new int[a.Length + b.Length - 1];
        for (int i = 0; i < a.Length; i++)
        for (int j = 0; j < b.Length; j++)
            result[i + j] += a[i] * b[j];
        return result;
    }

    public static int[] MultiplyParallel(int[] a, int[] b)
    {
        int[] result = new int[a.Length + b.Length - 1];
        Parallel.For(0, a.Length, i =>
        {
            for (int j = 0; j < b.Length; j++)
                Interlocked.Add(ref result[i + j], a[i] * b[j]);
        });
        return result;
    }

    public static long Benchmark(int[] a, int[] b, bool parallel)
    {
        Stopwatch sw = Stopwatch.StartNew();
        if (parallel)
            MultiplyParallel(a, b);
        else
            MultiplySequential(a, b);
        sw.Stop();
        return sw.ElapsedMilliseconds;
    }
}
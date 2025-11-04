using lab_5.Algorithms;
using lab_5.Models;

namespace lab_5;

static class BenchmarkRunner
{
    public static void Run(int degree, bool largeNumbers = false)
    {
        var p1 = Polynomial.Random(degree, largeNumbers);
        var p2 = Polynomial.Random(degree, largeNumbers);

        Console.WriteLine($"\n=== DEGREE {degree}, {(largeNumbers ? "LARGE" : "SMALL")} COEFFICIENTS ===");

        Console.WriteLine("\n[Naive Sequential]");
        Console.WriteLine($"Time: {NaiveMultiplier.Benchmark(p1.Coefficients, p2.Coefficients, parallel: false)} ms");

        Console.WriteLine("\n[Naive Parallel]");
        Console.WriteLine($"Time: {NaiveMultiplier.Benchmark(p1.Coefficients, p2.Coefficients, parallel: true)} ms");

        Console.WriteLine("\n[Karatsuba Sequential]");
        Console.WriteLine($"Time: {KaratsubaMultiplier.Benchmark(p1.Coefficients, p2.Coefficients, parallel: false)} ms");

        Console.WriteLine("\n[Karatsuba Parallel]");
        Console.WriteLine($"Time: {KaratsubaMultiplier.Benchmark(p1.Coefficients, p2.Coefficients, parallel: true)} ms");
    }
}
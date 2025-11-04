namespace lab_5;

class Program
{
    static void Main()
    {
        BenchmarkRunner.Run(8192, largeNumbers: false);
        BenchmarkRunner.Run(65536, largeNumbers: true);
    }
}
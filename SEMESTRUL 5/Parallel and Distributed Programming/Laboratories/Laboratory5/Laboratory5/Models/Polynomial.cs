namespace lab_5.Models;

class Polynomial
{
    public int[] Coefficients { get; }

    public Polynomial(int[] coefficients)
    {
        Coefficients = coefficients;
    }

    public int Degree => Coefficients.Length;

    public static Polynomial Random(int degree, bool largeNumbers = false)
    {
        Random rand = new();
        int[] coeffs = new int[degree];
        for (int i = 0; i < degree; i++)
            coeffs[i] = largeNumbers ? rand.Next(-1000, 1001) : rand.Next(-10, 11);
        return new Polynomial(coeffs);
    }
}
using System;

namespace rt;

public class Quaternion(double w, double x, double y, double z)
{
    public static readonly Quaternion NONE = new(0, 1, 0, 0);
    public double W { get; set; } = w;
    public double X { get; set; } = x;
    public double Y { get; set; } = y;
    public double Z { get; set; } = z;

    public Quaternion Normalize()
    {
        var a = Math.Sqrt(W*W+X*X+Y*Y+Z*Z);
        W /= a;
        X /= a;
        Y /= a;
        Z /= a;
        return this;
    }

    public static Quaternion FromAxisAngle(double angle, Vector axis)
    {
        var halfAngle = angle / 2.0;
        var sinHalf = Math.Sin(halfAngle);
        var cosHalf = Math.Cos(halfAngle);

        return new Quaternion(
            cosHalf,
            axis.X * sinHalf,
            axis.Y * sinHalf,
            axis.Z * sinHalf
        );
    }
}

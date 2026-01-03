using System;

namespace rt
{
    public class Vector(double x, double y, double z)
    {
        public static Vector I = new Vector(1, 0, 0);
        public static Vector J = new Vector(0, 1, 0);
        public static Vector K = new Vector(0, 0, 1);
        
        public double X { get; set; } = x;
        public double Y { get; set; } = y;
        public double Z { get; set; } = z;

        public Vector() : this(0, 0, 0)
        {
        }

        public Vector(Vector v) : this(v.X, v.Y, v.Z)
        {
        }

        public static Vector operator +(Vector a, Vector b)
        {
            return new Vector(a.X + b.X, a.Y + b.Y, a.Z + b.Z);
        }

        public static Vector operator -(Vector a, Vector b)
        {
            return new Vector(a.X - b.X, a.Y - b.Y, a.Z - b.Z);
        }

        public static double operator *(Vector v, Vector b)
        {
            return v.X * b.X + v.Y * b.Y + v.Z * b.Z;
        }

        public static Vector operator ^(Vector a, Vector b)
        {
            return new Vector(a.Y * b.Z - a.Z * b.Y, a.Z * b.X - a.X * b.Z, a.X * b.Y - a.Y * b.X);
        }

        public static Vector operator *(Vector v, double k)
        {
            return new Vector(v.X * k, v.Y * k, v.Z * k);
        }

        public static Vector operator /(Vector v, double k)
        {
            return new Vector(v.X / k, v.Y / k, v.Z / k);
        }

        public void Multiply(Vector k)
        {
            X *= k.X;
            Y *= k.Y;
            Z *= k.Z;
        }

        public void Divide(Vector k)
        {
            X /= k.X;
            Y /= k.Y;
            Z /= k.Z;
        }

        public double Length2()
        {
            return X * X + Y * Y + Z * Z;
        }

        public double Length()
        {
            return Math.Sqrt(Length2());
        }

        public Vector Normalize()
        {
            var norm = Length();
            if (norm > 0.0)
            {
                X /= norm;
                Y /= norm;
                Z /= norm;
            }
            return this;
        }
        
        public void Rotate(Quaternion q)
        {
            var qv_w = -q.X * X - q.Y * Y - q.Z * Z;
            var qv_x =  q.W * X + q.Y * Z - q.Z * Y;
            var qv_y =  q.W * Y - q.X * Z + q.Z * X;
            var qv_z =  q.W * Z + q.X * Y - q.Y * X;

            X = -qv_w * q.X + qv_x * q.W - qv_y * q.Z + qv_z * q.Y;
            Y = -qv_w * q.Y + qv_x * q.Z + qv_y * q.W - qv_z * q.X;
            Z = -qv_w * q.Z - qv_x * q.Y + qv_y * q.X + qv_z * q.W;
        }
    }
}

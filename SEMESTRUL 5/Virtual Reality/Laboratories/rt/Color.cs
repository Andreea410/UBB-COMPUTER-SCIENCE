using System;
using SkiaSharp;

namespace rt
{
    public class Color(double red, double green, double blue, double alpha)
    {
        public static readonly Color NONE =    new Color(0.0, 0.0, 0.0, 0.0); 
        public static readonly Color RED =     new Color(1.0, 0.0, 0.0, 1.0); 
        public static readonly Color GREEN =   new Color(0.0, 1.0, 0.0, 1.0); 
        public static readonly Color BLUE =    new Color(0.0, 0.0, 1.0, 1.0); 
        public static readonly Color YELLOW =  new Color(1.0, 1.0, 0.0, 1.0); 
        public static readonly Color MAGENTA = new Color(1.0, 0.0, 1.0, 1.0); 
        public static readonly Color CYAN =    new Color(0.0, 1.0, 1.0, 1.0); 
        public static readonly Color WHITE =   new Color(1.0, 1.0, 1.0, 1.0); 
        public static readonly Color ORANGE =  new Color(1.0, 0.5, 0.0, 1.0);

        private double Red { get; } = red;
        private double Green { get; } = green;
        private double Blue { get; } = blue;
        public double Alpha { get; } = alpha;

        public Color() : this(0, 0, 0, 0)
        {
        }

        public Color(Color c) : this(c.Red, c.Green, c.Blue, c.Alpha)
        {
        }

        public SKColor ToSystemColor()
        {
            var r = (byte)Math.Min((int)Math.Ceiling(Red * 255), 255);
            var g = (byte)Math.Min((int)Math.Ceiling(Green * 255), 255);
            var b = (byte)Math.Min((int)Math.Ceiling(Blue * 255), 255);

            return new SKColor(r, g, b, 255);
        }

        public static Color operator +(Color a, Color b)
        {
            return new Color(a.Red + b.Red, a.Green + b.Green, a.Blue + b.Blue, a.Alpha + b.Alpha);
        }

        public static Color operator -(Color a, Color b)
        {
            return new Color(a.Red - b.Red, a.Green - b.Green, a.Blue - b.Blue, a.Alpha - b.Alpha);
        }


        public static Color operator *(Color a, Color b)
        {
            return new Color(a.Red * b.Red, a.Green * b.Green, a.Blue * b.Blue, a.Alpha * b.Alpha);
        }

        public static Color operator /(Color a, Color b)
        {
            return new Color(a.Red / b.Red, a.Green / b.Green, a.Blue / b.Blue, a.Alpha / b.Alpha);
        }

        public static Color operator *(Color c, double k)
        {
            return new Color(c.Red * k, c.Green * k, c.Blue * k, c.Alpha * k);
        }

        public static Color operator /(Color c, double k)
        {
            return new Color(c.Red / k, c.Green / k, c.Blue / k, c.Alpha / k);
        }
    }
}

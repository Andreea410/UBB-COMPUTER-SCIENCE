using System;
using System.IO;
using System.Text.RegularExpressions;

namespace rt;

public class CtScan: Geometry
{
    private readonly Vector _position;
    private readonly double _scale;
    private readonly ColorMap _colorMap;
    private readonly byte[] _data;
    private readonly int[] _resolution = new int[3];
    private readonly double[] _thickness = new double[3];
    private readonly Vector _v0;
    private readonly Vector _v1;

    public CtScan(string datFile, string rawFile, Vector position, double scale, ColorMap colorMap) : base(Color.NONE)
    {
        _position = position;
        _scale = scale;
        _colorMap = colorMap;

        var lines = File.ReadLines(datFile);
        foreach (var line in lines)
        {
            var kv = Regex.Replace(line, ":[\\\t ]+", ":").Split(":", 2);
            if (kv.Length < 2) continue;
            var key = kv[0].Trim();
            var value = kv[1].Trim();
            if (key == "Resolution")
            {
                var parts = Regex.Split(value, "\\s+");
                if (parts.Length >= 3)
                {
                    _resolution[0] = Convert.ToInt32(parts[0]);
                    _resolution[1] = Convert.ToInt32(parts[1]);
                    _resolution[2] = Convert.ToInt32(parts[2]);
                }
            }
            else if (key == "SliceThickness")
            {
                var parts = Regex.Split(value, "\\s+");
                if (parts.Length >= 3)
                {
                    _thickness[0] = Convert.ToDouble(parts[0]);
                    _thickness[1] = Convert.ToDouble(parts[1]);
                    _thickness[2] = Convert.ToDouble(parts[2]);
                }
            }
        }

        _v0 = position;
        _v1 = position + new Vector(_resolution[0]*_thickness[0]*scale, _resolution[1]*_thickness[1]*scale, _resolution[2]*_thickness[2]*scale);

        var len = _resolution[0] * _resolution[1] * _resolution[2];
        _data = new byte[len];
        using FileStream f = new FileStream(rawFile, FileMode.Open, FileAccess.Read);
        if (f.Read(_data, 0, len) != len)
        {
            throw new InvalidDataException($"Failed to read the {len}-byte raw data");
        }
    }

    private ushort Value(int x, int y, int z)
    {
        if (x < 0 || y < 0 || z < 0 || x >= _resolution[0] || y >= _resolution[1] || z >= _resolution[2])
        {
            return 0;
        }

        return _data[z * _resolution[1] * _resolution[0] + y * _resolution[0] + x];
    }

    public override Intersection GetIntersection(Line line, double minDist, double maxDist)
    {
        double tMin = minDist;
        double tMax = maxDist;

        for (int i = 0; i < 3; i++)
        {
            double origin = i == 0 ? line.X0.X : (i == 1 ? line.X0.Y : line.X0.Z);
            double dir = i == 0 ? line.Dx.X : (i == 1 ? line.Dx.Y : line.Dx.Z);
            double boxMin = i == 0 ? _v0.X : (i == 1 ? _v0.Y : _v0.Z);
            double boxMax = i == 0 ? _v1.X : (i == 1 ? _v1.Y : _v1.Z);

            if (Math.Abs(dir) < 1e-8)
            {
                if (origin < boxMin || origin > boxMax)
                {
                    return Intersection.NONE;
                }
            }
            else
            {
                double t1 = (boxMin - origin) / dir;
                double t2 = (boxMax - origin) / dir;

                if (t1 > t2)
                {
                    (t1, t2) = (t2, t1);
                }

                tMin = Math.Max(tMin, t1);
                tMax = Math.Min(tMax, t2);

                if (tMin > tMax)
                {
                    return Intersection.NONE;
                }
            }
        }

        double stepSize = Math.Min(_thickness[0], Math.Min(_thickness[1], _thickness[2])) * _scale * 0.5;
        double t = Math.Max(tMin, minDist) + stepSize * 0.05;

        Color accumulatedColor = new Color(0, 0, 0, 0);
        double accumulatedAlpha = 0.0;

        double firstHitT = -1;
        Vector firstHitPosition = null;

        while (t <= tMax && accumulatedAlpha < 1)
        {
            Vector position = line.CoordinateToPosition(t);
            Color color = GetColor(position);

            if (color.Alpha > 0.0)
            {
                if (firstHitT < 0)
                {
                    firstHitT = t;
                    firstHitPosition = position;
                }

                double weight = color.Alpha * (1.0 - accumulatedAlpha);
                accumulatedColor += color * weight;
                accumulatedAlpha += weight;
            }

            t += stepSize;
        }

        if (accumulatedAlpha > 0.0 && firstHitPosition != null)
        {
            Vector normal = GetNormal(firstHitPosition);
            Material material = Material.FromColor(accumulatedColor);
            return new Intersection(true, true, this, line, firstHitT, normal, material, accumulatedColor);
        }

        return Intersection.NONE;
    }

    private int[] GetIndexes(Vector v)
    {
        return new []{
            (int)Math.Floor((v.X - _position.X) / _thickness[0] / _scale), 
            (int)Math.Floor((v.Y - _position.Y) / _thickness[1] / _scale),
            (int)Math.Floor((v.Z - _position.Z) / _thickness[2] / _scale)};
    }

    private Color GetColor(Vector v)
    {
        int[] idx = GetIndexes(v);

        ushort value = Value(idx[0], idx[1], idx[2]);
        return _colorMap.GetColor(value);
    }

    private Vector GetNormal(Vector v)
    {
        int[] idx = GetIndexes(v);
        double x0 = Value(idx[0] - 1, idx[1], idx[2]);
        double x1 = Value(idx[0] + 1, idx[1], idx[2]);
        double y0 = Value(idx[0], idx[1] - 1, idx[2]);
        double y1 = Value(idx[0], idx[1] + 1, idx[2]);
        double z0 = Value(idx[0], idx[1], idx[2] - 1);
        double z1 = Value(idx[0], idx[1], idx[2] + 1);

        return new Vector(x1 - x0, y1 - y0, z1 - z0).Normalize();
    }
}

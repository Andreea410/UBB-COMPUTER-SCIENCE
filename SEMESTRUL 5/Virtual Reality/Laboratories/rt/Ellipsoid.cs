using System;

namespace rt
{
    public class Ellipsoid : Geometry
    {
        private Vector Center { get; }
        private Vector SemiAxesLength { get; }
        private double Radius { get; }

        public Quaternion Rotation { get; set; } = Quaternion.NONE;

        public Ellipsoid(Vector center, Vector semiAxesLength, double radius, Material material, Color color) : base(material, color)
        {
            Center = center;
            SemiAxesLength = semiAxesLength;
            Radius = radius;
        }

        public Ellipsoid(Vector center, Vector semiAxesLength, double radius, Color color) : base(color)
        {
            Center = center;
            SemiAxesLength = semiAxesLength;
            Radius = radius;
        }

        public Ellipsoid(Ellipsoid e) : this(new Vector(e.Center), new Vector(e.SemiAxesLength), e.Radius, new Material(e.Material), new Color(e.Color))
        {
        }

        public override Intersection GetIntersection(Line line, double minDist, double maxDist)
        {
            var localOrigin = new Vector(line.X0 - Center);
            var localDir = new Vector(line.Dx);

            if (Rotation.W != 0 || Rotation.X != 1 || Rotation.Y != 0 || Rotation.Z != 0)
            {
                localOrigin.Rotate(Rotation);
                localDir.Rotate(Rotation);
            }

            var rx = SemiAxesLength.X * Radius;
            var ry = SemiAxesLength.Y * Radius;
            var rz = SemiAxesLength.Z * Radius;

            var rx2 = rx * rx;
            var ry2 = ry * ry;
            var rz2 = rz * rz;

            var a = (localDir.X * localDir.X / rx2) + (localDir.Y * localDir.Y / ry2) + (localDir.Z * localDir.Z / rz2);
            var b = 2.0 * ((localOrigin.X * localDir.X / rx2) + (localOrigin.Y * localDir.Y / ry2) + (localOrigin.Z * localDir.Z / rz2));
            var c = (localOrigin.X * localOrigin.X / rx2) + (localOrigin.Y * localOrigin.Y / ry2) + (localOrigin.Z * localOrigin.Z / rz2) - 1.0;

            var discriminant = b * b - 4.0 * a * c;

            if (discriminant < 0.0)
            {
                return Intersection.NONE;
            }

            var sqrtDiscriminant = Math.Sqrt(discriminant);
            var t0 = (-b - sqrtDiscriminant) / (2.0 * a);
            var t1 = (-b + sqrtDiscriminant) / (2.0 * a);

            var t = t0;

            if (t < minDist)
            {
                t = t1;
            }

            if (t < minDist || t > maxDist)
            {
                return Intersection.NONE;
            }

            var position = line.CoordinateToPosition(t);

            var localPos = new Vector(position - Center);
            if (Rotation.W != 0 || Rotation.X != 1 || Rotation.Y != 0 || Rotation.Z != 0)
            {
                localPos.Rotate(Rotation);
            }

            var normal = new Vector(
                localPos.X / rx2,
                localPos.Y / ry2,
                localPos.Z / rz2
            );
            normal.Normalize();

            if (Rotation.W != 0 || Rotation.X != 1 || Rotation.Y != 0 || Rotation.Z != 0)
            {
                var invRotation = new Quaternion(Rotation.W, -Rotation.X, -Rotation.Y, -Rotation.Z);
                normal.Rotate(invRotation);
            }

            return new Intersection(true, true, this, line, t, normal, Material, Color);
        }
    }
}

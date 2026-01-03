namespace rt
{
    public abstract class Geometry(Material material, Color color)
    {
        protected Color Color { get; } = color;

        protected Material Material { get; } = material;
            protected Geometry(Color color) : this(Material.FromColor(color), color)
            {
            }

            public abstract Intersection GetIntersection(Line line, double minDist, double maxDist);
    }
}

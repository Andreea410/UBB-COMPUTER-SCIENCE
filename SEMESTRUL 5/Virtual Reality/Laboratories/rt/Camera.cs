namespace rt
{
    public class Camera(
        Vector position,
        Vector direction,
        Vector up,
        double viewPlaneDistance,
        double viewPlaneWidth,
        double viewPlaneHeight,
        double frontPlaneDistance,
        double backPlaneDistance)
    {
        public Vector Position {get; } = position;
        public Vector Direction {get; } = direction;
        public Vector Up {get; private set;} = up;
        public double ViewPlaneDistance {get; } = viewPlaneDistance;
        public double ViewPlaneWidth {get; } = viewPlaneWidth;
        public double ViewPlaneHeight {get; } = viewPlaneHeight;
        public double FrontPlaneDistance {get; } = frontPlaneDistance;
        public double BackPlaneDistance {get; } = backPlaneDistance;

        public void Normalize()
        {
            Direction.Normalize();
            Up.Normalize();
            Up = (Direction ^ Up) ^ Direction;
        }
    }
}

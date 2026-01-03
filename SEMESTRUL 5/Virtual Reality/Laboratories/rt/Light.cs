namespace rt
{
    public class Light
    {
        public Vector Position { get; }

        public Color Ambient { get; }

        public Color Diffuse { get; }

        public Color Specular { get; }

        public Light()
        {
            Position = new Vector();
            Ambient = new Color();
            Diffuse = new Color();
            Specular = new Color();
        }

        public Light(Vector position, Color ambient, Color diffuse, Color specular, double intensity)
        {
            Position = new Vector(position);
            Ambient = new Color(ambient);
            Diffuse = new Color(diffuse);
            Specular = new Color(specular);
        }
    }
}

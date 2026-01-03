namespace rt
{
    public class Material
    {
        public static readonly Material BLANK = new(); 

        public Color Ambient { get; }

        public Color Diffuse { get; }

        public Color Specular { get; }

        public int Shininess { get; }

        public Material()
        {
            Ambient = new Color();
            Diffuse = new Color();
            Specular = new Color();
            Shininess = 0;
        }

        public Material(Color ambient, Color diffuse, Color specular, int shininess)
        {
            Ambient = new Color(ambient);
            Diffuse = new Color(diffuse);
            Specular = new Color(specular);
            Shininess = shininess;
        }
        
        public Material(Material m) : this(m.Ambient, m.Diffuse, m.Specular, m.Shininess)
        {
        }

        public static Material FromColor(Color color)
        {
            return new Material(color*0.1, color*0.3, color*0.5, 100);
        }
    }
}

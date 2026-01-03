using System;

namespace rt
{
    class RayTracer(Geometry[] geometries, Light[] lights)
    {
        private double ImageToViewPlane(int n, int imgSize, double viewPlaneSize)
        {
            return -n * viewPlaneSize / imgSize + viewPlaneSize / 2;
        }

        private Intersection FindFirstIntersection(Line ray, double minDist, double maxDist)
        {
            var intersection = Intersection.NONE;

            foreach (var geometry in geometries)
            {
                var intr = geometry.GetIntersection(ray, minDist, maxDist);

                if (!intr.Valid || !intr.Visible) continue;

                if (!intersection.Valid || !intersection.Visible)
                {
                    intersection = intr;
                }
                else if (intr.T < intersection.T)
                {
                    intersection = intr;
                }
            }

            return intersection;
        }

        private bool IsLit(Vector point, Light light)
        {
            var shadowRay = new Line(point, light.Position);
            var distanceToLight = (light.Position - point).Length();
            var epsilon = 0.001;
            var closestNonCTScan = Intersection.NONE;

            foreach (var geometry in geometries)
            {
                if (geometry is CtScan) continue;

                // Check if this object intersects the shadow ray, and if it does, it is not in shadow
                var intersection = geometry.GetIntersection(shadowRay, epsilon, distanceToLight - epsilon);

                if (!intersection.Valid || !intersection.Visible) continue;

                if (!closestNonCTScan.Valid || intersection.T < closestNonCTScan.T)
                {
                    closestNonCTScan = intersection;
                }
            }

            if (closestNonCTScan.Valid && closestNonCTScan.Visible)
            {
                return false;
            }

            return true;
        }

        public void Render(Camera camera, int width, int height, string filename)
        {
            var background = new Color(0.2, 0.2, 0.2, 1.0);
            var image = new Image(width, height);

            camera.Normalize();
            var right = camera.Up ^ camera.Direction;

            for (var i = 0; i < width; i++)
            {
                for (var j = 0; j < height; j++)
                {
                    var x = ImageToViewPlane(i, width, camera.ViewPlaneWidth);
                    var y = ImageToViewPlane(j, height, camera.ViewPlaneHeight);

                    // Convert pixel to view plane coordinates
                    var viewPlanePoint = camera.Position 
                        + camera.Direction * camera.ViewPlaneDistance
                        + right * x
                        + camera.Up * y;

                    var ray = new Line(camera.Position, viewPlanePoint);

                    var intersection = FindFirstIntersection(ray, camera.FrontPlaneDistance, camera.BackPlaneDistance);

                    if (!intersection.Valid || !intersection.Visible)
                    {
                        image.SetPixel(i, j, background);
                        continue;
                    }

                    var color = new Color(0, 0, 0, 1);
                    var viewDir = (camera.Position - intersection.Position).Normalize();

                    foreach (var light in lights)
                    {
                        var ambientContribution = intersection.Material.Ambient * light.Ambient;
                        color += ambientContribution;

                        if (IsLit(intersection.Position, light))
                        {
                            var lightDir = (light.Position - intersection.Position).Normalize();
                            var dotProduct = intersection.Normal * lightDir;

                            if (dotProduct > 0)
                            {
                                var diffuseContribution = intersection.Material.Diffuse * light.Diffuse * dotProduct;
                                color += diffuseContribution;

                                var reflectDir = (intersection.Normal * (2.0 * dotProduct) - lightDir).Normalize();
                                var specDot = Math.Max(0, reflectDir * viewDir);
                                var specularContribution = intersection.Material.Specular * light.Specular 
                                    * Math.Pow(specDot, intersection.Material.Shininess);
                                color += specularContribution;
                            }
                        }
                    }

                    image.SetPixel(i, j, color);
                }
            }

            image.Store(filename);
        }
    }
}

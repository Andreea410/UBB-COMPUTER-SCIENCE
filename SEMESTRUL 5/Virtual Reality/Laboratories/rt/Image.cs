using System.IO;
using SkiaSharp;

namespace rt
{
    public class Image(int width, int height)
    {
        private readonly SKBitmap _bitmap = new(width, height);

        public void SetPixel(int x, int y, Color c) {
            _bitmap.SetPixel(x, y, c.ToSystemColor());
        }

        public void Store(string filename) {
            using var stream = new FileStream(filename, FileMode.Create, FileAccess.Write);
            using var image = SKImage.FromBitmap(_bitmap); 
            using var encodedImage = image.Encode(SKEncodedImageFormat.Png, 0); 
            encodedImage.SaveTo(stream);
        }
    }
}
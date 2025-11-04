using System.Text;

namespace lab_4;

public class HttpParser
{
    private readonly StringBuilder _buffer = new();
    public bool HeadersParsed { get; private set; }
    public int ContentLength { get; private set; } = -1;

    public void Append(byte[] data, int count)
    {
        _buffer.Append(Encoding.UTF8.GetString(data, 0, count));

        if (!HeadersParsed)
        {
            string content = _buffer.ToString();
            int headerEnd = content.IndexOf("\r\n\r\n", StringComparison.Ordinal);
            if (headerEnd != -1)
            {
                HeadersParsed = true;
                string headers = content[..headerEnd];
                foreach (var line in headers.Split("\r\n"))
                {
                    if (line.StartsWith("Content-Length:", StringComparison.OrdinalIgnoreCase))
                    {
                        var parts = line.Split(':', 2);
                        if (parts.Length == 2 && int.TryParse(parts[1].Trim(), out int len))
                            ContentLength = len;
                    }
                }
            }
        }
    }

    public bool TryGetBody(out string body)
    {
        body = string.Empty;
        if (!HeadersParsed || ContentLength == -1)
            return false;

        string full = _buffer.ToString();
        int headerEnd = full.IndexOf("\r\n\r\n", StringComparison.Ordinal) + 4;
        int bodyLength = full.Length - headerEnd;
        if (bodyLength >= ContentLength)
        {
            body = full.Substring(headerEnd, ContentLength);
            return true;
        }
        return false;
    }
}
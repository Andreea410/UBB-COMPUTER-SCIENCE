using System.Net;
using System.Net.Sockets;
using System.Text;
using static lab_4.SocketHelpers;

namespace lab_4;

class ClientAwait
{
    public static void Run()
    {
        var t1 = DownloadAsync("/file1.txt");
        var t2 = DownloadAsync("/file2.txt");
        Task.WaitAll(t1, t2);
    }

    static async Task DownloadAsync(string fileName)
    {
        var conn = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);
        var endPoint = new IPEndPoint(IPAddress.Loopback, 6767);
        var parser = new HttpParser();
        var buffer = new byte[4096];

        await ConnectAsync(conn, endPoint);

        string request = $"GET {fileName} HTTP/1.1\r\nHost: localhost\r\nConnection: close\r\n\r\n";
        await SendAsync(conn, Encoding.UTF8.GetBytes(request));

        while (true)
        {
            int bytes = await ReceiveAsync(conn, buffer);
            if (bytes <= 0)
                break;

            parser.Append(buffer, bytes);
            if (parser.TryGetBody(out string body))
            {
                Console.WriteLine($"File {fileName}:\n{body}\n");
                break;
            }
        }

        conn.Close();
    }
}
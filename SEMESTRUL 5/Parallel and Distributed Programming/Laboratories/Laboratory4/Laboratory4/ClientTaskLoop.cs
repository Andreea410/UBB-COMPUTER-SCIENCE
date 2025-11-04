using System.Net;
using System.Net.Sockets;
using System.Text;
using static lab_4.SocketHelpers;

namespace lab_4;

class ClientTaskLoop
{
    public static void Run()
    {
        var t1 = Download("/file1.txt");
        var t2 = Download("/file2.txt");
        Task.WaitAll(t1, t2);
    }

    static Task<bool> Download(string fileName)
    {
        var conn = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);
        var endPoint = new IPEndPoint(IPAddress.Loopback, 6767);
        var parser = new HttpParser();
        var buffer = new byte[4096];

        return ConnectAsync(conn, endPoint)
            .ContinueWith(_ =>
            {
                string req = $"GET {fileName} HTTP/1.1\r\nHost: localhost\r\nConnection: close\r\n\r\n";
                return SendAsync(conn, Encoding.UTF8.GetBytes(req));
            })
            .Unwrap()
            .ContinueWith(_ =>
            {
                var done = new TaskCompletionSource<bool>();
                void ReceiveLoop()
                {
                    ReceiveAsync(conn, buffer).ContinueWith(r =>
                    {
                        int bytes = r.Result;
                        if (bytes <= 0)
                        {
                            conn.Close();
                            done.SetResult(true);
                            return;
                        }

                        parser.Append(buffer, bytes);
                        if (parser.TryGetBody(out string body))
                        {
                            Console.WriteLine($"File {fileName}:\n{body}\n");
                            conn.Close();
                            done.SetResult(true);
                        }
                        else
                        {
                            ReceiveLoop();
                        }
                    });
                }
                ReceiveLoop();
                return done.Task;
            })
            .Unwrap();
    }
}

using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Threading;

namespace lab_4;

class ClientBeginEnd
{
    static CountdownEvent allDone = new CountdownEvent(2);

    class DownloadState
    {
        public Socket? Conn;
        public string FileName = "";
        public byte[] Buffer = new byte[4096];
        public HttpParser Parser = new();
    }

    public static void Run()
    {
        Download("/file1.txt");
        Download("/file2.txt");

        allDone.Wait();
    }

    static void Download(string fileName)
    {
        var conn = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);
        var endPoint = new IPEndPoint(IPAddress.Loopback, 6767);
        var state = new DownloadState { Conn = conn, FileName = fileName };

        conn.BeginConnect(endPoint, ConnectCallback, state);
    }

    static void ConnectCallback(IAsyncResult ar)
    {
        var state = (DownloadState)ar.AsyncState!;
        state.Conn!.EndConnect(ar);

        string request = $"GET {state.FileName} HTTP/1.1\r\nHost: localhost\r\nConnection: close\r\n\r\n";
        byte[] bytes = Encoding.UTF8.GetBytes(request);

        state.Conn.BeginSend(bytes, 0, bytes.Length, SocketFlags.None, SendCallback, state);
    }

    static void SendCallback(IAsyncResult ar)
    {
        var state = (DownloadState)ar.AsyncState!;
        state.Conn!.EndSend(ar);

        state.Conn.BeginReceive(state.Buffer, 0, state.Buffer.Length, SocketFlags.None, ReceiveCallback, state);
    }

    static void ReceiveCallback(IAsyncResult ar)
    {
        var state = (DownloadState)ar.AsyncState!;
        int bytes = state.Conn!.EndReceive(ar);

        // If connection closed
        if (bytes <= 0)
        {
            state.Conn.Close();
            return;
        }

        state.Parser.Append(state.Buffer, bytes);

        if (state.Parser.TryGetBody(out string body))
        {
            Console.WriteLine($"File {state.FileName}:\n{body}\n");
            state.Conn.Close();

            allDone.Signal();
        }
        else
        {
            state.Conn.BeginReceive(state.Buffer, 0, state.Buffer.Length, SocketFlags.None, ReceiveCallback, state);
        }
    }
}

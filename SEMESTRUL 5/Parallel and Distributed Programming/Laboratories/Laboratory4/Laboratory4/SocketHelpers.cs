using System.Net;
using System.Net.Sockets;

namespace lab_4;

public static class SocketHelpers
{
    public static Task<bool> ConnectAsync(Socket socket, EndPoint endPoint)
    {
        var tcs = new TaskCompletionSource<bool>();
        socket.BeginConnect(endPoint, ar =>
        {
            try
            {
                socket.EndConnect(ar);
                tcs.TrySetResult(true);
            }
            catch (Exception ex)
            {
                tcs.TrySetException(ex);
            }
        }, null);
        return tcs.Task;
    }

    public static Task<int> SendAsync(Socket socket, byte[] data)
    {
        var tcs = new TaskCompletionSource<int>();
        socket.BeginSend(data, 0, data.Length, SocketFlags.None, ar =>
        {
            try
            {
                int sent = socket.EndSend(ar);
                tcs.TrySetResult(sent);
            }
            catch (Exception ex)
            {
                tcs.TrySetException(ex);
            }
        }, null);
        return tcs.Task;
    }

    public static Task<int> ReceiveAsync(Socket socket, byte[] buffer)
    {
        var tcs = new TaskCompletionSource<int>();
        socket.BeginReceive(buffer, 0, buffer.Length, SocketFlags.None, ar =>
        {
            try
            {
                int received = socket.EndReceive(ar);
                tcs.TrySetResult(received);
            }
            catch (Exception ex)
            {
                tcs.TrySetException(ex);
            }
        }, null);
        return tcs.Task;
    }
}
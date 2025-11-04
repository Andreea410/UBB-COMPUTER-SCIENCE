namespace lab_4;

class Program
{
    static void Main(string[] args)
    {
        if (args.Length == 0)
        {
            Console.WriteLine("Usage: dotnet run [server|client1|client2|client3]");
            return;
        }

        switch (args[0])
        {
            case "server":
                Server.Run();
                break;
            case "client1":
                ClientBeginEnd.Run();
                break;
            case "client2":
                ClientTaskLoop.Run();
                break;
            case "client3":
                ClientAwait.Run();
                break;
            default:
                Console.WriteLine("Invalid option. Use server|client1|client2|client3.");
                break;
        }
    }
}

import socket
import struct

if __name__ == '__main__':
    udp_socket = socket.socket(socket.AF_INET,socket.SOCK_DGRAM)
    tcp_socket = socket.socket(socket.AF_INET,socket.SOCK_STREAM)

    list = []
    udp_socket.bind(("172.30.251.99",65534))
    try:
        n,address = udp_socket.recvfrom(4)
        if not n:
            exit(1)
    except Exception as e:
        exit(2)
    n = struct.unpack("!I",n)[0]
    for i in range(0,n):
        try:
            e, address = udp_socket.recvfrom(4)
            if not e:
                exit(1)
            e = struct.unpack("!I", e)[0]
            print(f"Received {e}")
        except Exception as e:
            print(e)
            exit(3)
    try:
        function,_ = udp_socket.recvfrom(1024)
    except Exception as e:
        print(e)
        exit(4)
    function = function.decode()
    print(f"Received {function}")
    udp_socket.sendto("HELLO".encode(),address)

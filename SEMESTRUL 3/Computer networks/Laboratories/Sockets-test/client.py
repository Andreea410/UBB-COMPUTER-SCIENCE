import socket
import struct
import random

tcp_address = ("172.30.251.99", 1234)
clients = []


def tcp_socket_init():
    tcp_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    tcp_socket.connect(tcp_address)

    return tcp_socket


def udp_socket_init():
    udp_socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

    return udp_socket


if __name__ == '__main__':
    udp_socket = udp_socket_init()
    tcp_socket = tcp_socket_init()

    port = int(input("Enter the port: "))
    address = ("172.30.243.201",port)

    port = struct.pack("!I",port)
    tcp_socket.send(port)

    while True:
        function = tcp_socket.recv(1024).decode()
        print(f"Client has received the function {function}")
        n = random.randint(5,20)
        string =""
        tcp_socket.send(struct.pack("!I",n))
        for _ in range(0,n):
            x = int(random.randint(0,1))
            y = int(random.randint(0,1))
            print(F"Client generate {x} and {y}")
            tcp_socket.send(struct.pack("!I",x))
            tcp_socket.send(struct.pack("!I",y))




import socket
import struct
import threading
import random

import client

tcp_address = ("172.30.251.99",1234)
clients = []
functions = ["x^2","2*x","3*x"]
threads = []
result_list = []
e = threading.Event()
current_area = 0
number_below = 0
total_number = 0

def broadcast(udp_socket,area):
    message = f"Current area estimates around {area}"
    for client in clients:
        udp_socket.sendto(message.encode(),client)

def tcp_socket_init():
    tcp_socket = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
    tcp_socket.bind(tcp_address)
    tcp_socket.listen()

    return tcp_socket

def udp_socket_init():
    udp_socket = socket.socket(socket.AF_INET,socket.SOCK_DGRAM)
    udp_socket.bind(tcp_address)

    return udp_socket

def handle_client(client_socket,client_address):
    global number_below,current_area
    while True:
        function = random.choice(functions)
        client_socket.send(function.encode())
        n = client_socket.recv(4)
        n = struct.unpack("!I",n)
        for _ in n:
            x = client_socket.recv(4)
            x = struct.unpack("!I", x)[0]
            y = client_socket.recv(4)
            y = struct.unpack("!I", y)[0]
            result_list.append([x,y])
            print(F"Server received {x} and {y}")
        if len(result_list) > 100:
            e.wait()
            for result in result_list:
                if result[1] <= 0:
                    number_below+=1
            current_area = number_below/len(result_list)
            e.set()

if __name__ == '__main__':
    udp_socket = udp_socket_init()
    tcp_socket = tcp_socket_init()

    while True:
        client_socket , client_address = tcp_socket.accept()
        clients.append(client_address)
        port = client_socket.recv(4)
        port = struct.unpack("!I",port)[0]
        print(f"The client is listening on port {port}")
        #udp_socket.bind(("172.30.243.201",port))

        t = threading.Thread(target=handle_client , args=(client_socket,client_address))
        threads.append(t)
        t.start()


import struct
import socket

if __name__ == '__main__':
    tcp_socket = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
    udp_socket = socket.socket(socket.AF_INET,socket.SOCK_DGRAM)

    try:
        udp_socket.sendto(struct.pack("!I",5),("172.30.251.99",65534))
        elements = [1,2,3,4,5]
        for i in range(0,5):
            udp_socket.sendto(struct.pack("!I",i),("172.30.251.99",65534))
            print(f"Sent element {elements[i]}")
        udp_socket.sendto("x^2".encode(),("172.30.251.99",65534))
        string,_ = udp_socket.recvfrom(1024)
        string = string.decode()
        print(f"Received: {string}")
    except Exception as e:
        print(e)
        exit(10)


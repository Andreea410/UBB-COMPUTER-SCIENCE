
import socket
import struct

udp_address = ("0.0.0.0",7777)
tcp_address = ("192.168.0.197",1235)

def udp_server_init():
    udp_socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    udp_socket.bind(udp_address)
    return udp_socket

def tcp_server_init():
    tcp_socket = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
    tcp_socket.connect(tcp_address)
    return tcp_socket

if __name__ == '__main__':

    try:
        udp_socket = udp_server_init()
        tcp_socket = tcp_server_init()
    except socket.error as e:
        print("ERROR ON SOCKET: "+ e)
        exit(-1)

    data,address = udp_socket.recvfrom(1024)
    questions = data.decode().split(';')
    n = len(questions)
    answers = []
    for question in questions:
        print(f"Question: {question}")
        if "+" in question:
            to_solve = question.split('+')
            answer = int(to_solve[0]) + int(to_solve[1])
            answers.append(answer)
            print(f"Answer: {answer}")
        elif "-" in question:
            to_solve = question.split('-')
            answer = int(to_solve[0]) - int(to_solve[1])
            answers.append(answer)
            print(f"Answer: {answer}")
        if question[1] == "/":
            to_solve = question.split('/')
            answer = int(int(to_solve[0]) / int(to_solve[1]))
            answers.append(answer)
            print(f"Answer: {answer}")
        if question[1] == "*":
            to_solve = question.split('*')
            answer = int(to_solve[0]) * int(to_solve[1])
            answers.append(answer)
            print(f"Answer: {answer}")
    for i in range(0,n):
        tcp_socket.send(str(i).encode())
        tcp_socket.send(str(answers[i]).encode())
    tcp_socket.close()
    udp_socket.close()









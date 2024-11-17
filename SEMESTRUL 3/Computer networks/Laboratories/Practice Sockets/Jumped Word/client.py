#===Jumbled Word Game===
#Description: The server picks a random word, jumbles the letters, and sends it to all clients. Clients have to guess the original word.
#Twist: The server sometimes sends an impossible jumble that can't be solved. If clients notice and complain, they get bonus points.
#Challenge: Keep track of client guesses and handle scoring fairly despite the occasional trick.

import struct
import socket

if __name__ == '__main__':

    try:
        client_socket = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
        client_socket.connect(("192.168.0.197",1234))
    except socket.error as e:
        print("Error on connecting: "+e)
        exit(1)

    while True:
        shuffled_word = client_socket.recv(1024).decode()
        print(f"Shuffled word: {shuffled_word}")
        guessed_word = input("Enter your guess or 0 if you think is impossible: ")
        client_socket.send(guessed_word.encode())
        response = client_socket.recv(1024).decode()
        print(response)



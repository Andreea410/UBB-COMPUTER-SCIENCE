#===Jumbled Word Game===
#Description: The server picks a random word, jumbles the letters, and sends it to all clients. Clients have to guess the original word.
#Twist: The server sometimes sends an impossible jumble that can't be solved. If clients notice and complain, they get bonus points.
#Challenge: Keep track of client guesses and handle scoring fairly despite the occasional trick.

import struct
import socket
import threading
import random

words = ["kjbka","python","computer","networks","test","midterm"]
word_to_guess = ""
clients_with_scores = {}


def handle_client(client_socket):
    global word_to_guess
    while True:
        word_to_guess = random.choice(words)
        shuffled_word = ''.join(random.sample(word_to_guess, len(word_to_guess)))
        print(f"Server picked {word_to_guess} and send {shuffled_word} to the client.")
        client_socket.send(shuffled_word.encode())
        guess = client_socket.recv(1024).decode()
        if guess == "0" and word_to_guess =="kjbka" :
            string = "Congratulations you guessed it was a trick.You get a bonus point."
            client_socket.send(string.encode())
            clients_with_scores[client_address] += 2

        elif guess == "0" or guess!=word_to_guess:
            string = "Unfortunately you guessed wrong.:("
            client_socket.send(string.encode())
        else:
            string = "Congratulations you guessed right."
            client_socket.send(string.encode())
            clients_with_scores[client_address] += 1
        print(clients_with_scores)


if __name__ == '__main__':
    try:
        server_socket = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
        server_socket.bind(("192.168.0.197",1234))
        server_socket.listen(10)
    except Exception as e:
        print(e)
        exit(2)

    while True:
        client_socket,client_address = server_socket.accept()
        print(F"Client {client_address} has connected.")
        clients_with_scores[client_address] = 0
        t = threading.Thread(target=handle_client,args=(client_socket,))
        t.start()




import socket
import threading
import time

# Quiz questions
QUIZ_QUESTIONS = ["10+2", "4/2", "3+1"]
ANSWERS = [12, 2, 4]  # Correct answers
BROADCAST_PORT = 7777
TCP_PORT = 1235
QUIZ_DURATION = 12  # In seconds

# Broadcast the quiz over UDP
def broadcast_quiz():
    udp_socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    udp_socket.setsockopt(socket.SOL_SOCKET, socket.SO_BROADCAST, 1)
    broadcast_message = ";".join(QUIZ_QUESTIONS)
    print(f"Broadcasting questions: {broadcast_message}")

    start_time = time.time()
    while time.time() - start_time < QUIZ_DURATION:
        udp_socket.sendto(broadcast_message.encode(), ('<broadcast>', BROADCAST_PORT))
        time.sleep(2)  # Broadcast every 2 seconds
    udp_socket.close()
    print("Broadcasting stopped.")

# Handle individual TCP clients
def handle_client(client_socket, client_address):
    print(f"Connected to student: {client_address}")
    score = 0

    for i in range(len(QUIZ_QUESTIONS)):
        try:
            question_index = int(client_socket.recv(1024).decode())  # Receive question index
            answer = int(client_socket.recv(1024).decode())  # Receive answer

            # Check correctness
            if question_index < len(ANSWERS) and answer == ANSWERS[question_index]:
                score += 1
        except:
            print(f"Error communicating with {client_address}")
            break

    # Send score to the student
    client_socket.sendall(str(score).encode())
    print(f"Student {client_address} scored {score}.")
    client_socket.close()

# Start the TCP server to handle student connections
def start_tcp_server():
    tcp_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    tcp_socket.bind(('0.0.0.0', TCP_PORT))
    tcp_socket.listen(5)
    print("TCP server started, waiting for students...")

    while True:
        client_socket, client_address = tcp_socket.accept()
        threading.Thread(target=handle_client, args=(client_socket, client_address)).start()

if __name__ == "__main__":
    # Start UDP broadcasting in a separate thread
    threading.Thread(target=broadcast_quiz).start()

    # Start TCP server
    start_tcp_server()

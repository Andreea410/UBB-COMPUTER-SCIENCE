# Solve the problem from the second set here
#Solution for the second problem from the second set

def verification_if_prime(n):
    n = int(n)
    if n < 2:
        return 0
    if n % 2 == 0:
        return 0
    if n == 2:
        return 1

    for d in range(3 , int(n * 0.5) , 2):
        if n % d == 0:
            return 0
    return 1

if __name__ == '__main__':

    n = input("Please enter a natural number: ")
    n = int(n)
    p1 = n + 1
    p2 = n + 3
    if p2 - p1 == 2 and verification_if_prime(p1) and verification_if_prime(p2):
        print(f"The first twin prime numbers after {n} are {p1} and {p2}")
    while verification_if_prime(p1) == 0 or verification_if_prime(p2) == 0 or p2-p1 != 2:
        p1 += 1
        p2 += 1
        while verification_if_prime(p1) == 0:
            p1 += 1
        while verification_if_prime(p2) == 0:
            p2 += 1
        if p2 - p1 == 2:
            print(f"The first twin prime numbers after {n} are {p1} and {p2}")

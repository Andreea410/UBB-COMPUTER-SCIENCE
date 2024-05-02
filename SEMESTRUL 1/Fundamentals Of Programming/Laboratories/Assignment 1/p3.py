# Solve the problem from the third set here

#The solution for the third problem from the third set
def verification_if_prime(n):
    n = int(n)
    if n <= 1:
        return False
    if n == 2:
        return True
    if n % 2 == 0:
        return False
    for d in range(3 ,int(n ** 0.5) + 1, 2):
        if n % d == 0:
            return False
    return True


if __name__ == '__main__':
    n=input("Please enter a natural number: ")
    n=int(n)

    x = 0
    while n > 0:
        x += 1
        if verification_if_prime(x) or x == 1:
            n -= 1
        else:
            for d in range (2 , x):
                if x % d == 0 and n > 0 and verification_if_prime(d):
                    count = d
                    c = d
                    while count and n:
                        count -= 1
                        n -= 1

    if verification_if_prime(x):
        print(x)
    else:
        print(c)







# Solve the problem from the first set here

# The solution for the first problem in the first set

def verification_if_prime(n):
    n = int(n)
    if n < 2:
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

    n = input("Please enter a natural number: ")
    n = int(n)

    while n < 0:
        n = input("Invalid number.Please enter a natural number: ")
        n = int(n)

    result = n+1

    while not verification_if_prime(result):
        result += 1

    print(f"The next prime number greater than {n} is {result}")

#The solution for the second problem in the first set

def verification_if_prime(n):
    n = int(n)
    if n < 2:
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

    ok=0
    n = input("Please enter a natural number: ")
    n = int(n)

    while n<0:
        n = input("Number invalid.Please enter a natural number: ")
        n = int(n)

    if verification_if_prime(n-2):
        input(f"The prime numbers that added equal {n} are {2} and {n-2}")
        ok = 1

    for p1 in range(3,int(n/2),2):
        if verification_if_prime(p1):
            if verification_if_prime(n-p1):
                ok = 1
                input(f"The prime numbers that added equal {n} are {p1} and {n-p1}")
                break

    if ok == 0:
        input(f"There aren't any prime numbers that added equal {n}")

#The solution for the third problem in first set

def smallest_number(n):
    digits = []
    n = int(n)
    c = n

    while c:
        digits.append(c % 10)
        c = int(c / 10)

    digits.sort()

    if digits[0] == 0:
        for i in range(1, len(digits)):
            if digits[i] != 0:
                digits[0] = digits[i]
                digits[i] = 0
                break
    m = digits[0]
    for i in range(1, len(digits)):
        m = m * 10 + digits[i]
    return m

if __name__ == '__main__':

    n = input("Please enter a natural number: ")

    print(f"The smallest number written with the digits from {n} is {smallest_number(n)}")

#The solution for the forth problem in first set
def largest_number(n):
    digits = []
    n = int(n)
    c = n

    while c:
        digits.append(c % 10)
        c = int(c / 10)

    digits.sort(reverse=True)

    m = digits[0]
    for i in range(1, len(digits)):
        m = m * 10 + digits[i]
    return m

if __name__ == '__main__':

    n = input("Please enter a natural number: ")

    print(f"The largest number written with the digits from {n} is {largest_number(n)}")

#The solution for the fifth problem in the first set

if __name__ == '__main__':
    n = input("Please enter a natural number: ")
    n = int(n)

    if n < 3:
        print(f"There isn`t any prime number smaller than {n}")
    else:
        result = n - 1
        while not verification_if_prime(result):
            result-=1

    print(f"The largest prime number smaller than {n} is {result}")
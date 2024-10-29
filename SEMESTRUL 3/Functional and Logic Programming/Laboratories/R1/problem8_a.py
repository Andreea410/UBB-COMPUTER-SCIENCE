#. a. Determine the lowest common multiple of the elements from a list

def gcd(a, b):
    while b:
        a, b = b, a % b
    return a

def lcm(a,b):
    return a*b // gcd(a,b)

def lowest_common_multiple(node):
    if node is None :
        return 1
    else:
        if node.urm is None:
            return node.e
    return lcm(node.e,lowest_common_multiple(node.urm))


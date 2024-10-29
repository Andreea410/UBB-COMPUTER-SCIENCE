from problem8_a import lowest_common_multiple
from problem8_b import substitute_occurences


class Nod:
    def __init__(self, e):
        self.e = e
        self.urm = None


class Lista:
    def __init__(self):
        self.prim = None


'''
crearea unei liste din valori citite pana la 0
'''


def creareLista():
    lista = Lista()
    lista.prim = creareLista_rec()
    return lista


def creareLista_rec():
    x = int(input("x="))
    if x == 0:
        return None
    else:
        nod = Nod(x)
        nod.urm = creareLista_rec()
        return nod


'''
tiparirea elementelor unei liste
'''


def tipar(lista):
    tipar_rec(lista.prim)


def tipar_rec(nod):
    if nod != None:
        print(nod.e)
        tipar_rec(nod.urm)


def main():
    while True:
        print("-----MENU-------")
        print("a. Determine the lowest common multiple of the elements from a list")
        print("b. Substitute in a list, all occurrences of a value e with a value e1.")
        print("c. Exit")
        
        option = input("Choose an option: ").strip().lower()
        
        if option == 'a':
            print("Please introduce the elements for the list. To stop adding, just type 0.")
            lst = creareLista()
            print("This is the list you created:")
            tipar(lst)
            n = lowest_common_multiple(lst.prim)
            print(f"This is the lowest common multiple: {n}")
        
        elif option == 'b':
            print("Please introduce the elements for the list. To stop adding, just type 0.")
            lst = creareLista()
            print("This is the list you created:")
            tipar(lst)
            x = int(input("Enter the value you want to substitute: "))
            y = int(input("Enter the value you want to substitute with: "))
            
            substitute_occurences(lst.prim, x, y)
            print("This is the list after substitution:")
            tipar(lst)
        
        elif option == 'c':
            print("Exiting the program.")
            print(f"You entered {option}")
            break  
        
        else:
            print("The choice you made isn't part of the menu. Please try again.")

if __name__ == "__main__":
    main()
      
    
    
    
    
    
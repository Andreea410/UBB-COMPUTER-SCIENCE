#Project
def selection_sort(list):
    c=step
    for i in range(len(list)):
        mini = i
        for j in range(i + 1, len(list)):
            if c == 0:
                print(list)
                c = step
            if list[mini] > list[j]:
                mini = j
                c -= 1
        list[i], list[mini] = list[mini], list[i]

def stooge_sort(list, low, high,step, total):
    if low >= high:
        return
    if list[low] > list[high]:
        list[low], list[high] = list[high], list[low]
        total += 1
        if total % step == 0:
            print (list)
    if high - low + 1 > 2:
        third = (high - low + 1) // 3
        stooge_sort(list, low, high - third,step,total)
        stooge_sort(list, low + third, high,step,total)
        stooge_sort(list, low, high - third,step,total)

if __name__ == '__main__':
    print("==MENU==")
    print("1.Create a random list")
    print("2.Selection sort")
    print("3.Stooge sort")
    print("4.Exit")


    option = 0
    list=[]
    while option != 4:
        option = int(input("Please choose an option from the menu: "))

        if option == 1:
            import random
            numbers = int(input("Please introduce the number of elements between 1 and 100 for the list: "))
            list =[random.randint(0, 100) for _ in range(numbers)]

        if option == 2:
            if list == []:
                print("You need to generate the list first.Please choose another option")
            else:
                step = int(input("Please choose the number of steps: "))
                c = step
                selection_sort(list)

                print(f"The list after the selection sort is {list}")

        if option == 3:
            if list == []:
                print("You need to generate the list first.Please choose another option")
            else:
                step = int(input("Please choose the number of steps: "))
                c = step
                stooge_sort(list,0,numbers,step,0)
                print(list)
        if option == 4:
            break


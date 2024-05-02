#Project

import timeit
import random
def selection_sort(list):
    for i in range(len(list)):
        mini = i
        for j in range(i + 1, len(list)):
            if list[mini] > list[j]:
                mini = j
        list[i], list[mini] = list[mini], list[i]

def stooge_sort(list, low, high):
    if low >= high:
        return
    if list[low] > list[high]:
        list[low], list[high] = list[high], list[low]
    if high - low + 1 > 2:
        third = (high - low + 1) // 3
        stooge_sort(list, low, high - third)
        stooge_sort(list, low + third, high)
        stooge_sort(list, low, high - third)


def verification_if_best_case(list):
    for i in range(len(list)):
            for j in range(i + 1, len(list)):
                if list[i] > list[j]:
                  return False
    return True

def verification_if_worst_case(list):
    for i in range(len(list)):
            for j in range(i + 1, len(list)):
                if list[i] < list[j]:
                  return False
    return True


if __name__ == '__main__':
    print("==MENU==")
    print("1.Create a random list")
    print("2.Selection sort")
    print("3.Stooge sort")
    print("4.Exit")
    print("5.Time complexity for selection sort")
    print("6.Time complexity for stooge sort")


    option = 0
    list=[]
    while option != 4:
        option = int(input("Please choose an option from the menu: "))

        if option == 1:
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
                stooge_sort(list,0,numbers-1)
                print(f"The list after the stooge sort is {list}")
        if option == 4:
            break
        if option == 5:

            n = int(input("Please choose the number of elements the first list will have: "))

            list1 = [random.randint(0, 100) for _ in range(n)]
            list2 = [random.randint(0, 100) for _ in range(2*n)]
            list3 = [random.randint(0, 100) for _ in range(4*n)]
            list4 = [random.randint(0, 100) for _ in range(8*n)]
            list5 = [random.randint(0, 100) for _ in range(16*n)]

            print("a.Best case")
            print("b.Average case")
            print("c.Worst case")

            case_selection_sort = input("Please choose the case for which the time complexity will be calculated: ")

            if case_selection_sort == 'a':
                selection_sort(list1)
                t = timeit.timeit(lambda: selection_sort(list1), setup="pass", number=1)
                print(f"list1 BC: {t}")

                selection_sort(list2)
                t = timeit.timeit(lambda: selection_sort(list2), setup="pass", number=1)
                print(f"list2 BC: {t}")

                selection_sort(list3)
                t = timeit.timeit(lambda: selection_sort(list3), setup="pass", number=1)
                print(f"list3 BC: {t}")

                selection_sort(list4)
                t = timeit.timeit(lambda: selection_sort(list4), setup="pass", number=1)
                print(f"list4 BC: {t}")

                selection_sort(list5)
                t = timeit.timeit(lambda: selection_sort(list5), setup="pass", number=1)
                print(f"list5 BC: {t}")


            if case_selection_sort == 'b':

                while verification_if_worst_case(list1):
                    random.shuffle(list1)
                while verification_if_best_case(list1):
                    random.shuffle(list1)
                t = timeit.timeit(lambda: selection_sort(list1), setup="pass", number=1)
                print(f"list1 AC: {t}")

                while verification_if_worst_case(list2):
                    random.shuffle(list2)
                while verification_if_best_case(list2):
                    random.shuffle(list2)
                t = timeit.timeit(lambda: selection_sort(list2), setup="pass", number=1)
                print(f"list2 AC : {t}")

                while verification_if_worst_case(list3):
                    random.shuffle(list3)
                while verification_if_best_case(list3):
                    random.shuffle(list3)
                t = timeit.timeit(lambda: selection_sort(list3), setup="pass", number=1)
                print(f"list3 AC: {t}")

                while verification_if_worst_case(list4):
                    random.shuffle(list4)
                while verification_if_best_case(list4):
                    random.shuffle(list4)
                t = timeit.timeit(lambda: selection_sort(list4), setup="pass", number=1)
                print(f"list4 AC: {t}")

                while verification_if_worst_case(list5):
                    random.shuffle(list5)
                while verification_if_best_case(list5):
                    random.shuffle(list5)
                t = timeit.timeit(lambda: selection_sort(list5), setup="pass", number=1)
                print(f"list5 AC: {t}")


            if case_selection_sort == 'c':
                sorted(list1 , reverse=True)
                t = timeit.timeit(lambda: selection_sort(list1), setup="pass", number=1)
                print(f"list1 AC: {t}")

                sorted(list2, reverse=True)
                t = timeit.timeit(lambda: selection_sort(list2), setup="pass", number=1)
                print(f"list2 BC: {t}")

                sorted(list3, reverse=True)
                t = timeit.timeit(lambda: selection_sort(list3), setup="pass", number=1)
                print(f"list3 BC: {t}")

                sorted(list4, reverse=True)
                t = timeit.timeit(lambda: selection_sort(list4), setup="pass", number=1)
                print(f"list4 BC: {t}")

                sorted(list5, reverse=True)
                t = timeit.timeit(lambda: selection_sort(list5), setup="pass", number=1)
                print(f"list5 BC: {t}")

        if option == 6:
                n = int(input("Please choose the number of elements the first list will have: "))

                list1 = [random.randint(0, 100) for _ in range(n)]
                list2 = [random.randint(0, 100) for _ in range(2 * n)]
                list3 = [random.randint(0, 100) for _ in range(4 * n)]
                list4 = [random.randint(0, 100) for _ in range(8 * n)]
                list5 = [random.randint(0, 100) for _ in range(16 * n)]

                print("a.Best case")
                print("b.Average case")
                print("c.Worst case")

                case_stooge_sort = input("Please choose the case for which the time complexity will be calculated: ")

                if case_stooge_sort_sort == 'a':
                    while verification_if_best_case(list1):
                        random.shuffle(list1)
                    t = timeit.timeit(lambda: stooge_sort(list1,0 ,n-1), setup="pass", number=1)
                    print(f"list1 BC: {t}")

                    while verification_if_best_case(list2):
                        random.shuffle(list2)
                    t = timeit.timeit(lambda: stooge_sort(list2, 0, 2*n - 1), setup="pass", number=1)
                    print(f"list2 BC: {t}")

                    while verification_if_best_case(list3):
                        random.shuffle(list3)
                    t = timeit.timeit(lambda: stooge_sort(list3, 0, 4*n - 1), setup="pass", number=1)
                    print(f"list3 AC: {t}")

                    while verification_if_best_case(list4):
                        random.shuffle(list4)
                    t = timeit.timeit(lambda: stooge_sort(list4, 0, 8*n - 1), setup="pass", number=1)
                    print(f"list4 AC: {t}")

                    while verification_if_best_case(list5):
                        random.shuffle(list5)
                    t = timeit.timeit(lambda: stooge_sort(list5, 0, 16*n - 1), setup="pass", number=1)
                    print(f"list5 AC: {t}")

                if case_selection_sort == 'b':

                    while verification_if_best_case(list1):
                        random.shuffle(list1)
                    t = timeit.timeit(lambda: stooge_sort(list1,0, n-1), setup="pass", number=1)
                    print(f"list1 AC: {t}")

                    while verification_if_best_case(list2):
                        random.shuffle(list2)
                    t = timeit.timeit(lambda: stooge_sort(list2,0, 2*n-1), setup="pass", number=1)
                    print(f"list2 AC : {t}")

                    while verification_if_best_case(list3):
                        random.shuffle(list3)
                    t = timeit.timeit(lambda: stooge_sort(list3,0 , 4*n - 1), setup="pass", number=1)
                    print(f"list3 AC: {t}")


                    while verification_if_best_case(list4):
                        random.shuffle(list4)
                    t = timeit.timeit(lambda: stooge_sort(list4, 0 ,8*n - 1), setup="pass", number=1)
                    print(f"list4 AC: {t}")


                    while verification_if_best_case(list5):
                        random.shuffle(list5)
                    t = timeit.timeit(lambda: stooge_sort(list5, 0 , 16*n - 1), setup="pass", number=1)
                    print(f"list5 AC: {t}")

                if case_stooge_sort_sort == 'c':
                    sorted(list1)

                    t = timeit.timeit(lambda: stooge_sort(list1,0,n-1), setup="pass", number=1)
                    print(f"list1 WC: {t}")

                    sorted(list2)
                    t = timeit.timeit(lambda: stooge_sort(list2 , 0 ,2*n-1), setup="pass", number=1)
                    print(f"list2 WC: {t}")

                    sorted(list3)
                    t = timeit.timeit(lambda: stooge_sort(list3 , 0 ,4*n-1), setup="pass", number=1)
                    print(f"list3 WC: {t}")

                    sorted(list4)
                    t = timeit.timeit(lambda: stooge_sort(list4 , 0 , 8*n-1), setup="pass", number=1)
                    print(f"list4 WC: {t}")

                    sorted(list5)
                    t = timeit.timeit(lambda: stooge_sort(list5 , 0 , 16*n-1), setup="pass", number=1)
                    print(f"list5 WC: {t}")





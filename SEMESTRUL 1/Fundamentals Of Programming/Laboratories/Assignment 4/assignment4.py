# #The solution for the fourth assignment
#     #WEEK 1-Backtracking problem

#recursive backtracking
def menu():
    print("1.Backtracking problem")
    print("2.Dynamic programming problem")
    print("3.Exit")

def menu_backtracking():
    print("1.Recursive")
    print("2.Iterative")

def menu_dynamic_programming():
    print("1.Naive version - non-optimized")
    print("2.Dynamic version - optimized")


def new_subsequences(n):
    def recursive_backtracking(subsequence):
        if len(subsequence) == 2 * n + 1 :
            if subsequence[-1] == 0 :
                solutions.append(subsequence)
            return

        for number in [ -1 , 0 , 1]:
            if abs(subsequence[-1] - number ) == 1 or abs(subsequence[-1] - number) == 2:
                new_subsequence = subsequence.copy()
                new_subsequence.append(number)
                recursive_backtracking(new_subsequence)

    solutions = []
    subsequence = [0]
    recursive_backtracking(subsequence)

    return solutions

def backtracking_recursive():

    length = int(input("Please enter the length the subquences you would like to have: "))
    solutions = new_subsequences(length)
    for subsequence in solutions:
        print(subsequence)

#iterative backtracking

def backtracking_iterative():
    n = int(input("Please enter the length the subquences you would like to have: "))
    stack = []
    stack.append([0])
    while len(stack) > 0:
        current_subsequence = stack.pop()
        if len(current_subsequence) == 2 * n + 1:
            if current_subsequence[-1] == 0:
                print(current_subsequence)
            continue

        for number in [-1 , 0 , 1]:
            if abs(current_subsequence[-1] - number) == 1 or abs(current_subsequence[-1] - number) == 2:
                new_subsequence = current_subsequence.copy()
                new_subsequence.append(number)
                stack.append(new_subsequence)

def reading_a_list_by_the_user(number_of_elements):
    list = []
    while number_of_elements in [1, 2]:
        print("The number of elements is too small for creating two subsets")
        number_of_elements = int(input("Please enter the number of elements you want the set to have:"))
    for i in range (0 ,number_of_elements):
        number = input()
        list.append(number)
    return list

def sum_list_elements(list):
    sum = 0
    for i in range(0 ,len(list)):
        sum += int(list[i])
    return sum

def finding_subset(number_of_elements ,list , target_sum):
    if target_sum == 0:
        return []
    if target_sum < 0:
        return None
    new_list=[]
    number_of_elements -= 1
    for i in reversed(list):
        remaining_sum = target_sum - int(i)
        number_of_elements -= 1
        for j in range(1 , number_of_elements):
            new_list.append(list[j])
        remaining_result = finding_subset(number_of_elements-1 , new_list, remaining_sum)
        print(remaining_result)
        if remaining_result is not None:
            remaining_result.append(i)
            print(remaining_result)
            return remaining_result

def finding_subsets_dynamic(list , target_sum , number_of_elements):
    dp = [[False] * (target_sum + 1) for _ in range(number_of_elements + 1)]
    for i in range(number_of_elements + 1):
        dp[i][0] = True
    for i in range(1, number_of_elements + 1):
        for j in range(1, target_sum + 1):
            if int(list[i - 1]) <= j:
                dp[i][j] = int(dp[i - 1][j]) or int(dp[i - 1][j]) - int(list[i - 1])

    if dp[number_of_elements][target_sum]:
        first_subset = []
        i, j = number_of_elements, target_sum
        while i > 0 and j > 0:
            if not dp[i - 1][j]:
                first_subset.append(list[i - 1])
                j -= int(list[i - 1])
            i -= 1
        return True , first_subset
    else:
        return False , None

def can_partition_equal_sum(list):
    total_sum = int(sum_list_elements(list))

    if total_sum % 2 != 0:
        return None

    target_sum = total_sum // 2
    number_of_elements = len(list)

    # Create a 2D array dp to store whether it's possible to achieve each sum from 0 to target_sum.
    dp = [[False] * (target_sum + 1) for _ in range(number_of_elements + 1)]

    # Initialize the first column with True because it's possible to achieve a sum of 0 with an empty subset.
    for i in range(number_of_elements + 1):
        dp[i][0] = True

    # Fill in the dp array using dynamic programming.
    for i in range(1, number_of_elements + 1):
        for j in range(1, target_sum + 1):
            if int(list[i - 1]) <= j:
                dp[i][j] = int(dp[i - 1][j]) or int(dp[i - 1][j - int(list[i - 1])])

    if dp[number_of_elements][target_sum]:
        # It's possible to partition the set into two equal subsets.
        subset1 = []
        i, j = number_of_elements, target_sum

        while i > 0 and j > 0:
            if not dp[i - 1][j]:
                subset1.append(list[i - 1])
                j -= int(list[i - 1])
            i -= 1

        # The remaining elements are in subset2.
        subset2 = [x for x in list if x not in subset1]

        return subset1, subset2
    else:
        return None

if __name__ == '__main__':
    option_chosen = 1
    while option_chosen:
        menu()
        option_chosen = int(input("Please choose an option from above: "))
        if option_chosen == 1:
            menu_backtracking()
            backtracking_option = int(input("Please choose an option from above: "))
            if backtracking_option == 1:
                print("You chose backtracking recursive")
                backtracking_recursive()
                continue
            elif backtracking_option == 2:
                print("You chose backtracking iterative")
                backtracking_iterative()
                continue

        if option_chosen == 3:
            exit()

        if option_chosen == 2:
            menu_dynamic_programming()
            dynamic_option = int(input("Please choose an option from above: "))

            if dynamic_option == 1:
                number_of_elements = int(input("Please enter the number of elements you want the set to have:"))
                list = reading_a_list_by_the_user(number_of_elements)
                sum = sum_list_elements(list)
                if sum % 2 != 0 or number_of_elements < 2 :
                    print(f"This list {list} can't be partioned in two sublists with equal sums ")
                else:
                    target_sum = sum // 2
                    if finding_subset(number_of_elements,list , target_sum) == None :
                        print(f"This list {list} can't be partioned in two sublists with equal sums ")
                    else:
                        first_subset = finding_subset(number_of_elements,list , target_sum)
                        second_subset = []
                        for i in list:
                            if i not in first_subset:
                                second_subset.append(i)
                        print(f"The two subsets are {first_subset} and {second_subset}")


            if dynamic_option == 2:
                number_of_elements = int(input("Please enter the number of elements you want the set to have:"))
                list = reading_a_list_by_the_user(number_of_elements)
                result = can_partition_equal_sum(list)
                if result:
                    subset1, subset2 = result
                    print(f"The two subsets are {subset1} and {subset2}")
                else:
                    print(f"This list {list} can't be partioned in two sublists with equal sums ")













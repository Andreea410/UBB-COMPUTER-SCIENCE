% 8.
% a. Write a predicate to determine if a list has even numbers of elements 
% without counting the elements from the list.
% b. Write a predicate to delete first occurrence of the minimum number from a list.

% a
check_length([], 1).
check_length([_|T], N):-
    check_length(T, N1),
    N is 1 - N1.

% b
find_min([X], X).
find_min([H|T], H):-
    find_min(T, M),
    H < M.
find_min([H|T], M):-
    find_min(T, M),
    H >= M.

delete_first_occ([], _, []).
delete_first_occ([E|T], E, T).
delete_first_occ([H|T], E, [H|R]):-
    delete_first_occ(T, E, R).

delete_first_min(L, R):-
    find_min(L, M),
    delete_first_occ(L, M, R).

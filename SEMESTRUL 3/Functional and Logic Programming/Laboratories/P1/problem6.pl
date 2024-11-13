%6.
%a. Write a predicate to test if a list is a set.
%b. Write a predicate to remove the first three occurrences of an element in a list. If the element occurs less 
%than three times, all occurrences will be removed.

%a
member(_,[],0).
member(E,[E|_],1).
member(E,[H|T],R):-
    E=\=H,
    member(E,T,R).

is_set([],1).
is_set([H|T],0):-
    member(H,T,1),
    !.
is_set([H|T],R):-
    member(H,T,0),
    is_set(T,R).
    
%b

remove_occ([],_,_,[]).
remove_occ([E|T],E,0,[E|R]):-
    remove_occ(T,E,0,R).
remove_occ([H|T],E,K,[H|R]):-
    H=\=E,
    !,
    remove_occ(T,E,K,R).
remove_occ([E|T],E,K,R):-
    K1 is K-1,
    remove_occ(T,E,K1,R).

remove_occurences(L,E,R):-
    remove_occ(L,E,3,R).


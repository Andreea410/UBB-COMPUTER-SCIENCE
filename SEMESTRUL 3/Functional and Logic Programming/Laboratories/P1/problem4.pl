%4.
%a. Write a predicate to determine the difference of two sets.
%b. Write a predicate to add value 1 after every even element from a list.

%a
%difference_sets(S1-set one , S2-set two , R-resulted set)
%flow model(i,i,o)

difference_sets([],_,[]).
difference_sets([H1|T1],S2,[H1|R]):-
    \+ member(H1,S2),
    !,
    difference_sets(T1,S2,R).
difference_sets([H1|T1],S2,R):-
    difference_sets(T1,S2,R).

%b
%addValue(L-List,1-value to be added,R-resulted list)
%flow model(i,i,o)

addValue([],_,[]).
addValue([H|T],1,[H,1|R]):-
    H mod 2 =:= 0,
    !,
    addValue(T,1,R).
addValue([H|T],1,[H|R]):-
    addValue(T,1,R).

addValueMain(L,R):-
    addValue(L,1,R).

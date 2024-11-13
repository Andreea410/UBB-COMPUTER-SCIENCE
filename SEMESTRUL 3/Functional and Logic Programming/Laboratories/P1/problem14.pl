%14.
%a. Write a predicate to test equality of two sets without using the set difference.
%b. Write a predicate to select the n-th element of a given list.

test_eq([],[],1).
test_eq([X],[X],1).
test_eq([],_,0).
test_eq(_,[],0).
test_eq([H1|_],[H2|T2],0):-
    \+member(H1,[H2|T2]),
    !.
test_eq([H1|T1],[H2|T2],0):-
    member(H1,[H2|T2]),
    \+member(H2,[H1|T1]),
    !.
test_eq([H1|T1],[H2|T2],R):-
    member(H1,[H2|T2]),
    member(H2,[H1|T1]),
    !,
    test_eq(T1,T2,R).

%b
give_element([],_,_,0).
give_element([X],N,N,X).
give_element([H|_],N,N,H).
give_element([_|T],N,C,R):-
    N=\=C,
    C1 is C+1,
    give_element(T,N,C1,R).

    

give_element_main(L,N,R):-
    give_element(L,N,1,R).

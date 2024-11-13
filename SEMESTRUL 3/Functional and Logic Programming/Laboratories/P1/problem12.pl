%12. 
%a. Write a predicate to substitute in a list a value with all the elements of another list.
%b. Remove the n-th element of a list.

%a
substitute([],_,_,_,[]).
substitute([_|T],E,[],C,R):-
    !,
    substitute(T,E,C,C,R).
substitute([E|T],E,[H2|T2],C,[H2|R]):-
    !,
    substitute([E|T],E,T2,C,R).
substitute([H|T],E,[H2|T2],C,[H|R]):-
    substitute(T,E,[H2|T2],C,R).

main_s(L,E,L2,R):-
    substitute(L,E,L2,L2,R).

%b
remove_el([],_,_,[]).
remove_el([_|T],C,C,T).
remove_el([H|T],K,C,[H|T]):-
    C>K.
remove_el([H|T],K,C,[H|R]):-
    K=\=C,
    C1 is C+1,
    remove_el(T,K,C1,R).
remove_el_main(L,N,R):-
    remove_el(L,N,1,R).
    

    
    

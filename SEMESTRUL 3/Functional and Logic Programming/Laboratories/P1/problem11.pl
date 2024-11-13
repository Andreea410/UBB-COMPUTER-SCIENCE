%11.
%a. Write a predicate to substitute an element from a list with another element 
%in the list.
%b. Write a predicate to create the sublist (lm, …, ln) from the list (l1,…, lk).

%a
substitute([],_,_,[]).
substitute([E1|T],E1,E2,[E2|R]):-
    !,
    substitute(T,E1,E2,R).
substitute([H|T],E1,E2,[H|R]):-
    substitute(T,E1,E2,R).

%b
create_list([],_,_,_,[]).
create_list(_,_,N,K,[]):-
    K>N.
create_list([_|T],M,N,K,R):-
    K<M,
    !,
    K1 is K+1,
    create_list(T,M,N,K1,R).
create_list([H|T],M,N,K,[H|R]):-
    K>=M,
    !,
    K1 is K+1,
    create_list(T,M,N,K1,R).
 
create(L,M,N,R):-
    create_list(L,M,N,1,R).
    

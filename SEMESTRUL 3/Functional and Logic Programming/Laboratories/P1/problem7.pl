%7.
%a. Write a predicate to compute the intersection of two sets.
%b. Write a predicate to create a list (m, ..., n) 
%of all integer numbers from the interval [m, n].


%a
member(_,[],0).
member(E,[E],1).
member(E,[E|_],1).
member(E,[H|T],R):-
    H=\=E,
    member(E,T,R).

union_sets([],[],[]).
union_sets(L1,[],L1).
union_sets([],L2,L2).
union_sets([H|T],L2,[H|R]):-
    member(H,L2,0),
	union_sets(T,L2,R).    
union_sets([H|T],L2,R):-
    member(H,L2,1),
	union_sets(T,L2,R).

%b
create_list(M,M,[M]).
create_list(M,N,[M|R]):-
    M1 is M+1,
    create_list(M1,N,R).
    

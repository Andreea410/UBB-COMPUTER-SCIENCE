%5.
%a. Write a predicate to compute the union of two sets.
%b. Write a predicate to determine the set of all the pairs of elements in a list. 
%Eg.: L = [a b c d] => [[a b] [a c] [a d] [b c] [b d] [c d]].

verifyIfElementExists([],_,0).
verifyIfElementExists([X],X,1).
verifyIfElementExists([E|_],E,1).
verifyIfElementExists([H|T],E,R):-
    H=\=E,
    verifyIfElementExists(T,E,R).


compute_union([],[],[]).
compute_union([],L2,R):-
    compute_union(L2,[],R).
compute_union([H|T],L2,[H|R]):-
    verifyIfElementExists(L2,H,0),
    verifyIfElementExists(T,H,0),
    compute_union(T,L2,R).
compute_union([H|T],L2,R):-
    verifyIfElementExists(L2,H,1),
    compute_union(T,L2,R).
compute_union([H|T],L2,R):-
    verifyIfElementExists(L2,H,0),
    verifyIfElementExists(T,H,1),
    compute_union(T,L2,R).

verify_pair_exists(_,[],0).
verify_pair_exists([H1,H2] , [H1,H2|_],1).
verify_pair_exists([H1,H2] , [H2,H1|_],1).
verify_pair_exists([H1,H2] , [_|T],R):-
    verify_pair_exists([H1,H2],T,R).
    

set_pairs([],[]).
set_pairs([H|T],R):-
    set_pairs(T,R1),
    set_pairs_aux(H,T,R2),
    append(R1,R2,R).
    
    
set_pairs_aux(_,[],[]).
set_pairs_aux(E,[H|T],R):-
    set_pairs_aux(E,T,R1),
    verify_pair_exists([E,H],R1,1),
    R is R1.
set_pairs_aux(E,[H|T],R):-
    set_pairs_aux(E,T,R1),
    verify_pair_exists([E,H],R1,0),
    R = [[E,H]|R1].

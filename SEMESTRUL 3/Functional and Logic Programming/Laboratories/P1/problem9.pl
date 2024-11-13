%9.
%a. Insert an element on the position n in a list.
%b. Define a predicate to determine the greatest common divisor
% of all numbers from a list

%a
insert_element([],1,X,[X]).
insert_element(L,0,_,L).
insert_element(L,1,X,[X|L]).
insert_element([H|T],K,X,[H|R]):-
    K>1,
    K1 is K-1,
    insert_element(T,K1,X,R).

%b
gcd(X,X,X).
gcd(E1,E2,R):-
    E2>E1,
    !,
    gcd(E2,E1,R).
gcd(E1,E2,R):-
    E3 is E1-E2,
    gcd(E2,E3,R).

determine_gcd([X],X).
determine_gcd([H1,H2|T],R):-
    gcd(H1,H2,R1),
    determine_gcd([R1|T],R).

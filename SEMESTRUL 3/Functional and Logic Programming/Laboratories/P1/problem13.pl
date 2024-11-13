%13.
%a. Transform a list in a set, in the order of the last occurrences of elements. 
%Eg.: [1,2,3,1,2] is transformed in [3,1,2].
%b. Define a predicate to determine the greatest common divisor of all numbers in a list..

transform([],[]).
transform([H|T],[H|R]):-
    \+ member(H,T),
    transform(T,R).
transform([H|T],R):-
    member(H,T),
    transform(T,R).

%b
gcd(E,E,E).
gcd(E1,E2,R):-
    E1 < E2,
    gcd(E2,E1,R).
gcd(E1,E2,R):-
    E3 is E1-E2,
    gcd(E2,E3,R).

gcd_list([X],X).
gcd_list([H1,H2|T],R):-
    gcd(H1,H2,RES),
    gcd_list([RES|T],R).

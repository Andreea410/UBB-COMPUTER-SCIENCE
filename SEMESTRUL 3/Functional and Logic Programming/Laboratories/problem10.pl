%10.
%a. Define a predicate to test if a list of an integer elements has a "valley" aspect 
%(a set has a "valley" aspect if 
%elements decreases up to a certain point, and then increases. 
%eg: 10 8 6 9 11 13 – has a “valley” aspect
%b. Calculate the alternate sum of list’s elements (l1 - l2 + l3 ...).

%a
is_valley([_]):-
    fail.

is_valley([H1,H2|T]):-
    H1>H2,
    decreasing([H2|T]).

decreasing([H1,H2|T]):-
    H1 > H2,
    !,
    decreasing([H2|T]).
decreasing([H1,H2|T]):-
    H1 < H2,
    !,
    increasing([H2|T]).

increasing([_]).
increasing([H1,H2|T]):-
    H1 < H2,
    !,
    increasing([H2|T]).

%b
alternate([],_,0).
alternate([X],_,X).
alternate([H1,H2|T],0,R):-
    E is H1+H2,
    alternate([E|T],1,R).
alternate([H1,H2|T],1,R):-
    E is H1-H2,
    alternate([E|T],0,R).
alternate_sum(L,R):-
    alternate(L,1,R).

%Remove sublists from a heterogeneous list
%process(L-list , R-list)
% flow model

process([],[]).
process([H|T],R):-
    is_list(H), 
    process(T,R).
process([H|T] , [H|R]):-
    \+ is_list(H), % or atomic(H)
    process(T,R).


%same thing as before
process([],[]).
process([H|T],R):-
    is_list(H),!, 
    process(T,R).
process([H|T] , [H|R]):-
    process(T,R).

suma([],0).
suma([H|T] , S):-
    suma(T,TS),
    S is TS+H.

%modify(L-list,R-list)
%flow model(i , o)

modify([],[]).
modify([H|T],R):-
    is_list(H),
    suma(H,S1),
    S1 mod 2 =:= 1,!,
    H=[H1|_],
    modify(T,R).
  
modify([H|T], R):-
    is_list(H),
    suma(H,S1),
    S1 mod 2 =\= 1,
    modify(T,R).

modify([H|T],[H|R]):-
	modify(T,R).



% remOdd(L-list,R-list)
%flow model(i,o)

remOdd([],[]).
remOdd([H|T] , R):-
    H mod 2 =:= 1,!,
    remOdd(T,R).
remOdd([H|T], [H|R]):-
    remOdd(T,R).

%mountain(L-list , F-flag)
%flow model(i,i)

mounatin([_] , 1)
mountain([H1,H2|T],0):-
    H1<H2,
    mountain([H2|T],0).
mountain([J1,H2|T],_):-
    H1>H2,
    mountain([H2|T],1).

mainM([H1,H2|T]):-
    H1 < H2,
    mountain([H1,H2|T],0).


process(L-lits , R-list)
%flow model(i,o)

process([],[]).
process([H|T] , R):-
    is_list(H),
    mainM(H),
    remOdd(H,NH),
    process(T,TR),
    R=[NH|TR].

%3.
%a. Define a predicate to remove from a list all repetitive elements. 
%Eg.: l=[1,2,1,4,1,3,4] => l=[2,3])
%b. Remove all occurrence of a maximum value from a list on integer numbers.

%auxiliary function
%nrrOcc(L-list , E-lement, R-nr occurences)
%flow model(i,i,o)

nrOcc([],_,0).
nrOcc([H|T],E,R):-
    H=:=E,
    nrOcc(T,E,R1),
    R is R1+1.
nrOcc([H|T],E,R):-
    H=\=E,
    nrOcc(T,E,R).


%auxiliary function
removeOcc([],_,[]).
removeOcc([H|T],E,R):-
    H=:=E,
    removeOcc(T,E,R).

removeOcc([H|T],E,[H|R]):-
    H=\=E,
    removeOcc(T,E,R).


%a
%removeRepetitive(L-list , R-resulted list)
%flow model(i,o)

removeRepetitive([],[]).
removeRepetitive([H|T],R):-
    nrOcc([H|T],H,N),
    N > 1,
    removeOcc([H|T],H,NEWLIST),
    removeRepetitive(NEWLIST,R).
removeRepetitive([H|T],[H|R]):-
    nrOcc([H|T],H,N),
    N < 2,
    removeRepetitive(T,R).
    

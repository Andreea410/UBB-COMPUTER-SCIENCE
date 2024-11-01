%2.
%a. Write a predicate to remove all occurrences of a certain atom from a list.
%b. Define a predicate to produce a list of pairs (atom n) from an initial list of atoms. In this initial list atom has 
%n occurrences.
%Eg.: numberatom([1, 2, 1, 2, 1, 3, 1], X) => X = [[1, 4], [2, 2], [3, 1]].

%a
%removeAtom(L-list , A-atom , R-resulted list)
%flow model(i,i,o)

removeAtom([],_,[]).
removeAtom([H|T],A,[H|R]):-
    H\=A,
    removeAtom(T,A,R).

removeAtom([A|T],A,R):-
    removeAtom(T,A,R).
    

%extra function
%nrOcc(L-list , E-element,R-result)
%flow model(i,i,o)

nrOcc([],_,0).
nrOcc([H|T],E,R):-
    H=:=E,
    nrOcc(T,E,R1),
    R is R1+1.

nrOcc([H|T],E,R):-
    H=\=E,
    nrOcc(T,E,R).

%b
%produceLists(L-list,R-resulted list)
%flow model(i,o)

produceLists([],[]).
produceLists([H|T],[[H,N]|R]):-
    nrOcc(T,H,N1),
    N is N1+1,
    removeAtom(T,H,NEWLIST),
    produceLists(NEWLIST,R).
    

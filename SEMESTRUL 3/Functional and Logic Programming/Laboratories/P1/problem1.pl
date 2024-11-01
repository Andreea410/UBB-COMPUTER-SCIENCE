%1.
%a. Write a predicate to determine the lowest common multiple of a list formed from integer numbers.
%b. Write a predicate to add a value v after 1-st, 2-nd, 4-th, 8-th, … element in a list.

%greatest_common_divisor(H1-number,H2-number,R-result)
%flow model(i,i,o)

greatest_common_divisor(X,X,X).
greatest_common_divisor(H1,H2,R):-
    H1 < H2,
    greatest_common_divisor(H2,H1,R).
greatest_common_divisor(H1,H2,R):-
    H is H1-H2,
    greatest_common_divisor(H2,H,R).

%a
%lowest_common_multiple(L-list , R-result)
%flow_model(i,o)

lowest_common_multiple([],-1).
lowest_common_multiple([X],X).
lowest_common_multiple([H1,H2|T],R):-
    greatest_common_divisor(H1,H2,E),
    E1 is H1*H2 div E,
    lowest_common_multiple([E1|T],R).

%b
%addElement(L-list,E-element,I-currentIndex,P-position to place,R-resultedList)
%flow model(i,i,i,i,o)

addElement([],_,_,_,[]).
addElement([H|T],E,I,P,[H,E|R]):-
    I=:=P,
    P1 is P*2,
    I1 is I+1,
    addElement(T,E,I1,P1,R).
addElement([H|T],E,I,P,[H|R]):-
    I=\=P,
    I1 is I+1,
    addElement(T,E,I1,P,R).

addElementMain(L,E,R):-
    addElement(L,E,1,1,R).
    

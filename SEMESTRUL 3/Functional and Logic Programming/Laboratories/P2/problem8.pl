%8. 
%a. Determine the successor of a number represented as digits in a list. 
%Eg.: [1 9 3 5 9 9] --> [1 9 3 6 0 0]
%b. For a heterogeneous list, formed from integer numbers and list of numbers,
% determine the successor of a sublist considered as a number.
%[1, [2, 3], 4, 5, [6, 7, 9], 10, 11, [1, 2, 0], 6] => 
%[1, [2, 4], 4, 5, [6, 8, 0], 10, 11, [1, 2, 1], 6]

%a
%invert_list(L-list , R-resulted list)
%flow_model(i,o)

invert_list([],[]).
invert_list([X],[X]).
invert_list([H|T],R):-
    invert_list(T,R1),
    append(R1,[H],R).

%get_succesor(L-list , I-if carry,R-resulted list)
%flow model(i,o)
% get_successor(L - list of digits, Carry - initial carry, R - result list)
% flow model: (i, i, o)

get_successor([], 0, []).          
get_successor([], 1, [1]).          
get_successor([H|T], Carry, [H1|R]) :-
    Sum is H + Carry,                
    H1 is Sum mod 10,                
    NewCarry is Sum // 10,           
    get_successor(T, NewCarry, R).   
    

%determine_succesor(L-list,R-resulted list)
%flow model(i,o)

determine_successor([],[]).
determine_successor(L,R):-
    invert_list(L,LIST_INV),
    get_successor(LIST_INV,1,ADDED_LIST),
    invert_list(ADDED_LIST,R).

%b
%determine_succesor_sublist(L-list , R-resulted list)
% flow model(i,o)

determine_successor_sublist([],[]).
determine_successor_sublist([H|T],[R1|R]):-
    is_list(H),
    !,
    determine_successor(H,R1),
    determine_successor_sublist(T,R).
determine_successor_sublist([H|T],[H|R]):-
    determine_successor_sublist(T,R).
    





    

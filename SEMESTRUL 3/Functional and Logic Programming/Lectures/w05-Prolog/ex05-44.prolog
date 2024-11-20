% Write a non-deterministic predicate that deletes an element, in turn, from all the positions on which it appears in a list. 
 
% (i, o, i) - non-deterministic

% ?- elimin(1, L, [1, 2, 1, 3]).
% L = [2, 1, 3]
% L = [1, 2, 3]

% elimin(E: element, LRez: list, L: list)
% (i, o, i) - non-deterministic

elimin(E, L, [E | L]).
elimin(E, [A | L], [A | X]) :-
	elimin(E, L, X).

% ?- elimin(E, L, [1, 2, 3]).

% ?- elimin(1, [2, 3], L).

% ?- elimin(E, [1, 3], [1, 2, 3]).

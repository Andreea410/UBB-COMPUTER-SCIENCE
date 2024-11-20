% Write a non-deterministic predicate that inserts an element, in all positions, in a list.

% flow model(i, i, o) - non-deterministic

% ?- insert(1, [2, 3], L).

L = [1, 2, 3]
L = [2, 1, 3]
L = [2, 3, 1]

% insert(E: element, L: List, Res: list)
% (i, i, o) – non-deterministic


insert(E, L, [E | L]).
insert(E, [H | T], [H | Res]) :-
	insert(E, T, Res).

% ?- insert(E, L, [1, 2, 3]).

% ?- insert(1, L, [1, 2, 3]).

% ?- insert(E, [1, 3], [1, 2, 3]).

% Write a predicate that concatenates two lists

% concat(L1: list, L2: list, L3: list)
% (i, i, o) - deterministic

concat([], L, L).

concat([H | L1], L2, [H | L3]) :-
  concat(L1, L2, L3).


% flow model (o, o, i) – non-deterministic

?- concat(L1, L2, [1, 2, 3]).

L1 = []
L2 = [1, 2, 3]
L1 = [1]
L2 = [2, 3]

% flow model (o, i, i) or (i, o, i) - deterministic

?- concat(L, [3, 4], [1, 2, 3, 4]).

L = [1, 2]

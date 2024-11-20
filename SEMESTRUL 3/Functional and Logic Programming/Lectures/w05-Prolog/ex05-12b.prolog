% A numeric list is given. Provide a solution to avoid repeated recursive calls.

% f(L: list of numbers, E: number)
% (i, o) - deterministic

% Solution. An auxiliary predicate is used. 

f([E], E).

f([H | T], Y) :- 
  f(T, X), 
  aux(H, X, Y).

% aux(H: integer, X: integer, Y: integer)
% (i, i, o) - deterministic

aux(H, X, H) :-
  H =< X,
  !.
aux(_, X, X).

% Provide a solution to avoid repeated recursive calls.

% f(K: number, X: number)
% (i, o) - deterministic

% Solution. An auxiliary predicate is used. 

f(1,1) :- !.

f(2,2) :- !.

f(K, X) :- 
  K1 is K-1,
  f(K1, Y),
  aux(K, Y, X).

% aux(K: integer, Y: integer, X: integer)
% (i, i, o) - deterministic

aux(K, Y, X) :-
  Y > 1,
  !,
  X is K-2.

aux(_, Y, Y).


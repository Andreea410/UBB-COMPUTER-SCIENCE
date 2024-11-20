% Given a numeric list, write a solution to avoid repeated recursive calls.

% minim(L: list of integer, M: integer)
% (i, o) - deterministic

% Solution 2. An auxiliary predicate is used. This solution does not involve understanding semantics.

minim([A], A).

minim([H | T], Res) :-
  minim(T, M), 
  aux(H, M, Rez).

% aux(H: integer, M: integer, Rez: integer)
% (i, i, o) - deterministic

aux(H, M, H) :-
  H =< M,
  !.
aux(_, M, M).

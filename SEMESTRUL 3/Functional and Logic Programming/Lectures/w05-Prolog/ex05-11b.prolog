% Given a numeric list, write a solution to avoid repeated recursive calls.

% minim(L: list of integer, M: integer)
% (i, o) - deterministic

% Solution 1 - Essentially switch the two clauses

minim([A], A).

minim([H|T], M) :-
  minim(T, M), 
  H > M,
  !.
minim([H|_], H).

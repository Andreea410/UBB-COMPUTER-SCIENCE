% Given a numeric list, write a solution to avoid repeated recursive calls.

% minim(L: list of integer, M: integer)
% (i, o) - deterministic

minim([A], A).

minim([H|T], H) :-
  minim(T, M), 
  H =< M, 
  !.
minim([_|T], M) :-
  minim(T, M).

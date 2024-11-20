% A numeric list is given. Provide a solution to avoid repeated recursive calls.

% f(L: list of numbers, E: number)
% (i, o) - deterministic

f([E], E).

f([H | T], H) :-
  f(T, X), 
  H =< X,
  !.
f([_ | T], X) :- 
  f(T, X).


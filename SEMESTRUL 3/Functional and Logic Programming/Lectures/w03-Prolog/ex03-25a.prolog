% Return the list of even items in a list (preserve the order of the items in the original list)

% Version A (direct recursion)

% even(L: list, LRez: list)
% (i, o) – deterministic

even([],[]).

even([H|T],[H|Rez]):-
  H mod 2 =:= 0,
  !,
  even(T,Rez).

even([_|T],Rez):-
  even(T,Rez).

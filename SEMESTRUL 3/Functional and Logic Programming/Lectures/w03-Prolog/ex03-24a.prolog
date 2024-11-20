% Return the inverse of a list

% Version A (direct recursion)

% inverse(L: list, LRez: list)
% (i, o) – deterministic

add(E,[],[E]).

add(E,[H|T],[H|Rez]):-
  add(E,T,Rez).

invers([],[]).

invers([H|T],Rez) :-
  invers(T,L), 
  add(H,L,Rez).
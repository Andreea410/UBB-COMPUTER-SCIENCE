% What is the effect of the following queries? 
% Does false occur at the end of the search?
%
% ?- g([1, 3, 4], 2, P).
% ?- f([1,2,3,4], P).

% Do the predicates work with other flow models?
% 
% ?- g([1,2,3], E, [4,1]).

% g(L:list, E: element, LRez: list)
% (i, i, o) – non-deterministicic

g([H|_], E, [E,H]).
g([_|T], E, P):-
  g(T, E, P).

% f(L:list, LRez: list)
% (i, o) – non-deterministicic

f([H|T],P):-
  g(T, H, P).
f([_|T], P):-
  f(T, P).

% Returns the list of positions of the given element in the given list.

% ?- det([1,2,1,3,1,7,8], 1, L).
% L = [1,3,5]

% det( L:list of elements, E:element, LRez: list of numbers)
% (i, i, o) - deterministic

det(L, E, LRez) :-
  det_aux(L, E, LRez, 1).

% det_aux( L:list of elements, E:element, LRez: list of numbers, P:intreg)
% (i, i, o, i) - deterministic

det_aux([], _, [], _).

det_aux([E|T], E, [P|LRez], P) :-
  !,
  P1 is P+1,
  det_aux(T, E, LRez, P1).

det_aux([_|T], E, LRez, P) :-
  P1 is P+1,
  det_aux(T, E, LRez, P1).

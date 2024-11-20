% Solution to avoid the repeated call to det_aux...

% ?- det([1,2,1,3,1,7,8], 1, L).
% L = [1,3,5]

% det( L:list of elements, E:element, LRez: list of numbers)
%(i, i, o) - deterministic

det(L, E, LRez) :-
  det_aux(L, E, LRez, 1).

% det_aux( L:list of elements, E:element, LRez: list of numbers, P:intreg)
% (i, i, o, i) - deterministic

det_aux([], _, [], _).

det_aux([H|T], E, LRez, P) :-
  P1 is P+1,
  det_aux(T, E, L, P1),
  det_second(H, E, P, L, LRez).

% det_second(H: element, E:element, P: number, L:list, LRez: list of numbers)
% (i, i, i , i, o) - deterministic

det_second(E, E, P, L, [P| L]) :-
  !.
det_second(_, _, _, L, L).

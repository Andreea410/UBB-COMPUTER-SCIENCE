% Given a numerical list, return the list of strictly ascending pairs of elements in the list.

% ?- pairs ([2, 1, 3, 4], L)
% L = [[2, 3], [2, 4], [1, 3], [1, 4], [3, 4]]
%
% ?- pairs ([5, 4, 2], L)
% false

% pair(E: element, L: list, LRez: list)
% (i, i, o) – non-deterministic

pair(A,[B|_],[A,B]):-
  A<B.

pair(A,[_|T],P):-
  pair(A,T,P).

% pairs(L: list, LRez: list)
% (i, o) – non-deterministic

pairs([H|T],P):-
  pair(H,T,P).

pairs([_|T],P):-
  pairs(T,P).

% allPairs(L: list, LRez: list)
% (i, o) –deterministic

allPairs(L,LRes):-
  findall(X,pairs(L,X),LRez).

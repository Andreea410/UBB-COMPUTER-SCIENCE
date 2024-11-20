% Write a predicate that returns the list of subsets of a list represented as a set

% ?- subsets([1, 2], L)
% L = [[], [2], [1], [1, 2]]

% subm(L: list, S: list)
% (i, o) – non-deterministic

subm([], []).

subm([_ | T], S) :-
  subm(T, S).

subm([H | T], [H | S]) :-
  subm(T, S).

% subsets1(L: list, S: list of lists)
% (i, o) - deterministic

subsets1(L, Ld) :-
  findall(X, subm(L, X), Ld).

% Version 2 - without findall, results in a different order

% addhead(L1: list, L2: list of lists, L3: list of lists)
% (i, i, o) - deterministic

addhead(E, [], []).

addhead(E, [H | T], [[E|H] | ET]) :-
  addhead(E, T, ET).

% concat(L1: list, L2: list, L3: list)
% (i, i, o) - deterministic

concat([], L, L).

concat([H | L1], L2, [H | L3]) :-
  concat(L1, L2, L3).

% subsets2(L: list, S: list of lists)
% (i, o) - deterministic

subsets2([], [[]]).

subsets2([H | T], L) :-
  subsets2(T, LT),
  addhead(H, LT, LH),
  concatenate(LH, LT, L).

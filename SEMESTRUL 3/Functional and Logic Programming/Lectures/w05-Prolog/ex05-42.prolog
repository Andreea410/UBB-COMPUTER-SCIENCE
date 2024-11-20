% Write a non-deterministic predicate that generates combinations with k elements of a nonempty set represented as a list.
 
% (i, i, o) - non-deterministic

% ?- comb([1, 2, 3], 2, C).

C = [2, 3]
C = [1, 2]
C = [1, 3]

% comb(L: list, K: integer, C: list)
% (i, i, o) - non-deterministic

comb([H | _], 1, [H]).

comb([_ | T], K, C) :-
  comb(T, K, C).

comb([H | T], K, [H | C]) :-
  K > 1,
  K1 is K-1,
  comb(T, K1, C).

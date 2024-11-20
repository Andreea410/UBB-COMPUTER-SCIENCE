% Write a non-deterministicis predicate that generates combinations with k > 1
% elements of a non-empty set whose elements are non-zero natural numbers, so that the sum of
% the elements in the combination is a given value S.

combSum([H|_], 1, H, [H]).

combSum([_|T], K, S, C) :-
  combSum(T, K, S, C).

combSum([H|T], K, S, [H|C]) :-
  K > 1,
  S1 is S-H,
  S1 > 0,
  K1 is K-1,
  combSum(T, K1, S1, C).

% ?- combSum([3, 2, 7, 5, 1, 6], 3, 9, C). 
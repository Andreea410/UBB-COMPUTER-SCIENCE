% Write a non-deterministicis predicate that generates combinations with k > 1
% elements of a non-empty set whose elements are non-zero natural numbers, so that the sum of
% the elements in the combination is a given value S.

comb([H|_], 1, [H]).
comb([_|T], K, C) :-
  comb(T, K, C).
comb([H|T], K, [H|C]) :-
  K > 1,
  K1 is K-1,
  comb(T, K1, C).

sum([], 0).
sum([H|T], S) :-
  sum(T, S1),
  S is H + S1.

combSum(L, K, S, C) :-
	comb(L, K, C),
	sum(C, S).

% ?- combSum([3, 2, 7, 5, 1, 6], 3, 9, C). 

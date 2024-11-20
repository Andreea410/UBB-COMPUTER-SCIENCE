% Write a non-deterministicis predicate that generates combinations with k > 1
% elements of a non-empty set whose elements are non-zero natural numbers, so that the sum of
% the elements in the combination is a given value S.

candidate(E, [E|_]).
candidate(E, [_|T]) :-
  candidate(E, T).

% (i,i,i,i,i,o)
constraints(K, S, LenRes, SumRes, HRes, E) :-
  LenRes < K,
  E < HRes,
  NewSum is SumRes+E,
  NewSum =< S.

combAux(_, K, S, C, K, S, C) :- !.

combAux(L, K, S, C, LenRes, SumRes, []):-
  candidate(E, L),
  constraints(K, S, LenRes, SumRes, 999, E),
  NewLen is LenRes+1,
  NewSum is SumRes+E,
  combAux(L, K, S, C, NewLen, NewSum, [E]).

combAux(L, K, S, C, LenRes, SumRes, [HRes|TRes]):-
  candidate(E, L),
  constraints(K, S, LenRes, SumRes, HRes, E),
  NewLen is LenRes+1,
  NewSum is SumRes+E,
  combAux(L, K, S, C, NewLen, NewSum, [E,HRes|TRes]).

% C is a combination of K elements of sum S from given list L
combSum(L, K, S, C) :-
  combAux(L, K, S, C, 0, 0, []).

% ?- combSum([3, 2, 7, 5, 1, 6], 3, 9, C). 
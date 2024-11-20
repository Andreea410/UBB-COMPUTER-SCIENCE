% Given a set of numbers (represented as a list), write two predicates to return all the subsets of an even / odd sum.

% sEven(L: list of numbers, L: list of numbers)
% (i, o) – non-deterministic

sEven([], []).

sEven([_ | T], S) :-
  sEven(T, S).

sEven([H | T], [H | S]) :-
  H mod 2 =:= 0,
  !,
  sEven(T, S).

sEven([H | T], [H | S]) :-
  sOdd(T, S).

% sOdd(L: list of numbers, L: list of numbers)
% (i, o) – non-deterministic

sOdd([H], [H]) :-
  H mod 2 =\= 0,
  !.

sOdd([_ | T], S) :-
  sOdd(T, S).

sOdd([H | T], [H | S]) :-
  H mod 2 =:= 0,
  !,
  sOdd(T, S).

sOdd([H | T], [H | S]) :-
  sEven(T, S).


% ?- sEven([1, 2, 3], S).
% 
% []
% [2]
% [1, 3]
% [1, 2, 3]

% ?- sOdd([1, 2, 3], S).
% 
% [3]
% [2, 3]
% [1]
% [1, 2]
% false

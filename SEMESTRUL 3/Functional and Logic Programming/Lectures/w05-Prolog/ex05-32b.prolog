% Tail recursion modulo cons transformed, tail recursion removed

% (i,i,o,o) deterministic

partition([], _, [], []) :- !.

partition(L, Pivot, Smalls, Bigs) :-
  L = [X|Xs],
  X < Pivot, 
  !,
  partition(Xs, Pivot, Rest, Bigs),
  Smalls = [X|Rest].

partition(L, Pivot, Smalls, Bigs) :-
  L = [X|Xs],
  partition(Xs, Pivot, Smalls, Rest),
  Bigs = [X|Rest].

% ?- partition([1,10,2,9,3,8,4,7,5,6],5,S,B).

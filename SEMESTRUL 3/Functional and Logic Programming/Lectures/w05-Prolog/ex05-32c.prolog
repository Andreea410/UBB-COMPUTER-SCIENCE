% Tail recursion modulo cons transformed to standard

% (i,i,o,o) deterministic

partition([], _, [], []) :- !.

partition(L, Pivot, Smalls, Bigs) :-
  L = [X|Xs],
  X < Pivot, 
  !,
  Smalls = [X|Rest],
  partition(Xs, Pivot, Rest, Bigs).

partition(L, Pivot, Smalls, Bigs) :-
  L = [X|Xs],
  Bigs = [X|Rest],
  partition(Xs, Pivot, Smalls, Rest).

% ?- partition([1,10,2,9,3,8,4,7,5,6],5,S,B).

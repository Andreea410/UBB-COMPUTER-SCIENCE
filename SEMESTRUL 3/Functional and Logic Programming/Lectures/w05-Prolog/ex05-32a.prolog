% Tail recursion modulo cons

% (i,i,o,o) deterministic

partition([], _, [], []).

partition([X|Xs], Pivot, [X|Rest], Bigs) :-
  X < Pivot, 
  !,
  partition(Xs, Pivot, Rest, Bigs).

partition([X|Xs], Pivot, Smalls, [X|Rest]) :-
  partition(Xs, Pivot, Smalls, Rest).

% ?- partition([1,10,2,9,3,8,4,7,6],5,S,B).
  
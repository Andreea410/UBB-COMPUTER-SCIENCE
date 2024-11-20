additiontable(A) :-
  member(B, A),
  member(C, A),
  D is B+C,
  assert(sum(B, C, D)),
  fail.

% ?- sum(X,Y,Z).
% ?- additiontable([0, 1, 2, 3, 4]).
% ?- sum(X,Y,Z).
% ?- retract(sum(_, _, _)), fail.
% ?- sum(X,Y,Z).

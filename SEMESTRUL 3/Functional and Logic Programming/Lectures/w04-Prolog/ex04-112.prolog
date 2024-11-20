% Version 1

% p(L: list, S: integer)
% (i, o) deterministic

p1([], 0).
p1([H | T], S) :-
  H > 0,
  !,
  p1(T, S1),
  S is S1 + H.
p1([_ | T], S) :- p1(T, S).

% ?- p1([1, 2, 3, 4], S).
% S = 10.
%
% ?- p1([1, -1, 2, -2], S).
% S = 3.

% Version 2

p2([], 0).
p2([H | T], S) :-
  !,
  H > 0,
  p2(T, S1),
  S is S1 + H.
p2([_ | T], S) :- p2(T, S).

% ?- p2([1, 2, 3, 4], S).
% S = 10.
%
% ?- p2([1, -1, 2, -2], S).
% false

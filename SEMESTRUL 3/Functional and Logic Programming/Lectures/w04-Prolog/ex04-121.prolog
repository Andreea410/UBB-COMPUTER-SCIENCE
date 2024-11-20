predicate(a, b).
predicate(c, d).
predicate(e, f).

all :-
  predicate(X, Y),
  write(X), write(Y), nl,
  fail.

all1 :-
  predicate(X, Y),
  write(X), write(Y), nl.
  
% ?- all.
%
% ?- all1.
%
% ?- predicates(X, Y).


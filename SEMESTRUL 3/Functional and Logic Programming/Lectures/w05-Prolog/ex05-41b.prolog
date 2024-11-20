% flow model (o,o)

f(0,1).

f(X,Y) :- 
  f(X1,Y1), 
  X is X1+1, 
  Y is Y1*(X1+1).

% wrapper 

% (i,i), (o,i)
f2(X,Y) :-
  nonvar(Y),
  f(X1,Y1),
  Y1 >= Y,
  !,
  Y1 = Y,
  X1 = X.

% (i,o)
f2(X,Y) :- 
  nonvar(X),
  var(Y),
  f(X,Y),
  !.

% (o,o)
f2(X,Y) :-
  var(X),
  var(Y),
  f(X,Y).

% flow model (o,o)

f(0,1).

f(X,Y) :- 
  f(X1,Y1), 
  X is X1+1, 
  Y is Y1*(X1+1).

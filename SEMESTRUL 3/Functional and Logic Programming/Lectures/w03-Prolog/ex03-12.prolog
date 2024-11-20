% The predicate findall

p(a,b).
p(b,c).
p(a,c).
p(a,d).

all(X,L) :- 
  findall(Y,p(X,Y),L).

% ?- all(a,L).
% L = [b,c,d]

% The predicate findall
% Generates all numbers from N1 to N2

% g(N1, N2, R)
% flow(i,i,o)

g(N1, N2, N1) :-
  N1 =< N2.
  
g(N1, N2, R) :-
  N1 =< N2,
  N11 is N1 + 1,
  g(N11, N2, R).
  
all(N1, N2, L) :- 
  findall(R, g(N1, N2, R), L).

% ?- all(1, 5, L).
% L = [1,2,3,4,5]

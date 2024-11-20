% Provide a solution to avoid repeated recursive calls.

% f(K: number, X: number)
% (i, o) - deterministic

f(1,1) :- !.

f(2,2) :- !.

f(K, X) :- 
  K1 is K-1,
	f(K1, Y),
	Y > 1,
	!,
	X is K-2.
f(K, X) :- 
  K1 is K-1,
	f(K1, X).

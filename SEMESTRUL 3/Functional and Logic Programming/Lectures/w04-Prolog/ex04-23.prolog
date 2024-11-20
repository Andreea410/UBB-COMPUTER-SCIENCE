% A list of integers and / or symbols is given. 
% Determine the sum of even integers in the list.

% ?- sum([i(1), s(a), i(2)], S).
% S = 2.
%
% ?- sum([s(a), s(b), i(1)], S).
% S = 0.

% sum(L: heterogeneous list, S: number)
% (i, o) - deterministic

sum([], 0).

sum([i(H) | T], S) :-
  H mod 2 =:= 0,
  !,
  sum(T, S1),
  S is S1 + H.

% sum([s(H) | T], S) :- 
%  sum(T, S).

sum([_ | T], S) :- 
  sum(T, S).

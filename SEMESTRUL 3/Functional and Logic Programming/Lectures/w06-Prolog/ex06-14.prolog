% Consider a set of non-null natural numbers represented as a list. Determine
% all the possibilities to write a number N as a sum of elements from this list.

candidate([E|_],E).
candidate([_|T],E) :-
  candidate(T,E).

solution(L, N, Rez) :-
  candidate(L, E),
  E =< N,
  solution_aux(L, N, Rez, [E], E).

% param 4 collects the solution
% param 5 is sum of all elements in the collector
solution_aux(_, N, Rez, Rez, N) :- !.
solution_aux(L, N, Rez, [H | Col], S) :-
  candidate(L, E),
  E < H,
  S1 is S+E,
  S1 =< N,
  solution_aux(L, N, Rez, [E, H | Col], S1).

% ?- solution([1,2,3,4,5,6],6,V).
% fact(N,F)
% flow (o,i)
%
%  F   N
% --------
% 24 1 N
% 24 2 N
% 12 3 N
%  4 4 N

fact(N,F) :- 
  fact_aux(N,F,1).

fact_aux(F,F,F) :- !.

fact_aux(N,F,M) :-
  F1 is F div M,
  F mod M =:= 0,
  M1 is M+1,
  fact_aux(N,F1,M1).
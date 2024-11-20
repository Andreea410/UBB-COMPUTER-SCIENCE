% Tail recursive version of factorial

% fact(N: integer, F: integer)
% (i, i), (i, o) - deterministic

fact(N,F) :- 
  fact_aux(N,F,1,1).

% fact_aux(N: integer, F: integer, I: integer, P: integer)
% (i, i, i, i), (i, o, i, i) - deterministic

fact_aux(N,F,N,F) :- !.

fact_aux(N,F,I,P) :- 
  NewI is I + 1,
  NewP is P * NewI,
  fact_aux(N,F,NewI,NewP).
  
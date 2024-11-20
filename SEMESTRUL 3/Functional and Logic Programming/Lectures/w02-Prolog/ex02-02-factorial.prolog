%% trace.
%% notrace.

%% Predicate fact1 fails (correctly) when N<0. Why?

fact1(0,1).

fact1(N,F) :- 
  N>0,
  N1 is N-1,
  fact1(N1,F1),
  F is N*F1.

%% Predicate fact2 enters indefinite recursion (wrongly) when N<0. Why?

fact2(0,1) :- 
  !.

fact2(N,F) :- 
  N1 is N-1,
  fact2(N1,F1),
  F is N*F1.

%% What is the difference between fact3 and fact1?

fact3(N,F) :- 
  N>0,
  N1 is N-1,
  fact3(N1,F1),
  F is N*F1.

fact3(0,1).

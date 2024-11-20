%% trace.
%% notrace.

defeat(henry7,richard3).

oldestson(henry8,henry7).

king(richard3).

king(Y) :- 
  oldestson(Y,X),
  king(X).

king(Y) :-
  defeat(Y,X),
  king(X).

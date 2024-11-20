% Tail recursion

tip0(N) :-
  write(N),
  nl,
  N1 is N + 1,
  tip0(N1).

% Wrong example 1

tip1(N) :-
  write(N),
  nl,
  N1 is N + 1,
  tip1(N1),
  nl.

% Wrong example 2

tip2(N) :-
  write(N),
  nl,
  N1 is N + 1,
  tip2(N1).

tip2(N) :-
  N < 0,
  write('N is negative.').

% Wrong example 2 corrected

tip2c(N) :-
  N>= 0,
  !,
  write(N),
  nl,
  N1 is N + 1,
  tip2c(N1).

tip2c(N) :-
  N < 0,
  write("N is negative.").

% Wrong example 3

tip3(N) :-
  write(N),
  nl,
  N1 is N + 1,
  verif(N1),
  tip3(N1).

verif(Z) :- 
  Z >= 0.

verif(Z) :- 
  Z < 0.

% Wrong example 3 corrected

tip3c(N) :-
  write(N),
  nl,
  N1 is N + 1,
  verif(N1),
  !,
  tip3c(N1).


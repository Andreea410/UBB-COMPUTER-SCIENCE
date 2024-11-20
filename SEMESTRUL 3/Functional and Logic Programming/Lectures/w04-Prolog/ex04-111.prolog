% p(E: integer)
% (o) – non-deterministic

p(1).
p(2).

% q(E: integer)
% (o) – non-deterministic

q(3).
q(4).

% r(E1: integer, E2: integer)
% (o, o) – non-deterministic

% version V1
r1(X, Y) :-!, p(X), q(Y).

% version V2
r2(X, Y) :- p(X),!, q(Y).

% version V3
r3(X, Y) :- p(X), q(Y), !.

% What solutions are retured with this goal?
%
% ?- r1(X, Y).
% ?- r2(X, Y).
% ?- r3(X, Y).

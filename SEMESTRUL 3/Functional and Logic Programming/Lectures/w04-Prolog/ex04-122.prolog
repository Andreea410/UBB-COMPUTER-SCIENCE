
% q(E: integer)
% (o) – non-deterministic

q(1).
q(2).
q(3).
q(4).

% Version 1

p1 :- q(I), I<3, write(I), nl, fail.

% Version 2

p2 :- q(I), I<3, write(I), nl.

% ?- p1.
%
% ?- p2.

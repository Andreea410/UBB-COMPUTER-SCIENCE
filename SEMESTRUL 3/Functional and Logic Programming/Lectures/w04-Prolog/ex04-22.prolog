% A more general possibility to manage heterogeneous lists is using composed
% objects / functors.

% ?- sum([n(1), s(a), l([1,2,3]), n(4)], S).
% S = 11.
%
% ?- sum([s(a), s(b), l([])], S).
% S = 0.

% sumlist(L: list of numbers, S: number)
% (i, o) - deterministic

sumlist([], 0).

sumlist([H | T], S) :-
  sumlist(T, S1),
  S is S1 + H.

% sum(L: list, S: number)
% (i, o) - deterministic

sum([], 0).

sum([n(H) | T], S) :-
  !,
  sum(T, S1),
  S is H + S1.

sum([l(H) | T], S) :-
  !,
  sumlist(H, S1),
  sum(T, S2),
  S is S1 + S2.

sum([_ | T], S) :-
  sum(T, S).
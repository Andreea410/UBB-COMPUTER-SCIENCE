% Verify the membership of an item in a list

% Version 1

% member(e: element, L: list)
% (i, i) - (non) deterministic
% (o, i) – non-deterministic

member1(E,[E|_]).
member1(E,[_|L]) :-
  member1(E,L).

% ?- member1(1,[1,2,1,3,1,4]).

% ?- member1(X,[1,2,1,3,1,4]).

% Version 2

% member(e: element, L: list)
% (i, i) - deterministic,
% (o, i) – deterministic

member2(E,[E|_]) :- !.
member2(E,[_|L]) :-
  member2(E,L).

% ?- member2(1,[1,2,1,3,1,4]).

% ?- member2(X,[1,2,1,3,1,4]).

% Version 3

% member(e: element, L: list)
% (i, i) - (non) deterministic
% (o, i) - non-deterministic

member3(E,[_|L]) :- 
  member3(E,L).
member3(E,[E|_]).

% ?- member3(X, [1,2,3]).

% ?- member3(4, [1,2,3]).

% ?- member3(2, [1,2,3]).

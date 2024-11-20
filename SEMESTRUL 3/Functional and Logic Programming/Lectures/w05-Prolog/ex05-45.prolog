% Write a non-deterministic predicate that generates the permutations of a list.
 
% (i, o,) - non-deterministic
% ?- perm([1, 2, 3], P).

P = [1, 2, 3]
P = [1, 3, 2]
P = [2, 1, 3]
P = [2, 3, 1]
P = [3, 1, 2]
P = [3, 2, 1]

% perm(L: list, LRez: list)
% (i, o) – non-deterministic

perm([], []).

perm([E | T], P) :-
	perm(T, L),
	insert(E, L, P). % (i,i,o)

% alternate clause
perm(L, [H | T]) :-
	elimin(H, Z, L), % (o,o,i)
	perm(Z, T).

% alternate clause
perm(L, [H | T]) :-
	insert(H, Z, L), % (o,o,i)
	perm(Z, T).

% alternate clause
perm([E | T], P) :-
	perm(T, L),
  elimin(E, L, P), % (i, i, o)

% needed predicates

insert(E, L, [E | L]).
insert(E, [H | L], [H | Res]) :-
	insert(E, L, Res).

elimin(E, L, [E | L]).
elimin(E, [H | L], [H | Res]) :-
	elimin(E, L, Rez).

% Return the inverse of a list

% Version B (with collector variable)

% inverse(L: list, LRez: list)
% (i, o) – deterministic

% invers_aux(Col: list, L: list, LRez: list) - the first argument is the collector
% (i, i, o) - deterministic

invers(L,Rez) :-
  invers_aux([],L,Rez).

invers_aux(Col,[],Col).
invers_aux(Col,[H|T],Rez):-
  invers_aux([H|Col],T,Rez).

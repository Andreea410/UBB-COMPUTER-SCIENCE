% Add an item at the end of a list

% Version 1
%
% add(e: element, L: list, LRez: list)
% (i, i, o) – deterministic

add1(E,[],[E]).

add1(E,[H|T],[H|Rez]):-
  add1(E,T,Rez).

% add1(E,[H|T],Rez):-
%   add1(E,T,L),Rez=[H|L].

% Version 2
%
% add(L: list, e: element, LRez: list)
% (i, i, o) – deterministic

add2([],E,[E]).

add2([H|T],E,[H|Rez]):-
  add2(T,E,Rez).

% add2([H|T],E,Rez):-
%   add2(T,E,L),Rez=[H|L].

% N-Queens

queen(N, Rez) :- 
  candidate(E, N),
  queen_aux(N, Rez, [[N, E]], N),
  printSolution(N, Rez).

candidate(N, N).
candidate(E, I) :- 
  I > 1, 
  I1 is I-1, 
  candidate(E, I1).

queen_aux(_, Rez, Rez, 1) :- !.
queen_aux(N, Rez, C, Lin) :-
	candidate(Col1, N),
	Lin1 is Lin-1,
	valid(Lin1, Col1, C),
  queen_aux(N, Rez, [[Lin1, Col1] | C], Lin1).

valid(_, _, []).
valid(Lin, Col, [[Lin1, Col1] | T]) :-
	Col =\= Col1,
	DLin is Col-Col1,
	DCol is Lin-Lin1,
	abs(DLin) =\= abs(DCol),
	valid(Lin, Col, T).

printSolution(_, []) :- nl.
printSolution(N, [[_, Col] | T]) :- 
    printLine(N, Col), 
    printSolution(N, T).

character(1, '*') :- !.
character(_,'-').

printLine(0, _) :- nl, !.
printLine(N, Col) :- 
character(Col, C),
	write(C),
	N1 is N-1,
	Col1 is Col-1,
	printLine(N1, Col1).

sum([], Acc, Acc).

sum([nil|Rest], Acc, Res) :-
  sum(Rest, Acc, Res).

sum([tree(V,L,R)|Rest], Acc, Res) :-
	NewAcc is Acc + V,
  sum([L,R|Rest], NewAcc, Res).

sum(Tree, Res) :-
  sum([Tree], 0, Res).

tree1(tree(1, tree(2, tree(3, nil, nil), nil), tree(4, nil, tree(5, nil, nil)))).

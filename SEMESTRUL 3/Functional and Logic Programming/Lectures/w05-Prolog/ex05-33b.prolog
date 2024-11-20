flatten([], Acc, Acc).

flatten([nil|Rest], Acc, Res) :-
  flatten(Rest, Acc, Res).

flatten([tree(V,L,R)|Rest], Acc, Res) :-
  flatten([L,R|Rest], [tree(V,L,R)|Acc], Res).

flatten(Tree, Res) :-
  flatten([Tree], [], Res).

sum([], Res, Res).

sum([tree(V,_,_)|Rest], Acc, Res) :-
  NewAcc is Acc+V,
  sum(Rest, NewAcc, Res).

sum(Tree, Res) :-
  flatten(Tree, Flat),
  sum(Flat, 0, Res).

tree1(tree(1, tree(2, tree(3, nil, nil), nil), tree(4, nil, tree(5, nil, nil)))).

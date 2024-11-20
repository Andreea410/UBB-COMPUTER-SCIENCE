sum(nil,0).

sum(tree(V,L,R),S) :- 
  sum(L,S1),
  sum(R,S2),
  S is V + S1 + S2.

tree1(tree(1, tree(2, tree(3, nil, nil), nil), tree(4, nil, tree(5, nil, nil)))).

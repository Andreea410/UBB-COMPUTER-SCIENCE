% Display the items of a numeric list in ascending order. Use tree sorting (using a binary search tree - BST).

% corresponding BST domain - domain with alternatives
% arbore = arb(integer, arbore, arbore); nil

% insert(integer, tree, tree) 
% (i, i, o) deterministic
% inserts an element into a BST

insert(E, nil, arb(E, nil, nil)).

insert(E, arb(Root, Left, Right), arb(Root, LeftNew, Right)) :- 
  E =< Root,
  !,
  insert(E, Left, LeftNew).

insert(E, arb(Root, Left, Right), arb(Root, Left, RightNew)) :- 
  insert(E, Right, RightNew).

% inorder(tree) 
% (i) deterministic
% displays the nodes of the tree in order

inorder(nil).

inorder(arb(Root, Left, Right)) :- 
  inorder(Left), 
  write(Root), nl, 
  inorder(Right).
 
% create(tree, list) 
% (i, o) deterministic
% creates a BST with the items in a list 

create([], nil).

create([H | T], Tree) :- 
  create(T, Tree1), 
  insert(H, Tree1, Tree).

% sorting(list) 
% (i) deterministic
% displays list items in ascending order (using tree sorting) 

sorting(L) :- 
	create(L, Tree), 
  inorder(Tree).

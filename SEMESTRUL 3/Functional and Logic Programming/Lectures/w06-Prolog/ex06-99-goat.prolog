/* File: Puzzles/goat.pro
   Title: The goat problem
A farmer has to cross a river with a wolf, a goat and a cabbage.
He has a boat, but in the boat he can take just one thing.
He cannot let the goat alone with the wolf or the goat with the cabbage. 
It’s obvious why. What is the solution?
We describe the problem as Nodes in a graph and the solution means to find a path from
the initial node to the final node.
  state(s) = node is graph 
  s(farmer(Bank),goat(Bank),cabbage(Bank),wolf(Bank)).
  Bank can be East (e) or West (w).  
*/

start:- 
  initial(S),
  path(S,[],Sol),
  reverse(Sol,Res),
  prettyprint(Res).

%% at the beginning All are on the same bank
initial(s(farmer(e),goat(e),cabbage(e),wolf(e))).

%% at the end they have all to be on the other bank
final(s(farmer(w),goat(w),cabbage(w),wolf(w))).

path(Node,Path,[Node|Path]) :- 
  final(Node).

path(Node,Path,Sol) :- 
  move(Node,N1), 
  not(bad(N1)),
  not(member(N1,Path)),                    
  path(N1,[Node|Path],Sol).

%% opposite bank East is opposite to west Bank. opp/2   
opp(e,w).
opp(w,e).

/* 
A bad state (s) is a state to be avoided. In this case:
Goat cannot be left alone with wolf or cabbage
The bank where the farmer is (T) has to be opposite
Where the goat is together with the wolf or the cabbage
T, G, C, W are variables for the banks (e or w)
*/
bad(s(farmer(T),goat(G),cabbage(C),wolf(W))):- 
 (G=W, opp(T,G)); (G=C, opp(T,G)).

%% Farmer takes goat 
move(s(farmer(T),goat(T),cabbage(C),wolf(W)),
     s(farmer(T1),goat(T1),cabbage(C),wolf(W))) :- 
  opp(T,T1). 

%% Farmer takes cabbage 
move(s(farmer(T),goat(G),cabbage(T),wolf(W)),
     s(farmer(T1),goat(G),cabbage(T1),wolf(W))) :-
  opp(T,T1). 

%% Farmer takes wolf 
move(s(farmer(T),goat(G),cabbage(C),wolf(T)),
     s(farmer(T1),goat(G),cabbage(C),wolf(T1))) :-
  opp(T,T1). 

%%  Farmer goes alone 
move(s(farmer(T),goat(G),cabbage(C),wolf(W)),
     s(farmer(T1),goat(G),cabbage(C),wolf(W))) :- 
  opp(T,T1). 

prettyprint(L) :- 
  forall(member(X,L),(write(X),nl)).

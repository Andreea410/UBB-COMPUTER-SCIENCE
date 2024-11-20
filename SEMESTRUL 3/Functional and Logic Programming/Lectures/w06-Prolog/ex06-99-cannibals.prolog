/*File: Puzzles/canibmm.pl Author: (sol) MM
Title: Missionaries and cannibals
On a river bank there are 3 cannibals and 3 missionaries. 
Here is a boat with 2 places for crossing the river. 
If on a bank there remain more cannibals than missionaries
then it is dangerous, since the cannibals may eat them.
How could they all cross the river without being in danger?
Representation:
  Banks are labeled East(e) and West(w). 
  A state (node) is:
  [Boats_Place,#Miss_east,#Cann_east,#Miss_west,#Cann_west]                  
or short:
[e,Me,Ce,Mw,Cw] - the boat is on the bank labeled e 
   on the e bank there are Me missionaries and Ce cannibals
   on the w bank there are Mw missionaries and Cw cannibals
[w,2,0,1,3] - means: the boat is on the bank w
   on bank e: Me=2 Ce=0
   on bank w: Mw=1 ( 1  missionary) Cw=3 (3 cannibals)
              (this is a BAD state).
  ?- start.
  Boat Me Ce Mw Cw
  [e, 3, 3, 0, 0]
  [w, 2, 2, 1, 1]
  [e, 3, 2, 0, 1]
  [w, 3, 0, 0, 3]
  [e, 3, 1, 0, 2]
  [w, 1, 1, 2, 2]
  [e, 2, 2, 1, 1]
  [w, 0, 2, 3, 1]
  [e, 0, 3, 3, 0]
  [w, 0, 1, 3, 2]
  [e, 0, 2, 3, 1]
  [w, 0, 0, 3, 3]
****************************************************************/

%% declare the initial state (node) and final state(node)
initial([e,3,3,0,0]).
final([w,0,0,3,3]).

/* 
  Explain the states (nodes) prohibited by my problem,
  Bad nodes should be avoided when you search for the path.
*/
bad([_,M1,C1,M2,C2]):- (M1 > 0,M1 < C1);(M2 > 0,M2 < C2).

/*
  The problem is reduced to the pattern:
  find a path in a directed graph.
  The following predicates are almost the same as in graph theory.
  We added the condition (not(bad(State) ).
*/
start:- initial(S),path(S,[],Sol),reverse(Sol,Res),my_write(Res).

path(Node,Path,[Node|Path]) :- 
  final(Node).

path(Node,Path,Sol):- 
  move(Node,N1), 
  not(bad(N1)),
  not(member(N1,Path)), 
  path(N1,[Node|Path],Sol).

/*
  The art of solving the problem is to describe the arcs(edges).
  After you decided the representation for the states.
*/

/*
  Find a possible configuration for the boat.
  Take from one bank the configuration, 
  add the configuration to the other bank  
*/
move([e, Me1, Ce1, Mw1, Cw1], [w, Me2, Ce2, Mw2, Cw2]):-
  boat(M,C), %% how many Missionaries and Cannibals are in the boat
  Me1 >= M,Ce1 >= C, %% check if it is a good proposal
  Me2 is Me1 - M,   %% take them from one shore
  Ce2 is Ce1 - C,
  Mw2 is Mw1 + M,   %% put them on another shore
  Cw2 is Cw1 + C.

move([w, Me1, Ce1, Mw1, Cw1], [e, Me2, Ce2, Mw2, Cw2]):-
  boat(M,C), 
  Mw1 >= M,Cw1 >= C,
  Me2 is Me1 + M,
  Ce2 is Ce1 + C,
  Mw2 is Mw1 - M,
  Cw2 is Cw1 - C.  

/* 
  boat/2 is a generator. M and C are the numbers of missionaries and cannibals 
  which can sit in the boat. Their total number must be <= 2.
  ?- boat(M,C).
  M=0     C=1
  M=1     C=0 ...
*/
boat(M,C) :- 
  member([M,C],[[0,1],[1,0],[1,1],[2,0],[0,2]]).

/* Write each element of a list on a separate line */
my_write(L):- 
  write('Boat Me Ce Mw Cw'),nl,
  forall(member(X,L),(write(X),nl)).  
  
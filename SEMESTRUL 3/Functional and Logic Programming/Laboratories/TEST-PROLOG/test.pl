%putem folosi is_list , atom , number
%5p explicatii , 3p test ,2p mathematical model

%Definiti un predicat ce returneaza o lista continand 
%numai numele prime dintr-o alta lista de numere intregi data.
%EX:[2,6,7,3,4,10] -> [2,7,3]

is_prim(0,_,0):-
    !.
is_prim(1,_,1):-
    !.
is_prim(E,E,1):-
    !.
is_prim(E,I,0):-
    E mod I =:=0,
    !.
is_prim(E,I,R):-
    E mod I =\=0,
    !,
    I1 is I+1,
    is_prim(E,I1,R).

%mathematical_model
%is_prim(element,index) = 1 if element =1
%						  0 if element = 0
%						  1 if element = index
%						  0 if element%in
%						  is_prim(element,index+1) otherwise

%is prim function return 0 for the element 0 , 1 for 1 , these are the best cases.
%another base case is when the index we use for checking is equal to the number
%we want to check.That means that we reached the end of checking and we can return 1,
%meaning we didn t find any divisor=>the number is prim
%If we find any divisor=> return 0
		
get_primes([],[]).
get_primes([H|T],[H|R]):-
    is_prim(H,2,1),
    !,
    get_primes(T,R).
get_primes([H|T],R):-
    is_prim(H,2,0),
    !,
    get_primes(T,R).

%mathematical model
%get_primes(l1l2...ln) = [] , if n = 0
%					   l1 U get_primes(l2l3...ln) if is_prim(l1,1)
%						get_primes(l2l3...ln) otherwise 
%get_primes(l1l2...ln) return an empty list if the 
%list received doesn't have any elements in it
%get_primes(l1l2...ln) reunites the element l1 , if it is prim,
%with the result of the recursive call get_primes(l2...ln).
%in this case we check if the current element is prime and 
%if it is we add it to the list we return and check the other elements,
%until the list is empty
%We have also the case in which we don't add the element to the list(it isn't prim),
%so we continue to check the next elements 

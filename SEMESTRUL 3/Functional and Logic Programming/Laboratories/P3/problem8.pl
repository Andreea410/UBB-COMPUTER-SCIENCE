%8. Generate all strings of n parentheses correctly closed.
%Eg: n=4 => (()) and () ()


generate_parantheses(0,0,[]):-
    !.
generate_parantheses(LEFT,RIGHT,['('|R]):-
    LEFT > 0,
    LEFT1 is LEFT-1,
    generate_parantheses(LEFT1,RIGHT,R).
generate_parantheses(LEFT,RIGHT,[')'|R]):-
	RIGHT > LEFT,
    RIGHT1 is RIGHT-1,
    generate_parantheses(LEFT,RIGHT1,R).
    
                  


generate_main(N,R):-
    N1 is N div 2,
    findall(X,generate_parantheses(N1,N1,X),Lists),
    maplist(atomics_to_string, Lists, R).

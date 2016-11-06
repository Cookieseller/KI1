solve(State,Solution) :-
	f_function(State,0,F), search([node(State,0,F,[])],S), reverse(S,Solution).

% Funktion für F wert
f_function(State,D,F) :- manhattanDistance(State, H), F is D + H. %F overall wert D ist depth h ist heuristic value

goal([[1,2,3], [4,5,6], [7,8,0]]).

%Break wenn aktueller node state == goal state
search([node(State,_,_,Sol)|_], Sol) :- goal(State).
search([B|Tail],S) :- expand(B,Children), insert_all(Children,Tail,Open), search(Open,S).

expand(node(State,D,_,Ancestors),All_My_Children) :-
	bagof(node(Child,D1,F,[Move|Ancestors]), (D1 is D+1, move(State,Child,Move), f_function(Child,D1,F)), All_My_Children).

insert_all([F|R],Open1,Open3) :- insert(F,Open1,Open2), insert_all(R,Open2,Open3).
insert_all([],Open,Open).

insert(B,Open,Open) :- repeat_node(B,Open), ! .
insert(B,[C|R],[B,C|R]) :- cheaper(B,C), ! .
insert(B,[B1|R],[B1|S]) :- insert(B,R,S), !.
insert(B,[],[B]).

%%% the heuristic function
h_function(Puzz,H) :- manhattanDistance(Puzz,H).

repeat_node(node(P,_,_,_), [node(P,_,_,_)|_]).

cheaper(node(_,_,F1,_), node(_,_,F2,_)) :- F1 < F2.

left([[A,0,C], [D,E,F], [G,H,I]], [[0,A,C], [D,E,F], [G,H,I]]).
left([[A,B,0], [D,E,F], [G,H,I]], [[A,0,B], [D,E,F], [G,H,I]]).
left([[A,B,C], [D,0,F], [G,H,I]], [[A,B,C], [0,D,F], [G,H,I]]).
left([[A,B,C], [D,E,0], [G,H,I]], [[A,B,C], [D,0,E], [G,H,I]]).
left([[A,B,C], [D,E,F], [G,0,I]], [[A,B,C], [D,E,F], [0,G,I]]).
left([[A,B,C], [D,E,F], [G,H,0]], [[A,B,C], [D,E,F], [G,0,H]]).

right([[0,A,C], [D,E,F], [G,H,I]], [[A,0,C], [D,E,F], [G,H,I]]).
right([[A,0,C], [D,E,F], [G,H,I]], [[A,C,0], [D,E,F], [G,H,I]]).
right([[A,B,C], [0,E,F], [G,H,I]], [[A,B,C], [E,0,F], [G,H,I]]).
right([[A,B,C], [D,0,F], [G,H,I]], [[A,B,C], [D,F,0], [G,H,I]]).
right([[A,B,C], [D,E,F], [0,H,I]], [[A,B,C], [D,E,F], [H,0,I]]).
right([[A,B,C], [D,E,F], [G,0,I]], [[A,B,C], [D,E,F], [G,I,0]]).

down([[0,B,C], [D,E,F], [G,H,I]], [[D,B,C], [0,E,F], [G,H,I]]).
down([[A,0,C], [D,E,F], [G,H,I]], [[A,E,C], [D,0,F], [G,H,I]]).
down([[A,B,0], [D,E,F], [G,H,I]], [[A,B,F], [D,E,0], [G,H,I]]).
down([[A,B,C], [0,E,F], [G,H,I]], [[A,B,C], [G,E,F], [0,H,I]]).
down([[A,B,C], [D,0,F], [G,H,I]], [[A,B,C], [D,H,F], [G,0,I]]).
down([[A,B,C], [D,E,0], [G,H,I]], [[A,B,C], [D,E,I], [G,H,0]]).

up([[A,B,C], [0,E,F], [G,H,I]], [[0,B,C], [A,E,F], [G,H,I]]).
up([[A,B,C], [D,0,F], [G,H,I]], [[A,0,C], [D,B,F], [G,H,I]]).
up([[A,B,C], [D,E,0], [G,H,I]], [[A,B,0], [D,E,C], [G,H,I]]).
up([[A,B,C], [D,E,F], [0,H,I]], [[A,B,C], [0,E,F], [D,H,I]]).
up([[A,B,C], [D,E,F], [G,0,I]], [[A,B,C], [D,0,F], [G,E,I]]).
up([[A,B,C], [D,E,F], [G,H,0]], [[A,B,C], [D,E,0], [G,H,F]]).

%%% the move
move(P,C,left) :-  left(P,C).
move(P,C,up) :-  up(P,C).
move(P,C,right) :-  right(P,C).
move(P,C,down) :-  down(P,C).

manhattanDistance([[A,B,C],[D,E,F],[G,H,I]], P) :-
	distA(A, Da), distB(B, Db), distC(C, Dc),
	distD(D, Dd), distE(E, De), distF(F, Df),
	distG(G, Dg), distH(H, Dh), distI(I, Di),
	P is Da + Db + Dc + Dd + De + Df + Dg + Dh + Di.
	
distA(0,0). distA(1,0). distA(2,1). distA(3,2). distA(4,1). distA(5,2). distA(6,3). distA(7,2). distA(8,3). %1
distB(0,0). distB(1,1). distB(2,0). distB(3,1). distB(4,2). distB(5,1). distB(6,2). distB(7,3). distB(8,2). %2
distC(0,0). distC(1,2). distC(2,1). distC(3,0). distC(4,3). distC(5,2). distC(6,1). distC(7,4). distC(8,3). %3
distD(0,0). distD(1,1). distD(2,2). distD(3,3). distD(4,0). distD(5,1). distD(6,2). distD(7,1). distD(8,2). %4
distE(0,0). distE(1,2). distE(2,1). distE(3,2). distE(4,1). distE(5,0). distE(6,1). distE(7,2). distE(8,1). %5
distF(0,0). distF(1,3). distF(2,2). distF(3,1). distF(4,2). distF(5,1). distF(6,0). distF(7,3). distF(8,2). %6
distG(0,0). distG(1,2). distG(2,3). distG(3,4). distG(4,1). distG(5,2). distG(6,3). distG(7,0). distG(8,1). %7
distH(0,0). distH(1,3). distH(2,2). distH(3,3). distH(4,2). distH(5,1). distH(6,2). distH(7,1). distH(8,0). %8
distI(0,0). distI(1,4). distI(2,3). distI(3,2). distI(4,3). distI(5,2). distI(6,1). distI(7,2). distI(8,1). %9

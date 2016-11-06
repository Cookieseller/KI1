do():- bfs([w,w,w,e,m,m,m], [[m,m,m,e,w,w,w]], []).

next([H,e|T], S):- H == m, S = [e,H|T].
next([H,F,e|T], S):- H == m, S = [e,F,H|T].
next([e,H|T], S):- H == w, S = [H,e|T].
next([e,F,H|T], S):- H == w, S = [H,F,e|T].
next([H|T], X):- next(T, S), X = [H|S].

bfs(Goals, [Goals|_], _).
bfs(Goals, [X|RestFrontier], Explored):- member(X, RestFrontier), !, bfs(Goals, RestFrontier, Explored).
bfs(Goals, [X|RestFrontier], Explored) :- write(X), next(X, L), append(RestFrontier, [L], Frontier), bfs(Goals, Frontier, [X|Explored]).

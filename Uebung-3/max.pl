max([X], X).
max([H|T], H) :- max(T, Y), H >= Y.
max([H|T], N) :- max(T, N), N > H.
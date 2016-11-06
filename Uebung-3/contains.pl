contains([X|_], X).
contains([_|T], X) :- contains(T, X).
ordered([_]).
ordered([H|[R|T]]) :- H =< R, ordered([R|T]).

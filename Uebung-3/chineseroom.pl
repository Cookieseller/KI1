sprich(L, []) :- not(member(du, L)), not(member(dich, L)), not(member(dir, L)), !.
sprich(L, [kein,kommentar]) :- length(L, X), even(X), !.
sprich(L, [zufaellige, beleidigung, hier, einfuegen]) :- length(L, X), 
not(even(X)), !.
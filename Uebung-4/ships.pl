% ships (source, destination, time, ware, color)
ships(S):-
	length(S, 5),
	member(s(greece, _, six, coffee, _), S),
	member(s(england, _, nine, _, _), S),
	leftOf(s(france, _, _, _, blue), s(_, _, _, coffee, _), S),
	rightOf(s(_, marseille, _, _, _), s(_, _, _, kakao, _), S),
	member(s(brasilia, manila, _, _, _), S),
	nextTo(s(_, _, _, _, green), s(_, _, _, rice, _), S),
	member(s(_, genoa, five, _, _), S),
	member(s(spain, _, seven, _, _), S),
	member(s(_, hamburg, _, _, red), S),
	member(s(_, _, _, _, white), S),
	member(s(_, _, eight, _, black), S),
	member(s(_, _, mais, _, _), S),
	member(s(_, hamburg, six, _, _), S),
	member(s(_, _, _, tea, white), S),
	member(s(_, said, _, _, _), S).

leftOf(A, B, C):- append(_, [A,B|_], C).
rightOf(A, B, C):- append(_, [B,A|_], C).
nextTo(A, B, C):- leftOf(A, B, C); rightOf(A, B, C).
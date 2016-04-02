%(**) Eliminate consecutive duplicates of list elements.
compress([], []).
compress([H|[H|T]], X):- append([H], T, X1), compress(X1, X).
compress([H|T], X):- compress(T, X1), append([H], X1, X).

%P07 (**) Flatten a nested list structure.
flatten([], _).
flatten([H|T],X):- is_list(H), flatten(H, X), flatten(T,X).
flatten([H|T],X):- \+is_list(H), append(X,H,X1), flatten(T, X1), append(X1,[],X).

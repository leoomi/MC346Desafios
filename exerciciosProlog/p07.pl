%P07 (**) Flatten a nested list structure.
flatten(H, [H]):- \+is_list(H).
flatten([],[]):- !.
flatten([H|T],X):-  flatten(H, H2), flatten(T,T2), append(H2, T2, X).

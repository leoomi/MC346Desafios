% Find the K'th element of a list.
element_at(X, [X|_], N):- N =:= 0.
element_at(X, [_|Y], N):- N1 is N-1, element_at(X, Y, N1).

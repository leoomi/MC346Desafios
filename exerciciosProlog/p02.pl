% Find the last but one element of a list.
my_last1(X, [X|Y]):- Y = [_].
my_last1(X, [_|Y]):- my_last1(X, Y).

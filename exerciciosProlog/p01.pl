% Find the last element of a list.
my_last(X, [X|Y]):- Y = [].
my_last(X,[_|Y]):- my_last(X, Y).

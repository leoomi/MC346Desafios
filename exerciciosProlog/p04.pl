%P04 (*) Find the number of elements of a list.
my_length([], X):- X is 0.
my_length([_|A], X):- my_length(A, N), X is N+1.

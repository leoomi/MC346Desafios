%P05 (*) Reverse a list.
reverse([H|T], R, A):- reverse(T,R,[H|A]).
reverse([],A,A).

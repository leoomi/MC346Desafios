solve_equation(A=B, X):- solve(A, VRes1, NRes1), solve(B, VRes2, NRes2),
		V is VRes1 - VRes2, N is NRes2 - NRes1,
		X is N/V, !.

multiplication(0, NRes1, 0, NRes2, 0, N):-
    N is NRes1 * NRes2.
multiplication(0, NRes1, VRes2, NRes2, V, N):-
    V is NRes1 * VRes2, N is NRes1 * NRes2.
multiplication(VRes1, NRes1, 0, NRes2, V, N):-
    V is NRes2 * VRes1, N is NRes1 * NRes2.

division(0, NRes1, 0, NRes2, 0, N):-
    N is NRes1 / NRes2.
division(VRes1, NRes1, 0, NRes2, V, N):-
    V is VRes1 / NRes2, N is NRes1 / NRes2.

% Predicados responsaveis pelas operaçoes aritmeticas
solve(A+B, V, N):-
    solve(A, VRes1, NRes1), solve(B, VRes2, NRes2), 
    V is VRes1 + VRes2, N is NRes1 + NRes2.
solve(A-B, V, N):-
    solve(A, VRes1, NRes1), solve(B, VRes2, NRes2), 
    V is VRes1 - VRes2, N is NRes1 - NRes2.
solve(A*B, V, N):-
    solve(A, VRes1, NRes1), solve(B, VRes2, NRes2), 
    multiplication(VRes1, NRes1, VRes2, NRes2, V, N).
solve(A/B, V, N):-
    solve(A, VRes1, NRes1), solve(B, VRes2, NRes2), 
    division(VRes1, NRes1, VRes2, NRes2, V, N).

%predicado que determina que o elemento e um numero
solve(A, V, N):- number(A), 
		 V is 0, N is A.
solve(A, V, N):- is_alpha(A), 
		 V is 1, N is 0.

main:- read(Exp), solve_equation(Exp, X), write(X).

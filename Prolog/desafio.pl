%%%Predicado que separa a parte esquerda e direita do sinal de igual, e calcula o resultado da esquaçao.
%% Falha caso nao haja sinal de igual.
solve_equation(A=B, X):- solve(A, VRes1, NRes1, V1), solve(B, VRes2, NRes2, V2),
		(V1 \== V2 -> throw('2 vars or more'); true),
		V is VRes1 - VRes2, N is NRes2 - NRes1,
		(V =:= 0 -> throw('degree zero') ; true),
		X is N/V.

%Predicados para os casos particularres do primeiro elemento da expressao ter um sinal negativo ou positivo.
solve(+A, V, N, X):-
    atomic(A), !,
    solve(A, V, N, X).

solve(-A, V, N, X):-
    atomic(A), !,
    solve(A, V1, N1, X),
    V is -V1, N is -N1.

% Predicados responsaveis pelas operaçoes aritmeticas.
solve(A+B, V, N, X):-!,
    solve(A, VRes1, NRes1, X), solve(B, VRes2, NRes2, X), 
    V is VRes1 + VRes2, N is NRes1 + NRes2.
solve(A-B, V, N, X):-!,
    solve(A, VRes1, NRes1, X), solve(B, VRes2, NRes2, X), 
    V is VRes1 - VRes2, N is NRes1 - NRes2.
solve(A*B, V, N, X):-!,
    solve(A, VRes1, NRes1, X), solve(B, VRes2, NRes2, X), 
    multiplication(VRes1, NRes1, VRes2, NRes2, V, N).
solve(A/B, V, N, X):-!,
    solve(A, VRes1, NRes1, X), solve(B, VRes2, NRes2, X), 
    division(VRes1, NRes1, VRes2, NRes2, V, N).

%predicado que determina que o elemento e um numero.
solve(A, V, N, _):- number(A),!,
		    V is 0, N is A.
solve(A, V, N, A):- !, 
		    V is 1, N is 0.
solve(A, V, N, X):- V is 1, 
		    N is 0, 
		    (A \== X -> throw('2 vars or more'); true),
		    X is A.

%%%Predicados que calculam a multiplicaçao e divisao entre termos. Estas operaçoes sao necessarias pois podem modificar tanto o valor que mutliplica a variavel quanto o valor que e somado.
multiplication(0, NRes1, 0, NRes2, 0, N):-
    N is NRes1 * NRes2.
multiplication(0, NRes1, VRes2, NRes2, V, N):-
    V is NRes1 * VRes2, N is NRes1 * NRes2.
multiplication(VRes1, NRes1, 0, NRes2, V, N):-
    V is NRes2 * VRes1, N is NRes1 * NRes2.
multiplication(_, _, _, _, _, _):-
    throw('not degree 1').

division(0, NRes1, 0, NRes2, 0, N):-
    N is NRes1 / NRes2.
division(VRes1, NRes1, 0, NRes2, V, N):-
    V is VRes1 / NRes2, N is NRes1 / NRes2.

main:- catch(read(Exp), _, format('erro; syntax error~n')),
       \+var(Exp),
       catch(solve_equation(Exp, X), E, format('erro; ~w~n', E)), 
       \+var(R),
       write(X),
       write('; ok'), nl.

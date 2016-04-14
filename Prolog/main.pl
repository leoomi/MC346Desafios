%%% Predicado principal, que lê a expressão, executa o predicado de resolução de equações e imprime o resultado ou imprime erros.
main:- catch(read(Exp), _, format('erro; syntax error~n')),    %% Joga um exceção caso a expressão esteha mal formatada.
       \+var(Exp),
       catch(solve_equation(Exp, X), E, format('erro; ~w~n', E)),  
       \+var(X),
       write(X),
       write('; ok'), nl.

%%%Predicado que separa a parte esquerda e direita do sinal de igual, calcula os dois lados as expressões na forma ax + b, onde a e b são números e x é uma varíavel, e então calcula o resultado da esquação.
solve_equation(A=B, X):- solve(A, VRes1, NRes1, V1), solve(B, VRes2, NRes2, V2),
			 test_vars(V1, V2),
			 V is VRes1 - VRes2, N is NRes2 - NRes1,
			 (V =:= 0 -> throw('degree zero') ; true),  %% Joga uma exceção caso não haja uma variáveis
			 X is N/V.
%%% Predicado para o caso de não haver sinal de igual
solve_equation(_, _):- throw('no equal sign').

%%% Predicados responsáveis por determinar se a expressão lida não contém variáveis diferentes de cada lado da expressão
test_vars(V, V):- !.
test_vars(V1, V2):-(V1 \== V2 -> throw('more than one var');true), !.
test_vars(V1, V2):- \+var(V1), \+var(V2).


%%% Predicados que realizam as operações aritméticas para cada lado da expressão
%% Predicado para o caso específico de uma variável iniciada por letra maiúscula tenha sido inserida na entrada. Causa erros por ser considerada como uma variável de prolog.
solve(A, _, _, _):- var(A), throw('malformed expression').

%% Predicados responsáveis pelas operações aritméticas.
%% Separam os dois lados do termo, e após os pedaços serem calculados, realiza a operação.
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

%%% Predicados para os casos particulares em que sinais de positivo ou negativo estão no começo de um expressão.
solve(+A, V, N, X):-!,
    solve(A, V, N, X).

solve(-A, V, N, X):-
    solve(A, V1, N1, X),
    V is -V1, N is -N1.

%%% Predicados que determinam se um termo atômico é um número ou uma varíavel.
solve(A, V, N, _):- number(A), !,
		    V is 0, N is A.
solve(A, V, N, A):- atom(A), !,
		    V is 1, N is 0.
solve(A, V, N, X):- atom(A), 
		    test_atomvars(A, X), !,
		    V is 1, 
		    N is 0,
		    X is A.
%% Predicado que joga uma exceção para qualquer caso que não satisfaz os outro predicados solve, ou seja, deve ser um termo que não corresponde ao formato legível pelo programa
solve(_, _, _, _):- throw('malformed expression').  

%% Predicados que testam se um lado da expressao corretamente contém apenas uma variável
test_atomvars(_, X):- var(X), !.
test_atomvars(X, A):- atom(X), atom(A), (X \= A -> throw('more than one var'); true), !.
test_atomvars(A, A). 

%%% Predicados que calculam a multiplicação de dois termos
%% O caso onde apenas números estão sendo multiplicados
multiplication(0, NRes1, 0, NRes2, 0, N):- !,
    N is NRes1 * NRes2.
%% O caso onde há um número do lado direito multiplicando outro termo que contém variável e número
multiplication(0, NRes1, VRes2, NRes2, V, N):- !,
    V is NRes1 * VRes2, N is NRes1 * NRes2.
%% O caso onde há um número do lado esquerdo multiplicando outro termo que contém variável e número
multiplication(VRes1, NRes1, 0, NRes2, V, N):- !,
    V is NRes2 * VRes1, N is NRes1 * NRes2.
%% A exceção dos outros casos, onde há duas variáveis se multiplicando, ou seja, a equação não é de primeiro grau
multiplication(_, _, _, _, _, _):-
    throw('degree greater than one').

%%% Predicados que calculam a divisão de dois termos. 
%%% Obs.: Considera-se que não haverão varáveis com expoente negativo
%% Caso haja divisão por zero
division(_, _, _, 0, _, _):-!,
   throw('division by zero').
%% O caso onde um número divide o outro
division(0, NRes1, 0, NRes2, 0, N):- !,
    N is NRes1 / NRes2.
%% O caso onde uma variável e um número são divididos por um número
division(VRes1, NRes1, 0, NRes2, V, N):-
    V is VRes1 / NRes2, N is NRes1 / NRes2.


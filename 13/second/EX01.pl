% # 1. N Reines (20 points)
% Dans cet exercice, on généralise le problème des 8 reines en implémentant un prédicat
% capable de trouver les solutions pour N reines. Implémentez le prédicat suivant à l’aide
% de la propagation de contraintes.

% queens(+N,?L) : vrai si L est une solution au problème des N reines

% ## Exemple
% ?- queens(4,Q).
% Q = [2,4,1,3];
% Q = [3,1,4,2].

:- use_module(library(clpfd)).

queens(N, Qs) :-
    length(Qs, N),
    Qs ins 1..N,
    safe_queens(Qs),
    label(Qs).

safe_queens([]).
safe_queens([Q|Qs]) :- safe_queens(Qs, Q, 1), safe_queens(Qs).

safe_queens([], _, _).
safe_queens([Q|Qs], QLeft, QLeftIndexAcc) :-
    % Can't be placed at the same column
    QLeft #\= Q,

    % Avoid being on diagonal:
    %   QLeft
    %           _OQ
    %                   Q
    % With QLeftIndexAcc = 2    ==> abs(QLeft - Q) shouldn't be 2
    %                           ==> abs(2 - 4) ≠ 2  ↯
    %
    %                   QLeft
    %           ...
    %   Q
    % With QLeftIndexAcc = 2    ==> abs(QLeft - Q) shouldn't be 2
    %                           ==> abs(4 - 2) ≠ 2  ↯
    abs(QLeft - Q) #\= QLeftIndexAcc,

    % Increment accumulator for more distant queens
    QLeftIndexAcc1 is QLeftIndexAcc + 1,
    safe_queens(Qs, QLeft, QLeftIndexAcc1).


:- begin_tests(exercise1).

% https://en.wikipedia.org/wiki/Eight_queens_puzzle#Counting_solutions
test(n1) :-
    findall(X, queens(1, X), L),
    length(L, 1).

test(n4) :-
    findall(X, queens(4, X), L),
    length(L, 2),
    member([2,4,1,3], L),
    member([3,1,4,2], L), !.

test(n5) :-
    findall(X, queens(5, X), L),
    length(L, 10).

test(n6) :-
    findall(X, queens(6, X), L),
    length(L, 4).

test(n7) :-
    findall(X, queens(7, X), L),
    length(L, 40).

test(n8) :-
    findall(X, queens(8, X), L),
    length(L, 92).

test(n9) :-
    findall(X, queens(9, X), L),
    length(L, 352).

test(n10) :-
    findall(X, queens(10, X), L),
    length(L, 724).

% Comment out as it take too much time
% test(n11) :-
%     findall(X, queens(11, X), L),
%     length(L, 2680).

% test(n12) :-
%     findall(X, queens(12, X), L),
%     length(L, 14200).

:- end_tests(exercise1).

:- run_tests.

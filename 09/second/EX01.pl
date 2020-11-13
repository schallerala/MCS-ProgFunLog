% # Récursivité et récursivité terminale (30 points)
% Développez 2 versions des prédicats ci-dessous : une version récursive et une version
% récursive terminale avec accumulateurs.

% -----
% ## scalarProduct(+L1 ,+L2, -P)
% vrai si P est le produit scalaire des listes L1 et L2.
% Rappel : le produit scalaire des listes
% [v1, v2, v3] et [u1, u2, u3] est égal à v1*u1 + v2*u2 + v3*u3.
% ### 1. Recursive
scalarProduct([], [], 0).
scalarProduct([X1|XS], [Y1|YS], P) :-
    scalarProduct(XS, YS, P1),
    P is X1 * Y1 + P1.

% ### 2. Tail-recursive with accumulator
scalarProduct_acc([], [], Acc, Acc).
scalarProduct_acc([X1|XS], [Y1|YS], Acc1, P) :-
    Acc2 is X1 * Y1 + Acc1,
    scalarProduct_acc(XS, YS, Acc2, P).

scalaProduct_(XS, YS, P) :-
    scalarProduct_acc(XS, YS, 0, P).

% -----
% ## fibonacci(+N, ?FN)
% vrai si FN est est la valeur de fibonacci de N
% Définition de la suite de Fibonacci :
% f(0) = 0
% f(1) = 1
% f(n) = f(n-1) + f(n-2) // pour n≥2
% ### 1. Recursive
fibonacci(0, 0).
fibonacci(1, 1).
fibonacci(N, FN) :-
    N >= 2,
    N1 is N - 1,
    N2 is N - 2,
    fibonacci(N1, FN1),
    fibonacci(N2, FN2),
    FN is FN1 + FN2.

% ### 2. Tail-recursive with accumulator
% n(N2, N1): encodes: n-2 and n-1 values
fibonacci_acc(1, n(_, Acc), Acc).
fibonacci_acc(N, n(AccN2, AccN1), FN) :-
    N > 1,
    N1 is N - 1,
    AccN is AccN2 + AccN1,
    fibonacci_acc(N1, n(AccN1, AccN), FN).

fibonacci_(0, 0).
fibonacci_(N, FN) :-
    fibonacci_acc(N, n(0, 1), FN).

% -----
% ## countOccur(++X,++L, ?N)
% vrai si N est le nombre d’occurrences de X dans la liste L
% ### 1. Recursive
countOccur(_, [], 0).
countOccur(E, [E | XS], N) :-
    countOccur(E, XS, N1),
    N is N1 + 1.
countOccur(E, [X | XS], N) :-
    E \= X,
    countOccur(E, XS, N).

% ### 2. Tail-recursive with accumulator
countOccur_acc(_, [], Acc, Acc).
countOccur_acc(E, [E | XS], Acc, N) :-
    Acc1 is Acc + 1,
    countOccur_acc(E, XS, Acc1, N).
countOccur_acc(E, [X | XS], Acc, N) :-
    E \= X,
    countOccur_acc(E, XS, Acc, N).

countOccur_(E, XS, N) :-
    countOccur_acc(E, XS, 0, N).
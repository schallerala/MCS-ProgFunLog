% scalarProduct(+L1 ,+L2, -P):vrai si P est le produit scalaire des listes L1 et L2.
% Rappel: le produit scalaire des listes [v1, v2, v3] et [u1, u2, u3] est égal à v1*u1 + v2*u2 + v3*u3
% Exemple:  ?- scalarProduct([1,2,3],[1,2,3], P).
%           P = 14.

% version récursive
scalarProduct([],[],0).
scalarProduct([L1|Ls1] ,[L2|Ls2], P):- scalarProduct(Ls1, Ls2, P1), P is P1 + L1*L2.

% version récursive terminale
scalarProduct2(L1, L2, P):- scalarProduct3(L1,L2,0,P).

scalarProduct3([],[],Acc,Acc).
scalarProduct3([L1|Ls1] ,[L2|Ls2], Acc, P):- Acc2 is Acc + L1 * L2, scalarProduct3(Ls1, Ls2, Acc2, P). 

% fibonacci(+N,?FN): vrai si FN est est la valeur de fibonacci de N
% Définition de la suite de Fibonacci :
%   f(0)= 0
%   f(1) = 1
%   f(n) = f(n-1) + f(n-2) // pour n≥2

% version récursive
fibonacci(0,0).
fibonacci(1,1).
fibonacci(N,FN):- N > 1, N1 is N-1, N2 is N-2, fibonacci(N1, FN1), fibonacci(N2, FN2), FN is FN1 + FN2.

% version récursive terminale
% n(N2, N1): encode les valeurs n-2 et n-1
fibonacci2(0, 0).
fibonacci2(N, FN) :-
    fibonacci_acc(N, n(0, 1), FN).

fibonacci_acc(1, n(_, Acc), Acc).
fibonacci_acc(N, n(AccN2, AccN1), FN) :-
    N > 1,
    N1 is N - 1,
    AccN is AccN2 + AccN1,
    fibonacci_acc(N1, n(AccN1, AccN), FN).

% countOccur(+X,+L,?N): vrai si N est le nombre d’occurrences de X dans la liste L

% version récursive
countOccur(_,[],0).
countOccur(X,[L|Ls],N):-  L == X, countOccur(X, Ls, N1), N is N1 + 1.
countOccur(X,[L|Ls],N):-  L \== X, countOccur(X, Ls, N1), N is N1.

% version récursive terminale
countOccur2(X,L,N):- countOccur3(X,L,0,N).

countOccur3(_,[],Acc,Acc).
countOccur3(X,[X|Ls],Acc,N):- Acc1 is Acc + 1, countOccur3(X,Ls,Acc1,N).
countOccur3(X,[L|Ls],Acc,N):- X \= L, countOccur3(X,Ls,Acc,N).


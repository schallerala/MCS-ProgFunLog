% myMap(+Pred,+ LS,? LR) : équivalent à mapList/3. Utilisez le prédicat prédéfini call.
% Exemple : ?- myMap(plus(3),[2,5,8],L).
%              L=[5,8,11].

myMap(_,[],[]).
myMap(Pred, [X|Xs], [Y|Ys]):- call(Pred,X,Y), myMap(Pred,Xs,Ys).

% myPartition(+Pred,+List,?Included,?Excluded) : équivalent au prédicat prédéfini partition/4.
% Exemple : ?- myPartition(>(7),[4,9,23,2,6,11],L1,L2).
%              L1=[4,2,6], L2=[9,23,11]

myPartition(_,[],[],[]).
myPartition(Pred, [L|Ls], [L|Inc], Exc):- call(Pred, L), myPartition(Pred, Ls, Inc, Exc).
myPartition(Pred, [L|Ls], Inc, [L|Exc]):- \+ call(Pred, L), myPartition(Pred, Ls, Inc, Exc).

% filter(+Pred,+List,?Filtered) : équivalent au prédicat prédéfini include/3, vrai si Filtered contient
% les éléments de List qui satisfont le prédicat Pred.
% Exemple : ?- filter(>(7),[4,9,23,2,6,11],L1).
%              L1=[4,2,6]

filter(_,[],[]).
filter(Pred, [L|Ls], [L|F]):- call(Pred, L), filter(Pred,Ls,F).
filter(Pred, [L|Ls], F):- \+ call(Pred, L), filter(Pred,Ls,F).

% filterWithFindall(+Pred,+List,?Filtered) : identique à filter. Utilisez findall pour cette implémentation.
filterWithFindall(Pred, L, F):- findall(X, (member(X,L), call(Pred, X)), F).


% myIntersection(+E1,+E2,?E3) : équivalent à myIntersection de la série S11. Utilisez findall pour cette implémentation.
myIntersection(E1,E2,E3):- findall(X, (nth0(_, E1, El), member(El, E2)), E3).

% permutations(+L, ?LR) : vrai si LR est la liste des permutations de la liste L. Utilisez le prédicat
% permutation(L,P) ci-dessous:
%
%   permutation(L,P) est vrai si P est une permutation de la liste L.
%
%   permutation([],[]).
%   permutation(L,[X|T]) :- select(X,L,P), permutation(P,T).
% Exemple : ?- permutations([a,b,c],Ps).
%              Ps = [[a,b,c], [a,c,b], [b,a,c], [b,c,a], [c,a,b], [c,b,a]]

permutation([],[]).
permutation(L,[X|T]) :- select(X,L,P), permutation(P,T).

permutations(L, LR):- findall(X, permutation(L,X), LR).
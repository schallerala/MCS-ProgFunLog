% separate(+X,+L,?L1,?L2) : vrai si L1 est la liste constituée des éléments de la liste L qui sont
% inférieurs ou égaux à X, L2 est la liste constituée des éléments de la liste L qui sont strictement
% supérieurs à X.
% Exemple :    ?- separate(7,[4,9,23,2,6,11],L1,L2).
%                 L1=[4,2,6], L2=[9,23,11]

% sans cut
separate(_,[],[],[]).
separate(X,[L|Ls],[L|L1s],L2):- 
    L =< X, 
    separate(X,Ls,L1s,L2).
separate(X,[L|Ls],L1,[L|L2s]):- 
    L > X, 
    separate(X,Ls,L1,L2s).

% avec cut
separateCut(_,[],[],[]).
separateCut(X,[L|Ls],[L|L1s],L2):- 
    L =< X,
    !,
    separateCut(X,Ls,L1s,L2).
separateCut(X,[L|Ls],L1,[L|L2s]):- 
    separateCut(X,Ls,L1,L2s).
% myUnion(+E1,+E2,?E3) : où E1, E2 et E3 sont des listes représentant des ensembles (leurs
% éléments sont distincts deux à deux), myUnion(E1,E2,E3) est vrai si la liste E3 est l'union
% ensembliste des listes E1 et E2.
% Exemple :     ?- myUnion([3,6,2],[1,9,3],E).
%                  E = [6,2,1,9,3]

% sans cut
myUnion([], E2, E2).
myUnion([E|Es], E2, E3):-
    member(E,E2),
    myUnion(Es,E2,E3).    

myUnion([E|Es], E2, [E|E3]):-
    \+ member(E,E2),
    myUnion(Es,E2,E3).

% avec cut
myUnionCut([], E2, E2).
myUnionCut([E|Es], E2, E3):-
    member(E,E2), 
    !,
    myUnionCut(Es,E2,E3).    

myUnionCut([E|Es], E2, [E|E3]):-
    myUnionCut(Es,E2,E3).

% myIntersection(+E1,+E2,?E3) : où E1, E2 et E3 sont des listes représentant des ensembles (leurs
% éléments sont distincts deux à deux), myIntersection (E1,E2,E3) est vrai si la liste E3 est
% l'intersection des listes E1 et E2.
% Exemple :     ?- myIntersection ([3,6,1,2],[1,9,3],E).
%                  E = [3,1]

% sans cut
myIntersection([],_,[]).
myIntersection([E|Es], E2, [E|E3]):- 
    member(E, E2), 
    myIntersection(Es, E2, E3).
myIntersection([E|Es], E2, E3):- 
    \+ member(E, E2),
    myIntersection(Es, E2, E3).

% avec cut
myIntersectionCut([],_,[]).
myIntersectionCut([E|Es], E2, [E|E3]):- 
    member(E, E2), 
    !,
    myIntersectionCut(Es, E2, E3).
myIntersectionCut([E|Es], E2, E3):- 
    myIntersectionCut(Es, E2, E3).



% maxmin(+L,?Max,?Min) où L est une liste de valeurs numériques, Max est la plus grande de ces
% valeurs et Min est la plus petite.
% Exemple :     ?- maxmin([6,8,3,5,9,7],Max,Min).
%                  Max=9, Min=3

% récursive sans cut
maxmin([L],L,L).
maxmin([L|Ls],Max,L):- 
    maxmin(Ls, Max, Min),
    L < Min.
maxmin([L|Ls],L,Min):- 
    maxmin(Ls, Max, Min),
    L > Max.
maxmin([L|Ls],Max,Min):- 
    maxmin(Ls, Max, Min),
    L =< Max,
    L >= Min.

% récursive avec cut
maxminCut([L],L,L).

% for min
maxminCut([L|Ls],Max,L):- 
    maxminCut(Ls, Max, Min),
    L < Min,
    !.

% for max
maxminCut([L|Ls],L,Min):- 
    maxminCut(Ls, Max, Min),
    L > Max,
    !.

maxminCut([L|Ls],Max,Min):- 
    maxminCut(Ls, Max, Min).

% récursive terminale avec accumulateur et cut
maxminAcc(L,Max,Min):-
    maxminAcc2(L, -inf, inf, Max, Min).

maxminAcc2([],Max,Min,Max,Min).
% min
maxminAcc2([L|Ls],AccMax, AccMin, Max, Min):-
    L < AccMin,
    !,
    maxminAcc2(Ls, AccMax, L, Max, Min).

% max
maxminAcc2([L|Ls],AccMax, AccMin,Max,Min):-
    L > AccMax,
    !,
    maxminAcc2(Ls, L, AccMin, Max, Min).

maxminAcc2([L|Ls],AccMax, AccMin,Max,Min):- 
    maxminAcc2(Ls,AccMax, AccMin, Max, Min).
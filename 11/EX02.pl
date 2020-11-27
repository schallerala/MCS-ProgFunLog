% separate(+X,+L,?L1,?L2) : vrai si L1 est la liste constituée des éléments de la liste L qui sont
% inférieurs ou égaux à X, L2 est la liste constituée des éléments de la liste L qui sont strictement
% supérieurs à X.
% Exemple :    ?- separate(7,[4,9,23,2,6,11],L1,L2).
%                 L1=[4,2,6], L2=[9,23,11]

% sans cut
separate(_,[],[],[]).
separate(X,[L|Ls],[L|L1s],L2):- L =< X, separate(X,Ls,L1s,L2).
separate(X,[L|Ls],L1,[L|L2s]):- L > X, separate(X,Ls,L1,L2s).

% avec cut
separateCut(X,[L|Ls],[L|L1s],L2).

% myUnion(+E1,+E2,?E3) : où E1, E2 et E3 sont des listes représentant des ensembles (leurs
% éléments sont distincts deux à deux), myUnion(E1,E2,E3) est vrai si la liste E3 est l'union
% ensembliste des listes E1 et E2.
% Exemple :     ?- myUnion([3,6,2],[1,9,3],E).
%                  E = [6,2,1,9,3]

% QUESTION: les listes ont la même taille forcément ?

% sans cut
% FALSE
myUnion([],[],_).
myUnion([E|E1s],[E|E2s],[E|E3]):- \+ member(E,E3), myUnion(E1s,E2s,E3).
myUnion([E1|E1s],[E2|E2s],[E1,E2|E3]):- \+ member(E1,E3), \+ member(E2, E3), myUnion(E1s,E2s,E3).


% avec cut



% myIntersection(+E1,+E2,?E3) : où E1, E2 et E3 sont des listes représentant des ensembles (leurs
% éléments sont distincts deux à deux), myIntersection (E1,E2,E3) est vrai si la liste E3 est
% l'intersection des listes E1 et E2.
% Exemple :     ?- myIntersection ([3,6,1,2],[1,9,3],E).
%                  E = [3,1]

% sans cut
% FALSE
myIntersection([],[],_).
myIntersection([E|E1s],[E|E2s],[E,E3]):- myIntersection(E1s, E2s, E3).      % 2 first elements are the same
myIntersection([E1|E1s],[E2|E2s],[E1|E3]):- E1 \== E2, member(E1,E2s), myIntersection(E1s, [E2,E2s], E3).      % first of E1 is in E2
myIntersection([E1|E1s],[E2|E2s],[E2|E3]):- E1 \== E2, member(E2,E1s), myIntersection([E1|E1s], E2s, E3).  % first of E2 is in E1

% avec cut



% maxmin(+L,?Max,?Min) où L est une liste de valeurs numériques, Max est la plus grande de ces
% valeurs et Min est la plus petite.
% Exemple :     ?- maxmin([6,8,3,5,9,7],Max,Min)
%                  Max=9, Min=3

% récursive sans cut


% récursive avec cut

% récursive terminale avec accumulateur et cut


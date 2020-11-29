% # 2. Prédicats avec cut (points 40)
% Implémentez deux versions de chacun des prédicats qui suivent. Une version sans cut et
% une version avec cut visant à réduire au maximum l'arbre de recherche pour une question.
% Utilisez le prédicat prédéfini trace/1 pour tracer les appels à vos prédicats.

% ## separate(+X,+L,?L1,?L2)
% vrai si L1 est la liste constituée des éléments de la liste L qui sont
% inférieurs ou égaux à X, L2 est la liste constituée des éléments de la liste L qui sont
% strictement supérieurs à X.
% ### Exemple
% ?- separate(7,[4,9,23,2,6,11],L1,L2).
%  L1=[4,2,6], L2=[9,23,11]

% Without cut
separate(_, [], [], []).

separate(X, [E | LS], [E | L11], L2) :-
    E =< X,
    separate(X, LS, L11, L2).
separate(X, [E | LS], L1, [E | L21]) :-
    E > X,
    separate(X, LS, L1, L21).


% With cut
separate2(_, [], [], []).

separate2(X, [E | LS], [E | L11], L2) :-
    E =< X,
    !,
    separate2(X, LS, L11, L2).
separate2(X, [E | LS], L1, [E | L21]) :-
    separate2(X, LS, L1, L21).



% ## myUnion(+E1,+E2,?E3)
% où E1, E2 et E3 sont des listes représentant des ensembles (leurs
% éléments sont distincts deux à deux), myUnion(E1,E2,E3) est vrai si la liste E3 est
% l'union ensembliste des listes E1 et E2.
% ### Exemple
% ?- myUnion([3,6,2],[1,9,3],E).
% E = [6,2,1,9,3]

% Without cut
myUnion([], [], []).

myUnion([], Us, Us).

myUnion([E|E1], E2, [E | Us1]) :-
    member(E, E2),
    % select(?Elem, ?List1, ?List2)
    % Is true when List1, with Elem removed, results in List2. This implementation is
    % determinsitic if the last element of List1 has been selected.
    select(E, E2, E21),
    myUnion(E1, E21, Us1).
myUnion([E|E1], E2, [E | Us1]) :-
 \+ member(E, E2),
    myUnion(E1, E2, Us1).


% With cut
myUnion2([], [], []).

myUnion2([], Us, Us).

myUnion2([E|E1], E2, [E | Us1]) :-
    member(E, E2),
    !,
    % select(?Elem, ?List1, ?List2)
    % Is true when List1, with Elem removed, results in List2. This implementation is
    % determinsitic if the last element of List1 has been selected.
    select(E, E2, E21),
    myUnion2(E1, E21, Us1).
myUnion2([E|E1], E2, [E | Us1]) :-
    myUnion2(E1, E2, Us1).



% ## myIntersection(+E1,+E2,?E3)
% où E1, E2 et E3 sont des listes représentant des ensembles (leurs
% éléments sont distincts deux à deux), myIntersection (E1,E2,E3) est vrai si la liste
% E3 est l'intersection des listes E1 et E2.
% ### Exemple
% ?- myIntersection ([3,6,1,2],[1,9,3],E).
% E = [3,1]
% Without cut
myIntersection([], _, []).

myIntersection([E|E1], E2, [E | Is1]) :-
    member(E, E2),
    select(E, E2, E21),
    myIntersection(E1, E21, Is1).

myIntersection([E|E1], E2, Is) :-
 \+ member(E, E2),
    myIntersection(E1, E2, Is).


% With cut
myIntersection2([], _, []).

myIntersection2([E|E1], E2, Is) :-
    member(E, E2),
    !,
    select(E, E2, E21),
    myIntersection2(E1, E21, Is1),
    Is = [E | Is1].

myIntersection2([_|E1], E2, Is) :-
    myIntersection2(E1, E2, Is).



% ## Implémentez trois versions du prédicat qui suit.
% 1. Une version récursive sans cut et
% 2. une version récursive avec cut et
% 3. une version récurvice terminale avec accumulateurs et cut.
%
% ### maxmin(+L,?Max,?Min)
% où L est une liste de valeurs numériques, Max est la plus grande de ces valeurs et Min
% est la plus petite.
% ### Exemple
% ?- maxmin([6,8,3,5,9,7],Max,Min)
% Max=9, Min=3

% 1. Without cut
maxmin([MaxMin], MaxMin, MaxMin).

% je pense qu'on a pas le droit de les utiliser... A demander
% maxmin([E | Ls], Max, Min) :-
%     maxmin(Ls, Max1, Min1),
%     Max = max(E, Max1),
%     Min = min(E, Min1).
maxmin([E | Ls], E, Min) :-
    maxmin(Ls, Max1, Min),
    E > Max1.
maxmin([E | Ls], Max, E) :-
    maxmin(Ls, Max, Min1),
    E < Min1.
maxmin([E | Ls], Max, Min) :-
    maxmin(Ls, Max, Min),
    E >= Min,
    E =< Max.


% 2. With cut
maxmin2([MaxMin], MaxMin, MaxMin).

maxmin2([E | Ls], E, Min) :-
    maxmin2(Ls, Max1, Min),
    E > Max1,
    !.
maxmin2([E | Ls], Max, E) :-
    maxmin2(Ls, Max, Min1),
    E < Min1,
    !.
maxmin2([_ | Ls], Max, Min) :-
    maxmin2(Ls, Max, Min).


% 3. Tail recursive with accumulator and cut
maxmin3(Ls, Max, Min) :-
    maxmin3_acc(Ls, acc(-inf, inf), Max, Min).

maxmin3_acc([], acc(Max, Min), Max, Min).

maxmin3_acc([E | Ls], acc(AccMax, AccMin), Max, Min) :-
    E > AccMax,
    !,
    maxmin3_acc(Ls, acc(E, AccMin), Max, Min).
maxmin3_acc([E | Ls], acc(AccMax, AccMin), Max, Min) :-
    E < AccMin,
    !,
    maxmin3_acc(Ls, acc(AccMax, E), Max, Min).
maxmin3_acc([_ | Ls], acc(AccMax, AccMin), Max, Min) :-
    maxmin3_acc(Ls, acc(AccMax, AccMin), Max, Min).
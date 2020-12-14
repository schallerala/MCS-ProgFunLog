% # 3. Arbres binaires ordonnés (7 + 5 + 3 points)
% Pour cet exercice, on représente un arbre binaire ordonné par une liste à 3 éléments :
%   1. le premier est la racine de l’arbre,
%   2. le second est le sous arbre gauche contenant des nœuds tous strictement
%      inférieurs à la racine et
%   3. le troisième est le sous arbre droit contenant des nœuds tous supérieurs ou
%      égaux à la racine.
%
% ## Exemple
% l’arbre ci-dessous est représenté par la liste
% [ 6, [ 3, [], [ 5, [], [] ] ], [ 8, [], [] ] ]
%
%                       +-----+
%                       |  6  |
%                       +-----+
%                     ⟋        ⟍
%                  ⟋             ⟍
%               ⟋                  ⟍
%       +-----+                      +-----+
%       |  3  |                      |  8  |
%       +-----+                      +-----+
%              ⟍
%                +-----+
%                |  5  |
%                +-----+
%
% ## Implémentez les prédicats :
%   - insertTree(+V,+T,?NT) qui permet d’insérer l’élément V dans l’arbre T et d’obtenir
%     l’arbre NT.
%     Exemple :
%     ?- insertTree(5,[4, [], [7, [],[] ] ],T). est vrai si
%     T= [4, [], [7, [5, [], [] ], [] ] ]
%   - searchTree(?V,+T) : vrai si V est un des noeuds de l'arbre T
%   - constructTree(+NodeList,-Tree) : vrai si Tree est l’arbre binaire ordonné construit
%     à partir des éléments de la liste NodeList.
%     Attention : le ième élément de NodeList est ajouté à l’arbre construit à partir des
%                 i-1 premiers éléments de la liste.
%     Exemple :
%     ?- constructTree([6,3,12,8],T).
%     T = [6, [3, [], []], [12, [8, [], []], []]]

insertTree(NewV, [], [NewV, [], []]).

insertTree(NewV, [V, Inf, Supp], [V, Inf1, Supp]) :-
    NewV < V, !,
    insertTree(NewV, Inf, Inf1).
insertTree(NewV, [V, Inf, Supp], [V, Inf, Supp1]) :-
    NewV >= V,
    insertTree(NewV, Supp, Supp1).


% searchTree(_, []) :- fail.
searchTree(V, [V, _, _]).
searchTree(VSearch, [V, Inf, _]) :-
    VSearch < V, !,
    searchTree(VSearch, Inf).
searchTree(VSearch, [V, _, Supp]) :-
    VSearch >= V,
    searchTree(VSearch, Supp).


constructTree([E | Ls], T) :-
    % foldl(:Goal, +List, +V0, -V)
    % Fold a list, using arguments of the list as left argument. The foldl family of
    % predicates is defined by:
    %       foldl(P, [X11,...,X1n], ..., [Xm1,...,Xmn], V0, Vn) :-
    %           P(X11, ..., Xm1, V0, V1),
    %           ...
    %           P(X1n, ..., Xmn, V', Vn).
    foldl(insertTree, Ls, [E, [], []], T).




:- begin_tests(exercise3).

test(insertTreeExample, [nondet]) :-
    insertTree(5,[4, [], [7, [],[] ] ], T),
    assertion(T == [4, [], [7, [5, [], [] ], [] ] ]).
test(insertTreeEmpty, [nondet]) :-
    insertTree(5, [], T),
    assertion(T == [5, [], []]).
test(insertTreeEqual, [nondet]) :-
    insertTree(5, [5, [], []], T),
    assertion(T == [5, [], [5, [], []]]).

test(searchTreePass, [nondet]) :-
    searchTree(4, [4, [], [7, [5, [], [] ], [] ] ]).
test(searchTreeFail, [fail]) :-
    searchTree(8, [4, [], [7, [5, [], [] ], [] ] ]).

test(constructTreeExample, [nondet]) :-
    constructTree([6,3,12,8], T),
    assertion(T == [6, [3, [], []], [12, [8, [], []], []]]).

test(constructTreeSingle, [nondet]) :-
    constructTree([6], T),
    assertion(T == [6, [], []]).

:- end_tests(exercise3).

:- run_tests.

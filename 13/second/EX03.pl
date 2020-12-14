% Pour cet exercice, on représente un arbre binaire ordonné par une liste à 3 éléments : le premier est
% la racine de l’arbre, le second est le sous arbre gauche contenant des nœuds tous strictement inférieurs
% à la racine et le troisième est le sous arbre droit contenant des nœuds tous supérieurs ou égaux à la
% racine.
% Exemple : l’arbre ci-dessous est représenté par la liste [ 6, [ 3, [], [ 5, [], [] ] ], [ 8, [], [] ] ]
%                           6
%                        /     \
%                       3       8
%                         \
%                          5


% insertTree(+V,+T,?NT) qui permet d’insérer l’élément V dans l’arbre T et d’obtenir l’arbre NT.
% Exemple : ?- insertTree(5,[4, [], [7, [],[] ] ],T). est vrai si T= [4, [], [7, [5, [], [] ], [] ] ]

% QUESTION: si V == N, c'est bien un échec ?
insertTree(V,[],[V,[],[]]).

insertTree(V,[N, [], R],[N,[V,[],[]],R]):-
    V < N.
insertTree(V, [N,L,R], [N,NT,R]):-
    V < N, insertTree(V,L,NT).


insertTree(V,[N, L, []],[N,L, [V,[],[]]]):-
    V > N.
insertTree(V, [N,L,R], [N,L,NT]):-
    V > N, insertTree(V,R,NT).



% searchTree(?V,+T) : vrai si V est un des noeuds de l'arbre T
searchTree(V,[V,_,_]).

searchTree(V,[N,L,_]):-
    V < N, searchTree(V,L).

searchTree(V,[N,_,R]):-
    V > N, searchTree(V,R).



% constructTree(+NodeList,-Tree) : vrai si Tree est l’arbre binaire ordonné construit à partir des éléments de la liste NodeList.
% Attention : le ième élément de NodeList est ajouté à l’arbre construit à partir des i-1 premiers éléments de la liste.
% Exemple : ?- constructTree([6,3,12,8],T).
% T = [6, [3, [], []], [12, [8, [], []], []]]
    
constructTree([],[]).
constructTree(List,Tree):-
    construct(List, [],Tree).

construct([],TreeIn,TreeIn).
construct([N|Ns],TreeIn,TreeOut):-
    insertTree(N,TreeIn, Ts),
    !,
    construct(Ns,Ts,TreeOut).
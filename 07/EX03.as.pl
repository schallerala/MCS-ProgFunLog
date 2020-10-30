:- [annexe].

% child(X,Y) : vrai si X est un enfant de Y
child(X, Y) :-
    parent(Y, X).

% father(X,Y) : vrai si X est le père de Y
father(X, Y) :-
    parent(X, Y), male(X).

% mother(X,Y) : vrai si X est la mère de Y
mother(X, Y) :-
    parent(X, Y), female(X).

% grandparent(X,Y) : vrai si X est un des grand-parents de Y
grandparent(X, Y) :-
    parent(X, Z), parent(Z, Y).

% grandfather(X,Y) : vrai si X est un grand-père de Y
grandfather(X, Y) :-
    grandparent(X, Y), male(X).

% uncle(X,Y) : vrai si X est un oncle de Y
uncle(X, Y) :-
    /*
     *             G -|- _  Grandparent
     *                |
     *          +-----+-----+
     *         /             \
     * uncle  X -|- _         Z -|- _  parent
     *                           |
     *                           Y
     */
    male(X), parent(G, X), parent(G, Z),
    X \= Z, parent(Z, Y).

% ancestor(X,Y) : vrai si X est un ascendant de Y.
%                   Un ascendant est soit un des deux parents, un des grands parents,
%                   un des arrières grand parents, etc.
ancestor(X, Y) :- parent(X, Y).
ancestor(X, Y) :- parent(X, Z), ancestor(Z, Y).

% TODO, need to comment more?! Or other impl.?
%   Variez l'ordre des clauses et des sous-buts du prédicat ancestor et observer les
%   différences de résolution pour la question ouverte : ancestor(X,Y).
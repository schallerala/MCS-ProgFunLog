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

% QUESTIONS
%   Variez l'ordre des clauses et des sous-buts du prédicat ancestor et observer les
%   différences de résolution pour la question ouverte : ancestor(X,Y).

% REPONSES
% Variation des clauses: le changements de l'ordre des diverses clauses d'un prédicat ont une influence sur l'ordre de résultat des unifications.
% En effet, si nous inversons les deux clauses, nous aurons un arbre de recherche sous forme de "mirroir" par rapport à l'arbre de recherche 
% correspondant à l'ordre de notre code. Néanmoins, la finalité est la même, c'est-à-dire que nous avons exactement les mêmes paires de solution.

% Variation des sous-buts: ici aussi, la finalité reste identique et c'est le parcours vers le résultat qui change. 
% En effet, les règles ne sont pas exécutées dans le même ordre, ce qui peut aboutir à un succès/échec plus vite/tard. 
% Comme nous avons un sous-but récursif et l'autre non, il est plus judicieux de commencer par "parent" pour éviter une récursion inutile 
% en cas d'échec de "parent".
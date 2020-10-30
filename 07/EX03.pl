% S07 - Exercice : relations familiales - Annexe

% ****************************************************
% male(PersonName)
male(hector).
male(paul).
male(david).
male(marc).
male(felix).
male(jean).
male(roger).
male(didier).
male(nicolas).
male(jacques).
male(luc).
male(martin).
male(patrick).
male(sebastien).

% ****************************************************
% female(PersonName)
female(anne).
female(julie).
female(elisa).
female(danielle).
female(sophie).
female(carole).
female(virginie).
female(martine).
female(claudia).
female(lise).
female(helene).
female(isa).
female(melissa).

% ****************************************************
% parent(ParentName, ChildName)
parent(hector,julie).
parent(anne,julie).
parent(hector,paul).
parent(anne,david).
parent(elisa,marc).
parent(elisa,danielle).
parent(felix,jean).
parent(jean,carole).
parent(julie,carole).
parent(marc,didier).
parent(didier,nicolas).
parent(carole,nicolas).
parent(roger,virginie).
parent(virginie,martine).
parent(didier,martine).
parent(paul,jacques).
parent(sophie,jacques).
parent(jacques,luc).
parent(virginie,luc).
parent(virginie,claudia).
parent(jacques,claudia).
parent(nicolas,lise).
parent(claudia,lise).
parent(david,helene).
parent(danielle,helene).
parent(martin,patrick).
parent(helene,patrick).
parent(claudia,sebastien).
parent(patrick,sebastien).
parent(martine,isa).
parent(sebastien,isa).
parent(claudia,melissa).
parent(patrick,melissa).

% ****************************************************
% child(X,Y) : vrai si X est un enfant de Y
child(X,Y):- parent(Y,X).

% ****************************************************
% father(X,Y) : vrai si X est le père de Y
father(X,Y):- parent(X,Y), male(X).

% ****************************************************
% mother(X,Y) : vrai si X est la mère de Y
mother(X,Y):- parent(X,Y), female(X).

% ****************************************************
% grandparent(X,Y) : vrai si X est un des grand-parents de Y
grandparent(X,Y):- parent(X,Z), parent(Z,Y).

% ****************************************************
% grandfather(X,Y) : vrai si X est un grand-père de Y
grandfather(X,Y):- grandparent(X,Y), male(X).

% ****************************************************
% uncle(X,Y) : vrai si X est un oncle de Y
uncle(X,Y):- male(X), parent(Z,Y), parent(_,Z), child(X,Y).

% ****************************************************
% ancestor(X,Y) vrai si X est un ascendant de Y. Un ascendant est soit un des deux parents, un
% des grands parents, un des arrières grand parents, etc.
ancestor(X,Y):- parent(X,Y).
ancestor(X,Y):- parent(X,Z), ancestor(Z,Y).

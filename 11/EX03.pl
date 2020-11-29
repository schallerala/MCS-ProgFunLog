% Une implémentation du prédicat myMax(+X,+Y,?Z) avec le cut est proposée ci-dessous
%
% myMax(X,Y,Z) est vrai si Z est le maximum de X et Y.

myMax(X,Y,X):- X >= Y,!.
myMax(X,Y,Y).

% Expliquez pourquoi cette implémentation n’est pas correcte. Montrez à l'aide d'un arbre de
% recherche que pour certaines questions elle retourne un mauvais résultat

% REPONSE
% Erreur lorsque le dernier paramètre est un atom et qu'il correspond à la plus petite valeur :
% P.ex.     ?- myMax(3,2,2).
%              true.
%
% Correction:
myMax2(X,Y,X):- X >= Y, !.
myMax2(X,Y,Y):- X < Y.

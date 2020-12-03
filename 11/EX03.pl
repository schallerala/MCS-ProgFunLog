% # 3. Correction de prédicat (points 10)
% Une implémentation du prédicat myMax(+X,+Y,?Z) avec le cut est proposée ci-dessous.
% myMax(X,Y,Z) est vrai si Z est le maximum de X et Y.
% myMax(X,Y,X) :- X>=Y,!.
% myMax(X,Y,Y).

myMax(X,Y,X) :- X>=Y, !.
myMax(_,Y,Y).

% ## Expliquez pourquoi cette implémentation n’est pas correcte. Montrez à l'aide d'un
% arbre de recherche que pour certaines questions elle retourne un mauvais résultat

:- write("Pour résoudre Z, le prédicat myMax fonctionne comme espéré, par contre, "),
   write("si nous posons la question avec un Z, les clauses ne sont pas mutuellements "),
   write("exclusives. Ce qui permettrait d'obtenir `true` pour myMax(8, 1, 1), "),
   write("par example"), nl.


% ## Proposez une correction
myMax2(X,Y,X) :- X >= Y, !.
myMax2(X,Y,Y) :- X < Y.
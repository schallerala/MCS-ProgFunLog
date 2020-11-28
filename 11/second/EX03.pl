% # 3. Correction de prédicat (points 10)
% Une implémentation du prédicat myMax(+X,+Y,?Z) avec le cut est proposée ci-dessous.
% myMax(X,Y,Z) est vrai si Z est le maximum de X et Y.
% myMax(X,Y,X) :- X>=Y,!.
% myMax(X,Y,Y).

% ## Expliquez pourquoi cette implémentation n’est pas correcte. Montrez à l'aide d'un
% arbre de recherche que pour certaines questions elle retourne un mauvais résultat



% ## Proposez une correction
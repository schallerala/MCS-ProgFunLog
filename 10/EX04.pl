% # 4. Prédicats avec DCG (18 points)
% Développez les prédicats suivants à l'aide de DCG :

% ## myLast(?X,+L)
% vrai si X est le dernier élément de la liste L.

% ### Indication
% myLast(X,L ) est implémenté comme suit :
%   myLast(X,L) :- myLastDCG(X,L,[]).
% où myLastDCG est implémenté avec le formalisme DCG et où X est un extra goal de ce
% prédicat.



% --------
% ## convertToDec( ?X,++L)
% vrai si X est la valeur décimale du nombre binaire représenté par la liste L.

% ### Exemple
% convertToDec(V,[1,1,1]). retourne comme résultat V=7 car 7 est la valeur décimale
% du nombre binaire 111

% ### Indication
% Utilisez le même principe d'implémentation que pour le prédicat précédent
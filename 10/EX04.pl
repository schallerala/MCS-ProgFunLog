% # 4. Prédicats avec DCG (18 points)
% Développez les prédicats suivants à l'aide de DCG :

% ## myLast(?X,+L)
% vrai si X est le dernier élément de la liste L.

% ### Indication
% myLast(X,L) est implémenté comme suit :
%   myLast(X,L) :- myLastDCG(X,L,[]).
% où myLastDCG est implémenté avec le formalisme DCG et où X est un extra goal de ce
% prédicat.
myLast(X, L) :- myLastDCG(X, L, []).

myLastDCG(X) --> whatever(_), [X].

whatever(0) --> [].
whatever(Len) --> [C], { char_type(C, ascii) }, whatever(Len1), { Len is Len1 + 1 }.

% without whatever predicate
myLast2(X, L) :- myLastDCG2(X,L,[]).

myLastDCG2(X) --> [_], myLastDCG2(X).
myLastDCG2(X) --> [X].


% --------
% ## convertToDec(?X,++L)
% vrai si X est la valeur décimale du nombre binaire représenté par la liste L.

% ### Exemple
% convertToDec(V,[1,1,1]). retourne comme résultat V=7 car 7 est la valeur décimale
% du nombre binaire 111

% ### Indication
% Utilisez le même principe d'implémentation que pour le prédicat précédent

convertToDec(X, L) :- convertToDecDCG(X, 0, L, []).

% Accumulator used to count the number of character read by bit, to know to much we
% have to shift the first read bit
convertToDecDCG(X, Acc) --> bit(X1), {Acc1 is Acc + 1}, convertToDecDCG(X2, Acc1), { X is 2**Acc1 * X1 + X2 }.
convertToDecDCG(X, _) --> bit(X).

bit(1) --> [1].
bit(0) --> [0].

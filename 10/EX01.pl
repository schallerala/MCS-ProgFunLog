% # 1. DCG et expression arithmétique (12 points)
% La grammaire ci-dessous reconnaît un sous ensemble des expressions arithmétiques.
% Implémentez un analyseur syntaxique pour cette grammaire à l’aide des DCG et ajoutez un
% extra argument pour calculer la valeur d’une expression reconnue.

% Grammaire :
%   E → T
%   E → T ‘+’ E
%   T → F
%   T → F ‘*’ T
%   F → <integer>
%   F → ‘(‘ E ‘)’

% Exemple : pour le but phrase(e(V),[1,+,2,*,4],[]). , l’interpréteur retourne V=9
% (la valeur de cette expression arithmétique)

e(Res) --> t(Res).
e(Res) --> t(R1), [+], e(R2), { Res is R1 + R2 }.
t(Res) --> f(Res).
t(Res) --> f(R1), [*], t(R2), { Res is R1 * R2 }.
f(X) --> [X], { integer(X) }.
f(Res) --> ['('], e(Res), [')'].

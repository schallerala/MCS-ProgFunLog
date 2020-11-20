% # 3. DCG et expression régulières (20 points)
% Implémenter des analyseurs syntaxiques à l'aide de DCG pour les expressions régulières
% qui suivent :
%   1. a*bca*
%   2. (a.|bc)*uu*
%       2.1 note : . désigne n’importe quel caractère

% ## Indications :
% commencez par déterminer une grammaire algébrique correspondant à  l'expression
% régulière, puis utilisez le formalisme des DCG pour implémenter un analyseur de
% cette grammaire.

% ## Exemple :
% pour l'expression régulière 'abc', une grammaire possible est ex1 -> abc. On implémente
% l'analyseur syntaxique avec la règle DCG : ex1 --> [a,b,c].

% Utilisez le prédicat prédéfini char_type/2. Exemple: char_type(C,ascii) vrai si C est
% un caractère ascii.


% 1. a*bca*
rule1 --> [a], whatever(_), [b, c, a], whatever(_).
whatever(0) --> [].
whatever(Len) --> [C], { char_type(C, ascii) }, whatever(Len1), { Len is Len1 + 1 }.


% 2. (a.|bc)*uu*
% TODO review, en vrai, le . n'est pas nécessaire, car le * avant uu, va de toute façon
%   consommer d'avantage de charactères. On retire? On parle de la simplification.
rule2 --> group1, whatever(_), [u, u], whatever(_).
group1 --> [a], whatever(1).
group1 --> [b, c].
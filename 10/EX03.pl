% # 3. DCG et expression régulières (20 points)
% Implémenter des analyseurs syntaxiques à l'aide de DCG pour les expressions régulières
% qui suivent :
%   1. a*bca*
%   2. (a.|bc)*uu*
%       2.1 note : . désigne n’importe quel caractère

% ## Indications :
% commencez par déterminer une grammaire algébrique correspondant à l'expression
% régulière, puis utilisez le formalisme des DCG pour implémenter un analyseur de
% cette grammaire.

% ## Exemple :
% pour l'expression régulière 'abc', une grammaire possible est ex1 -> abc. On implémente
% l'analyseur syntaxique avec la règle DCG : ex1 --> [a,b,c].

% Utilisez le prédicat prédéfini char_type/2. Exemple: char_type(C,ascii) vrai si C est
% un caractère ascii.


% 1. a*bca*
rule1 --> as, [b, c], as.
as --> [a], as.
as --> [].


% 2. (a.|bc)*uu*
rule2 --> rule2group1, [u], us.
rule2group1 --> [a], [C], { char_type(C, ascii) }, rule2group1.
rule2group1 --> [b, c], rule2group1.
rule2group1 --> [].
us --> [u], us.
us --> [].
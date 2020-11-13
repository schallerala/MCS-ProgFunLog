% # Analyseurs syntaxiques (30 points)
% Implémentez un analyseur syntaxique pour les grammaires qui suivent à l'aide des
% différences de listes.
% Vous pouvez utiliser le prédicat prédéfini integer(X) qui retourne vrai si X est un
% entier.

% -----
% ## 1.
%       S → BB
%       B → 0 B | 1
s(S-R) :-
    b(S - R1),
    b(R1 - R).
b(B-R) :-
    B = [0 | R1],
    b(R1-R).
b([1|R]-R).

% -----
% ## 2.
%       S → a b S | ɛ
s_([a, b | S]-R) :-
    s_(S-R).
s_(R-R).

% -----
% ## 3.
%       S → a b T c T
%       S → T
%       T → U T d
%       T → ɛ
%       U → k S
s__([a, b | S]-R) :-
    t__(S-R1),
    R1 = [c | R2],
    t__(R2-R).
s__(S-R) :-
    t__(S-R).
t__(T-R) :-
    u__(T-R1),
    t__(R1-R2),
    R2 = [d | R].
t__(R-R).
u__([k | U]-R) :-
    s__(U-R).
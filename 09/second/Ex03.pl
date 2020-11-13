% # 3. Problème du zèbre (30 points)
% Cinq maisons toutes de couleurs différentes, sont habitées par des personnes toutes de
% nationalités différentes. Elles possèdent chacune un animal différent, ont chacune une
% boisson préférée différente et fument des cigarettes différentes. On sait que :
%   1.    Le norvégien habite la première maison,
%   2.    La maison à côté de celle du norvégien est bleue,
%   3.    L’habitant de la troisième maison boit du lait,
%   4.    L’anglais habite une maison rouge,
%   5.    L’habitant de la maison verte boit du café,
%   6.    L’habitant de la maison jaune fume des kool,
%   7.    La maison blanche se trouve juste après la verte,
%   8.    L’espagnol a un chien,
%   9.    L’ukrainien boit du thé,
%   10.   Le japonais fume des craven,
%   11.   Le fumeur de old gold a un escargot,
%   12.   Le fumeur de gitane boit du vin,
%   13.   Un voisin du fumeur de chesterfield a un renard,
%   14.   Un voisin du fumeur de kool a un cheval.
%
% Qui boit de l’eau ? Qui possède un zèbre ?
%
% ## Indications
% Pour résoudre ce problème, on vous suggère d’écrire la relation
% housesComposition(C,A,B,F,N) où:
%   -   C est la liste des 5 couleurs: C=[C1,C2,C3,C4,C5] tel que Ci est la couleur de la
%       ième maison.
%   -   A est la liste des 5 animaux: A=[A1,A2,A3,A4,A5] tel que Ai est l’animal de la
%       ième maison.
%   -   B est la liste des 5 boissons: B=[B1,B2,B3,B4,B5] tel que Bi est la boisson
%       consommée dans la ième maison.
%   -   F est la liste des 5 cigarettes : F=[F1,F2,F3,F4,F5] tel que Fi sont les
%       cigarettes fumées dans la ième maison.
%   -   N est la liste des 5 nationalités : N=[N1,N2,N3,N4,N5] tel que Ni est la
%       nationalité de l’habitant de la ième maison.
%
% Vous pouvez développer et utiliser les prédicats :
%   -   sameIndex(E1,E2,L1,L2) où sameIndex(E1,E2,L1,L2) est vrai si E1 et E2 ont
%       respectivement les mêmes indices dans les listes L1 et L2.
sameIndex(E1, E2, L1, L2) :-
    nth0(I1, L1, E1),
    nth0(I1, L2, E2).

%   -   neighbor(V1,L1,V2,L2) où neighbor(V1,L1,V2,L2) est vrai si V1 et V2 ont
%       respectivement des index voisins dans les listes L1 et L2.
neighbor(V1, L1, V2, L2) :-
    nth0(I1, L1, V1),
    nth0(I2, L2, V2),
    Diff is abs(I1 - I2),
    Diff == 1.

% La question housesComposition(C,A,B,F,N) retourne la solution modélisée par ces 5
% listes.
%
% Utilisez le prédicat housesComposition pour développer les prédicats suivants :
%   -   drink(N,D) : vrai si la personne de nationalité N boit la boisson D
%   -   hasAnimal(N,A) : vrai si la personne de nationalité N possède l'animal A
%   -   smoke(N,C) : vrai si la personne de nationalité N fume des cigarettes C
%   -   color(I,C) : vrai si la maison de numéro I est de couleur C


% drink(N,D): nationality N drinks D
% 3.    L’habitant de la troisième maison boit du lait,
% 5.    L’habitant de la maison verte boit du café,
% 9.    L’ukrainien boit du thé,
% 12.   Le fumeur de gitane boit du vin,
drink(N, D) :-
    housesComposition(_Co, _A, Ds, _Ci, Ns),
    nth0(I, Ds, D),
    nth0(I, Ns, N).

% hasAnimal(N,A): nationality N has an anmial A
% 8.    L’espagnol a un chien,
% 11.   Le fumeur de old gold a un escargot,
% 13.   Un voisin du fumeur de chesterfield a un renard,
% 14.   Un voisin du fumeur de kool a un cheval.
hasAnimal(N, A) :-
    housesComposition(_Co, As, _D, _Ci, Ns),
    nth0(I, As, A),
    nth0(I, Ns, N).

% smoke(N,C): nationality N smokes cigarettes C
% 6.    L’habitant de la maison jaune fume des kool,
% 10.   Le japonais fume des craven,
% 11.   Le fumeur de old gold a un escargot,
% 12.   Le fumeur de gitane boit du vin,
% 13.   Un voisin du fumeur de chesterfield a un renard,
% 14.   Un voisin du fumeur de kool a un cheval.
smoke(N, C) :-
    housesComposition(_Co, _A, _D, Cis, Ns),
    nth0(I, Cis, C),
    nth0(I, Ns, N).

% color(I,C): Home I is of color C
% 2.    La maison à côté de celle du norvégien est bleue,
% 4.    L’anglais habite une maison rouge,
% 5.    L’habitant de la maison verte boit du café,
% 6.    L’habitant de la maison jaune fume des kool,
% 7.    La maison blanche se trouve juste après la verte,
color(I, C) :-
    housesComposition(Cos, _A, _D, _Ci, _N),
    noth0(I, Cos, C).
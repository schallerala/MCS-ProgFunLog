% A l'aide des prédicats et des opérateurs de la couche CSP, résolvez le problème SEND + MORE =
% MONEY.
% Trouvez les chiffres correspondants aux lettres S, E, N, D, M, O, R, Y pour que l'addition suivante soit
% correcte, sachant que les chiffres correspondant aux lettres sont tous différents, le domaine de
% valeurs des lettres S et M est [1...9 ], le domaine de valeur des lettres E, N, D, O, R, Y est [0..9].
%               S E N D
%             + M O R E
%             _________
%             M O N E Y
% Implémentez le prédicat suivant à l’aide de la propagation de contraintes :
% sendMore([S,E,N,D],[M,O,R,E],[M,O,N,E,Y])
:- use_module(library(clpfd)).


sendMore([S,E,N,D],[M,O,R,E],[M,O,N,E,Y]):-
    [S,M] ins 1..9,
    [E, N, D, O, R, Y] ins 0..9,
    all_different([S, E, N, D, M, O, R, Y]),
    1000 * S + 100 * E + 10 * N + D 
        + 1000 * M + 100 * O + 10 * R + E 
        #= 10000 * M + 1000 * O + 100 * N + 10 * E + Y,
    label([S, E, N, D, M, O, R, Y]).
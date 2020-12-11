% # 2. SEND + MORE = MONEY (10 points)
% A l'aide des prédicats et des opérateurs de la couche CSP, résolvez le problème
% SEND + MORE = MONEY.
%
% Trouvez les chiffres correspondants aux lettres S, E, N, D, M, O, R, Y pour que
% l'addition suivante soit correcte, sachant que les chiffres correspondant aux lettres
% sont tous différents, le domaine de valeurs des lettres S et M est [1...9 ], le domaine
% de valeur des lettres E, N, D, O, R, Y est [0..9].
%
%              S  E  N  D
%           +  M  O  R  E
%           -------------
%           M  O  N  E  Y
%
% Implémentez le prédicat suivant à l’aide de la propagation de contraintes :
% sendMore([S,E,N,D],[M,O,R,E],[M,O,N,E,Y])

:- use_module(library(clpfd)).

sendMore([S, E, N, D], [M, O, R, E], [M, O, N, E, Y]) :-
    All = [S, E, N, D, M, O, R, Y],
    [S, M] ins 1..9,
    [E, N, D, O, R, Y] ins 0..9,
    all_different(All),
                S * 1000 + E * 100 + N * 10 + D
              + M * 1000 + O * 100 + R * 10 + E
 #= M * 10000 + O * 1000 + N * 100 + E * 10 + Y,
    label(All).




:- begin_tests(exercise2).

test(success) :-
    All = [S, E, N, D, M, O, R, Y],
    sendMore([S,E,N,D],[M,O,R,E],[M,O,N,E,Y]),
    is_set(All),
    maplist(nonvar, All),
    between(1, 9, S),
    between(1, 9, M),
    maplist(between(0, 9), [E, N, D, O, R, Y]), nl,
    write("[s,e,n,d]"),write("[m,o,r,e]"),write("[m,o,n,e,y]"), nl,
    write([S,E,N,D]),write([M,O,R,E]),write([M,O,N,E,Y]), nl, !.


:- end_tests(exercise2).

:- run_tests.
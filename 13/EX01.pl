% queens(+N,?Q) : vrai si L est une solution au problème des N reines
% Exemple : ?- queens(4,Q).
% Q = [2,4,1,3];
% Q = [3,1,4,2].

:- use_module(library(clpfd)).

define_plus([],[],_).
define_plus([Q|Qs],[QUD|QUDs], Acc):-
    QUD #= Q + Acc,
    Acc2 is Acc + 1,
    define_plus(Qs, QUDs, Acc2).
    

define_minus([],[],_).
define_minus([Q|Qs],[QUD|QUDs], Acc):-
    QUD #= Q - Acc,
    Acc2 is Acc + 1,
    define_minus(Qs, QUDs, Acc2).
    

queens(N,Q):-
    length(Q,N),
    Q ins 1..N,
    all_different(Q),
    define_plus(Q,QUD, 1),
    all_different(QUD),
    define_minus(Q,QDD, 1),
    all_different(QDD),
    label(Q).
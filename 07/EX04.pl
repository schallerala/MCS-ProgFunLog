% hanoi(N,D,I,G) :
%   N est le nombre de disques à déplacer,
%   D est le piquet de départ,
%   I le piquet intermédiaire et
%   G est le piquet d’arrivée
hanoi(1,D,_,G) :- writef("dep from %q to %q\n", [D, G]).
hanoi(N,D,I,G) :-
    N > 1,
    N1 is N - 1,
    hanoi(N1, D, G, I),
    hanoi(1,  D, I, G),
    hanoi(N1, I, D, G).

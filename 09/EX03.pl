sameIndex(E1,E2,L1,L2):- sameIndexAcc(E1,E2,L1,L2, 0, I), I < 5.

sameIndexAcc(_,_,[],[],Acc,Acc).
sameIndexAcc(E1,E2,[E1|_],[E2|_], Acc, Acc).
sameIndexAcc(E1,E2,[_|Ls1],[_|Ls2], Acc, I):-
    Acc2 is Acc + 1,
    sameIndexAcc(E1,E2,Ls1,Ls2,Acc2, I).

% neighbor(V1,L1,V2,L2) où neighbor(V1,L1,V2,L2) est vrai si V1 et V2 ont
% respectivement des index voisins dans les listes L1 et L2.
neighbour(_,[],_,[]).
neighbour(V1,L1,V2,L2):-
    indexOf(L1,V1,I1), 
    indexOf(L2,V2,I2),
    I is abs(I1-I2),
    I == 1.

% V1 is neighbour on the right of V2
neighbourRight(_,[],_,[]).
neighbourRight(V1,L1,V2,L2):-
    indexOf(L1,V1,I1), 
    indexOf(L2,V2,I2),
    I is I1-I2,
    I == 1.

indexOf([E|_], E, 0). 
indexOf([_|Ls], E, I):-
    indexOf(Ls, E, I1), 
    I is I1+1.

housesComposition(H,C,A,B,F,N):-
    H = [1,2,3,4,5],
    length(C, 5),
    length(A, 5),
    length(B, 5),
    length(F, 5),
    length(N, 5),
    sameIndex(norvegien,1,N,H),
    neighbour(norvegien, N, bleue, C),
    sameIndex(3,lait,H,B), % 3
    sameIndex(anglais,rouge,N,C),
    sameIndex(verte, cafe,C,B),
    sameIndex(jaune,kool,C,F),
    neighbourRight(verte,C,blanche,C),
    sameIndex(espagnol,chien,N,A),
    sameIndex(ukrainien,the,N,B),
    sameIndex(japonais,craver,N,F),
    sameIndex(oldgold, escargot, F, A),
    sameIndex(gitane,vin,F,B),
    neighbour(chesterfield,F,renard,A),
    neighbour(kool,F,cheval,A).

% ==================================================================================

zebra(H,C,A,B,F,N):-
    housesComposition(H,C,A,B,F,N).
    




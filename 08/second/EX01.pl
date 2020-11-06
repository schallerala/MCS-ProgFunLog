%    ___     ___             _  _     ___    _____             ___     ___     ___     ___     ___     ___    _____
%    |   \   / _ \     o O O | \| |   / _ \  |_   _|    o O O  / __|   / _ \   | _ \   | _ \   | __|   / __|  |_   _|
%    | |) | | (_) |   o      | .` |  | (_) |   | |     o      | (__   | (_) |  |   /   |   /   | _|   | (__     | |
%    |___/   \___/   TS__[O] |_|\_|   \___/   _|_|_   TS__[O]  \___|   \___/   |_|_\   |_|_\   |___|   \___|   _|_|_
%  _|"""""|_|"""""| {======|_|"""""|_|"""""|_|"""""| {======|_|"""""|_|"""""|_|"""""|_|"""""|_|"""""|_|"""""|_|"""""|
%  "`-0-0-'"`-0-0-'./o--000'"`-0-0-'"`-0-0-'"`-0-0-'./o--000'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'


% myLength(?N,+L): vrai si N est le nombre d’éléments de la liste L
% exemple:? -mylength(N,[a,b,c]).
%            N=3
mylength(0,[]).
mylength(N1,[_|Xs]) :-
    mylength(N, Xs),
    N1 is N + 1.


% myAppend(?L1,?L2,?L3) vrai si L3 est la concaténation des listes L1 et L2
% exemple:? -myAppend([a,b,c],[d,e],L).
%            L=[a,b,c,d,e]
myAppend([], Xs, Xs).
myAppend([X|Xs], Ys, [X|Xs2]) :-
    myAppend(Xs, Ys, Xs2).


% myLast(?E,+L): vrai si E est le dernier élément de L
% exemple:? -myLast(X,[a,b,c]).
%            X=c
myLast(E, [E]).
myLast(E, [_|Xs]) :-
    myLast(E, Xs).


% mySelect(?E,+L1,?L2): vrai si L2 est la liste L1 sans une occurrence de E
% exemple:? -mySelect(b,[a,b,c],L).
%            L=[a,c]
mySelect(_,[],[]).
mySelect(E,[E|Xs],Xs2) :-
    mySelect(E, Xs, Xs2).
mySelect(E,[E2|Xs],[E2,Xs2]) :-
    E \== E2, % ---------------- DIFF
    mySelect(E, Xs, Xs2).


% atoms(+L) : vrai si L est une liste dont les éléments sont des atoms. Indication: utilisez le prédicat prédéfini atom/1
% exemple:? -atoms([a,[1,2],b,c]).
%            false
atoms([X|Xs]) :-
    atom(X),
    atoms(Xs).


% insert(+X,?L1,?L2): vrai si L1 et L2 sont des listes triées et L2 est la liste L1 augmentée de l'élément X
% exemple:? -insert(5,[2,4,7,12],L).
%            L=[2,4,5,7,12]
insert(X,[],[X]).
insert(X,[X1|Xs],[X,X1|Xs]) :-
    X =< X1.
insert(X,[X1|Xs],[X1|L21]) :-
    X > X1,
    insert(X,Xs,L21).


% mergeLists(+L1,+L2,?L3) vrai si L1, L2 et L3 sont triées et L3 est la fusion des listes L1 et L2
% exemple:? -mergeLists([2,6,9],[1,8,13,23],L).
%            L=[1,2,6,8,9,12,23]
mergeLists(Xs,[],Xs).
mergeLists([],Xs,Xs).
mergeLists([X|Xs],[Y|Ys],[X|ZS2]) :-
    X < Y,
    mergeLists(Xs, [Y|Ys], ZS2).
mergeLists([X|Xs],[Y|Ys],[Y|ZS2]) :-
    X >= Y,
    mergeLists([X|Xs], Ys, ZS2).


% sum_list(+L,?S): vrai si S est la somme des éléments de L
sum_list([X|Xs],N) :-
    sum_list(Xs, N2),
    N is N2 + X.


% reverseRec(+L1,?L2): vrai si L2 est la liste L1 renversée à tous les niveaux (y compris les listes internes)
% exemple:? -reverseRec([a,[b,c],d,e,[f,g,h]],L).
%            L=[[h,g,f],e,d,[c,b],a]
reverseRec([],[]).
reverseRec([X|Xs],Xs2) :-
    is_list(X),
    reverseRec(X, Xs21),
    reverseRec(Xs, Xs22),
    myAppend(Xs22, [Xs21], Xs2).
reverseRec([X|Xs],Xs2) :-
    not(is_list(X)),
    reverseRec(Xs, Xs21),
    myAppend(Xs21, [X], Xs2).


% myMin(+L,?X): vrai si X est le plus petit élément de L
myMin([X],X).
myMin([X|Xs],X1) :-
    myMin(Xs, X2),
    X < X2,
    X1 = X.
myMin([X|Xs],X1) :-
    myMin(Xs, X2),
    X >= X2,
    X1 = X2.
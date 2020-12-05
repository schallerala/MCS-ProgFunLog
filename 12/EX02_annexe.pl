transformListInTermWithoutFunctor(L, P) :-
    addCommaFunctor(L, R),
    transformListWithCommas(R, P).

addCommaFunctor([X],[X]) :- !.
addCommaFunctor([X, Y], [',', X, Y]) :- !.
addCommaFunctor([X | R], [',', X | [T]]) :- addCommaFunctor(R, T).

transformListWithCommas([',', X, [',' | Y]], P) :-
    !,
    transformListWithCommas([',' | Y], F),
    P =..[',', X, F].
transformListWithCommas([',',X,Y],P) :-
    !,
    P =..[',', X, Y].
transformListWithCommas([X], X).
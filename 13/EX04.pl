% # 4. Prédicats divers (3 + 7 points)
% Implémentez les prédicats suivants :
%   a) Le prédicat maplist en utilisant le prédicat prédéfini include
%   b) Un prédicat analogue à la fonction foldl d’Haskell

myMapList(Goal, Ls):-
    include(Goal, Ls, Ls2),
    same_length(Ls, Ls2).


myFoldl(_, [], []).
myFoldl(Goal, [X | Xs], [Y | Ys]) :-
    call(Goal, X, Y),
    myFoldl(Goal, Xs, Ys).




isEven(X) :-
    mod(X, 2) =:= 0.

:- begin_tests(exercise04).

test(myMapListExample) :-
    myMapList(isEven,[2,12,24]).

test(myMapListFail, [fail]) :-
    myMapList(is(3),[2,3,5,8]).


test(ownFoldl, [nondet]) :-
    myFoldl(plus(3),[2,3,5,8],N),
    assertion(N == [5,6,8,11]).
test(ownFoldlEmpty, [nondet]) :-
    myFoldl(plus(3),[], N),
    assertion(N == []).

:- end_tests(exercise04).

:- run_tests.
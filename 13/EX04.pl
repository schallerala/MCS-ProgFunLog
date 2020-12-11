% Implémentez les prédicats suivants :
% a) Le prédicat maplist en utilisant le prédicat prédéfini include

myMapList(_,[],[]).
myMapList(Goal, [X|Xs]):-
    include(Goal, [X|Xs], _).


% b) Un prédicat analogue à la fonction foldl d’Haskell

myFoldl(_, [],[]).
myFoldl(Goal,[X|Xs],[Y|Ys]):-
    call(Goal, X, Y),
    myFoldl(Goal, Xs, Ys).


% Test the examples
:- begin_tests(ex04).
test(myMapList, [nondet]) :-
    myMapList(is(3),[2,3,5,8]).


test(myFoldl, [nondet]) :-
    myFoldl(plus(3),[2,3,5,8],N),
    assertion(N == [5,6,8,11]).


:- end_tests(ex04).
:- run_tests.

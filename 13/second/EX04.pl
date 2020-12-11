% # 4. Prédicats divers (3 + 7 points)
% Implémentez les prédicats suivants :
%   a) Le prédicat maplist en utilisant le prédicat prédéfini include
%   b) Un prédicat analogue à la fonction foldl d’Haskell

% TODO myMapList. Not sure what is expected, as include and maplist don't behave
%   the same way. For example:
%       ?- maplist(>(3), [3]).
%       false.
%
%       ?- include(>(3), [3], T).
%       T = [].                        => true, in opposition to the previous maplist call

myFoldl(Goal, [], []).
myFoldl(Goal, [X | Xs], [Y | Ys]) :-
    call(Goal, X, Y),
    myFoldl(Goal, Xs, Ys).


:- begin_tests(exercise04).


% test(myMapList, [nondet]) :-
%     myMapList(is(3),[2,3,5,8]).


test(ownFoldl, [nondet]) :-
    myFoldl(plus(3),[2,3,5,8],N),
    assertion(N == [5,6,8,11]).
test(ownFoldlEmpty, [nondet]) :-
    myFoldl(plus(3),[], N),
    assertion(N == []).

:- end_tests(exercise04).

:- run_tests.
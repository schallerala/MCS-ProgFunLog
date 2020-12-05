% # 1. Prédicats d'ordre supérieur (22 points)
% ## myMap(+Pred,+ LS,? LR)
% équivalent à mapList/3. Utilisez le prédicat prédéfini call.
% ### Exemple
% ?- myMap(plus(3),[2,5,8],L).
%  L=[5,8,11].

myMap(_, [], []).

myMap(Predicate, [E | Ls], [R | Rs]) :-
    call(Predicate, E, R),
    myMap(Predicate, Ls, Rs).

% ## myPartition(+Pred,+List,?Included,?Excluded)
% équivalent au prédicat prédéfini partition/4.
% ### Exemple
% ?- myPartition(>(7),[4,9,23,2,6,11],L1,L2).
%  L1=[4,2,6], L2=[9,23,11]

myPartition(_, [], [], []).

myPartition(Predicate, [E | Ls], [E | Incl2], Excluded) :-
    call(Predicate, E), !,
    myPartition(Predicate, Ls, Incl2, Excluded).

myPartition(Predicate, [E | Ls], Included, [E | Excl2]) :-
 \+ call(Predicate, E),
    myPartition(Predicate, Ls, Included, Excl2).

% ## filter(+Pred,+List,?Filtered)
% équivalent au prédicat prédéfini include/3, vrai si Filtered contient
% les éléments de List qui satisfont le prédicat Pred.
% ### Exemple
% ?- filter(>(7),[4,9,23,2,6,11],L1).
%  L1=[4,2,6]

filter(_, [], []).

filter(Predicate, [E | Ls], [E | Pass2]) :-
    call(Predicate, E), !,
    filter(Predicate, Ls, Pass2).

filter(Predicate, [E | Ls], Passed) :-
 \+ call(Predicate, E),
    filter(Predicate, Ls, Passed).


% ## filterWithFindall(+Pred,+List,?Filtered)
% identique à filter. Utilisez findall pour cette
% implémentation.

filterWithFindall(Predicate, List, Passed) :-
    findall(E, (member(E, List), call(Predicate, E)), Passed).

% ## myIntersection(+E1,+E2,?E3)
% équivalent à myIntersection de la série S11. Utilisez findall pour
% cette implémentation.
myIntersection(Ls1, Ls2, Intersection) :-
    findall(E, (member(E, Ls1), member(E, Ls2)), Intersection).

% ## permutations(+L, ?LR)
% vrai si LR est la liste des permutations de la liste L. Utilisez le prédicat
% permutation(L,P) ci-dessous. permutation(L,P) est vrai si P est une permutation de la liste L.
permutation([],[]).
permutation(L,[X|T]) :- select(X,L,P), permutation(P,T).
% ### Exemple
% ?- permutations([a,b,c],Ps).
%  Ps = [[a,b,c], [a,c,b], [b,a,c], [b,c,a], [c,a,b], [c,b,a]]

permutations(Ls, Permutations) :-
    findall(X, permutation(Ls, X), Permutations).

% Test the examples
:- begin_tests(exercise01).

test(myMap, [nondet]) :-
    myMap(plus(3),[2,5,8],L),
    assertion(L == [5,8,11]).

test(myPartition, [nondet]) :-
    myPartition(>(7),[4,9,23,2,6,11],L1,L2),
    assertion(L1 == [4,2,6]),
    assertion(L2 == [9,23,11]).

test(filter, [nondet]) :-
    filter(>(7),[4,9,23,2,6,11],L1),
    assertion(L1 == [4,2,6]).

test(filterWithFindall) :-
    filterWithFindall(>(7),[4,9,23,2,6,11],L1),
    assertion(L1 == [4,2,6]).

test(myIntersection) :-
    myIntersection([3,6,1,2],[1,9,3],E),
    assertion(E == [3, 1]).

test(permutations) :-
    permutations([a,b,c],Ps),
    assertion(Ps == [[a,b,c], [a,c,b], [b,a,c], [b,c,a], [c,a,b], [c,b,a]]).

:- end_tests(exercise01).

:- run_tests.

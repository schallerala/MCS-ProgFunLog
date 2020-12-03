
exp(exp(or(X,Y))) --> subExp(X), ['|'], exp(Y).
exp(exp(X)) --> subExp(X).

subExp([X|Y]) --> term(X), subExp(Y).
subExp([X]) --> term(X).

term(X) --> subTerm(X).
term(iter(X)) --> subTerm(X), ['*'].

subTerm(char(X)) --> [X], {char_type(X, ascii), \+ member(X, ['*','.','|','(',')'])
}.
subTerm(point) --> ['.'].
subTerm(X) --> ['('], exp(X), [')'].
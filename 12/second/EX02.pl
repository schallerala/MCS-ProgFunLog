% Partie 2
:- ['EX02_annexe'].

isRule([r,'_'|_]). 

grammar([RL]) --> rule(RL).
grammar([R]) --> rule(RL), grammar(GR), {append(RL,GR,R)}.

rule((A-->B)) --> ruleName(A), ['->'], ruleBodies(C), {findall(Y,transformListInTermWithoutFunctor(C,Y),[B])}.
ruleName(A) --> [A], {atom_chars(A,B), isRule(B)}.

ruleBodies(RB) --> ruleBody(RB).
ruleBodies([RB|RBS]) --> ruleBody(RB), ['|'], ruleBodies(RBS).

ruleBody([RB]) --> ruleBodyPart(RB).
ruleBody([RBP|RB]) --> ruleBodyPart(RBP), ruleBody(RB).

ruleBodyPart(RN) --> ruleName(RN).
ruleBodyPart([A]) --> [A], {atom_chars(A,B), \+ isRule(B), \+ member(A,['|','->'])}.


% Ex2 - Partie 1

isRule([r,'_'|_]). 

grammar --> rule.
grammar --> rule, grammar.

rule --> ruleName, ['->'], ruleBodies.
ruleName --> [A], {atom_chars(A,B), isRule(B)}.

ruleBodies --> ruleBody.
ruleBodies --> ruleBody, ['|'], ruleBodies.

ruleBody --> ruleBodyPart.
ruleBody --> ruleBodyPart, ruleBody.

ruleBodyPart --> ruleName.
ruleBodyPart --> [A], {atom_chars(A,B), \+ isRule(B), \+ member(A,['|','->'])}.

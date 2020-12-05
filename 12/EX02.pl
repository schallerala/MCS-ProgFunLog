% # 2. Mini-projet - Partie 2 : Générateur d'analyseurs syntaxiques (32 points)
% Le but de cet exercice est de générer dynamiquement les règles DCG pour une grammaire
% dont les règles sont de la forme suivante :
%   - la forme d'une règle est :
%       - soit : <rule name> -> <rule body> | ... | <rule body>
%       - soit : <rule name> -> <rule body>
%   - le nom d'une règle respecte le pattern suivant : r_xxx où xxx est une suite
%     quelconque de caractères
%   - le corps d'une règle est de la forme : <rule body part> + où <rule body part> est
%     soit un nom de règle soit un atome ne commençant pas par 'r_'.
% Exemples de grammaires reconnues :
%   - Grammaire correspondant à l'expression régulière (ab)+
% r_1 -> a b r_1 | a b
%   - Grammaire correspondant à l'expression régulière (a|b)+
% r_1 -> r_2 r_1 | r_2
% r_2 -> a | b
% La grammaire de grammaires qui suit reconnaît les grammaires algébriques décrites
% ci-dessus.
% grammar -> rule | rule grammar
% rule -> ruleName '->' ruleBodies
% ruleName -> <ident> % où ident commence par 'r_'
% ruleBodies -> ruleBody | ruleBody '|' ruleBodies
% ruleBody -> ruleBodyPart
% ruleBody -> ruleBodyPart ruleBody
% ruleBodyPart -> ruleName
% ruleBodyPart -> <atom> % où atom ne commençant pas par 'r_'

% ## Première étape (12 points)
% =============================
% Implémentez les règles DCG correspondantes à la grammaire ci-dessus.
% Exemples d'appel du prédicat grammar pour les deux grammaires précédentes.
%   - grammar([r_1, '->', a, b, r_1, '|', a,b], []). retourne yes car la liste contient
%     des règles reconnues par votre grammaire
%   - grammar([r_1, '->', r_2, r_1, '|', r_2, r_2, '->', a, '|', b], []). retourne yes
% ### Indications
% vous pouvez utiliser les prédicats prédéfinis atom/1 et atom_chars/2. atom(X) est vrai
% si X est un atome; atom_chars(X,L) est vrai si L est la liste des caractères de
% l'atome X.
% atom_chars(toto,L) est vrai si L=[t,o,t,o].

atom_starts_like_rule_name(A) :-
    atom_chars(A, Chars),
    prefix([r, '_'], Chars). % TODO review: not authorized?
not_special_character(A) :-
    not(member(A, ['->', '|'])). % TODO review: not authorized?

step_1_grammar --> step_1_rule.
step_1_grammar --> step_1_rule, step_1_grammar.
step_1_rule --> step_1_ruleName, ['->'], step_1_ruleBodies.
step_1_ruleName --> [A], { atom_starts_like_rule_name(A) }.
step_1_ruleBodies --> step_1_ruleBody.
step_1_ruleBodies --> step_1_ruleBody, ['|'], step_1_ruleBodies.
step_1_ruleBody --> step_1_ruleBodyPart.
step_1_ruleBody --> step_1_ruleBodyPart, step_1_ruleBody.
step_1_ruleBodyPart --> step_1_ruleName.
step_1_ruleBodyPart --> [A], { not(atom_starts_like_rule_name(A)), not_special_character(A) }.

% ## Deuxième étape (15 points)
% =============================
% Ajoutez des extra arguments aux règles DCG pour qu'elles génèrent les
% règles DCG correspondant à la grammaire reconnue.
% ### Exemple
%   - grammar(RL, [r_1, '->', r_2, r_1, '|', r_2, r_2, '->', a, '|', b],[]).
%     retourne vrai avec RL= [ (r_1-->r_2, r_1), (r_1-->r_2), (r_2-->[a]), (r_2-->[b])]
% ### Indication
% Dans la génération des règles DCG correspondantes aux règles reconnues par rule vous
% pouvez utiliser :
%   - Le prédicat transformListInTermWithoutFunctor/2 donné en annexe.
%     transformListInTermWithoutFunctor (L,T) est vrai si T est de la forme (e1,e2,...)
%     où e1, e2 etc sont les éléments de la liste L.
%     Exemple : transformListInTermWithoutFunctor([[a],r_2,[b]], L)
%               retourne vrai avec L = ([a], r_2, [b]).
:- ['EX02_annexe'].
%   - Le prédicat d’ordre supérieur findall/3 vue en cours.


produces_tuple(RN, E, T) :-
    transformListInTermWithoutFunctor(E, E2),
    T = (RN --> E2). % Perso je comprends pas comment (RN --> (r_1, r_2)) donne (RN --> r_1, r_2)...


grammar(RL) --> rule(RL).
grammar(Rules) --> rule(RL), grammar(RLs), { append(RL, RLs, Rules) }. % TODO review: not authorized?

rule(Rules) --> ruleName(RN), ['->'], ruleBodies(RBs), { maplist(produces_tuple(RN), RBs, Rules) }. % TODO review: not authorized?

ruleName(RN) --> [RN], { atom_starts_like_rule_name(RN) }.

ruleBodies([RB]) --> ruleBody(RB).
ruleBodies([RB | RBs]) --> ruleBody(RB), ['|'], ruleBodies(RBs).

ruleBody([RB]) --> ruleBodyPart(RB).
ruleBody([RB | RBs]) --> ruleBodyPart(RB), ruleBody(RBs).

ruleBodyPart(RN) --> ruleName(RN).
ruleBodyPart([A]) --> [A], { not(atom_starts_like_rule_name(A)), not_special_character(A) }.



% ## Troisième étape (5 points)
% =============================
% Développez le prédicat generateRules(Gramar) qui génère les clauses
% modélisant la grammaire Grammar (exprimée sous forme de liste) et les ajoute à la base
% de connaissance du moteur d'inférence Prolog
% ### Exemple
%   - generateRules([r_1, '->', r_2, r_1, '|', r_2, r_2, '->', a, '|', b]).
%     retourne vrai et crée dynamiquement les clauses modélisant la grammaire ayant pour
%     règles r_1 -> r_2 r_1 | r_2 et r_2 -> a | b
%     Après cet appel, il est possible d'interroger le prédicat r_1.
% ### Exemple
%   - r_1([a,a,b],[]). retourne vrai car la séquence a a b est reconnue par la grammaire
%     d'axiome r_1.
% ### Indication
% Vous pouvez utiliser les prédicats prédéfinis expand-term, assert et maplist vus en
% cours.


expand_assertz_term(E) :-
    expand_term(E, DCG),
    maplist(assertz, DCG).

generateRules(Rules) :-
    grammar(DCG_Rules, Rules, []),
    maplist(expand_assertz_term, DCG_Rules).


% Test with the given examples

:- dynamic (r_1/2).
:- set_prolog_flag(double_quotes, chars).
:- begin_tests(exercise02).


test(step_one_example_01, [nondet]) :-
    step_1_grammar([r_1, '->', a, b, r_1, '|', a,b], []).
test(step_one_example_02, [nondet]) :-
    step_1_grammar([r_1, '->', r_2, r_1, '|', r_2, r_2, '->', a, '|', b], []).


test(step_two_simple_a, [nondet]) :-
    grammar(RL, [r_1, '->', a],[]),
    assertion(RL == [(r_1-->[a])]).
test(step_two_simple_or, [nondet]) :-
    grammar(RL, [r_1, '->', a, '|', b],[]),
    assertion(RL == [(r_1-->[a]), (r_1-->[b])]).

test(step_two_example, [nondet]) :-
    grammar(RL, [r_1, '->', r_2, r_1, '|', r_2, r_2, '->', a, '|', b],[]),
    assertion(RL == [(r_1-->r_2, r_1), (r_1-->r_2), (r_2-->[a]), (r_2-->[b])]).



% TODO review: Don't know why they don't work, but I strongly believe it should.
%   Also tried, simply running them from the interpreter in the terminal.
test(step_three_simple_a, [nondet]) :-
    generateRules([r_1, '->', a, '|', b]),
    r_1([a],[]),
    r_1([b],[]),
    retractall(r_1(_, _, _)).

test(step_three_gen_expression, [nondet]) :-
    generateRules([r_1, '->', r_2, r_1, '|', r_2, r_2, '->', a, '|', b]),
    r_1([a,a,b],[]),
    retractall(r_1(_, _, _)),
    retractall(r_2(_, _, _)).


:- end_tests(exercise02).


:- run_tests.
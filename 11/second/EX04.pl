% # 4. Mini-projet - Partie 1 (points 30)
% Le but est de développer des prédicats de reconnaissance et manipulation d'un sous ensemble des
% expressions régulières.
% Les expressions régulières traitées dans le cadre de ce mini-projet utilisent les caractères ascii et les
% caractères spéciaux * . ( ) | et peuvent être récursives.

% ## Exemples :
%   - ab.*ba
%   - (ab)*cd
%   - a(bc*|f)*

% ## La grammaire utilisée est la suivante :
% exp  -->  subExp '|' exp
% exp --> subExp
% subExp  -->  term subExp | term
% term  -->  subTerm* | subTerm
% subTerm -->  <char> | . | '(' exp ')'

exp(exp(or(SubA, SubB))) --> subExp(SubA), ['|'], { ! }, exp(exp(SubB)).
exp(exp(Sub)) --> subExp(Sub).

subExp([E | Sub]) --> term(E), subExp(Sub).
subExp([E]) --> term(E).

term(iter(E)) --> subTerm(E), ['*'], { ! }.
term(E) --> subTerm(E).

subTerm(point)   --> ['.'], { ! }.
subTerm(E) --> ['('], exp(E), [')'], { ! }.
subTerm(char(C)) --> [C], { char_type(C, ascii) }.

% ## Travail à faire
% Implémentez un analyseur syntaxique à l’aide de DCG pour cette grammaire et ajoutez des arguments
% afin de générer l’arbre syntaxique tel que décrit ci-dessous
% Arbre syntaxique demandé
%   - la racine de l’arbre d’une expression régulière est : exp
%   - les sous-expressions d’une expression forment une liste
%   - l’arbre syntaxique respecte les conversions suivantes :

% +=============================+===================================================================+
% | Règle                       | Arbre syntaxique                                                  |
% +=============================+===================================================================+
% | exp -->  subExp '|' exp     | exp(or(<arbre synt. de subExp>,<arbre synt. de exp>))             |
% +-----------------------------+-------------------------------------------------------------------+
% | exp --> subExp              | exp(<arbre syntaxique de subExp>)                                 |
% +-----------------------------+-------------------------------------------------------------------+
% | subExp -->  term subExp     | [<arbre syntaxique de term> | <arbre syntaxique de subExp>]       |
% +-----------------------------+-------------------------------------------------------------------+
% | subExp --> term             | [<arbre syntaxique de term>]                                      |
% +-----------------------------+-------------------------------------------------------------------+
% | term --> subTerm*           | Iter(<arbre syntaxique de subTerm>)                               |
% |                             | Exemples : iter(char(a)), iter(point)                             |
% +-----------------------------+-------------------------------------------------------------------+
% | subTerm --> <char>          | char(<char>)                                                      |
% |                             | Exemples: char(a), char(c)                                        |
% +-----------------------------+-------------------------------------------------------------------+
% | subTerm--> .                | point                                                             |
% +-----------------------------+-------------------------------------------------------------------+

% ## Exemples
% +=================+===========================================================================================+
% | Expression      | régulière Arbre syntaxique                                                                |
% +=================+===========================================================================================+
% | abc             | exp([char(a), char(b), char(c)])                                                          |
% +-----------------+-------------------------------------------------------------------------------------------+
% | ab*.a           | exp([char(a), iter(char(b)), point, char(a)])                                             |
% +-----------------+-------------------------------------------------------------------------------------------+
% | (ab)*c          | exp([iter(exp([char(a), char(b)])), char(c)])                                             |
% +-----------------+-------------------------------------------------------------------------------------------+
% | ab | cd         | exp(or(exp([char(a), char(b)]), exp([char(c), char(d)])))                                 |
% +-----------------+-------------------------------------------------------------------------------------------+
% | a(bc|de)*g      | exp([char(a), iter(exp(or(exp([char(b), char(c)]), exp([char(d), char(e)])))), char(g)])  |
% +-----------------+-------------------------------------------------------------------------------------------+
% Utilisez le prédicat prédéfini char_type/2. Exemple: char_type(C,ascii) vrai si C est un caractère ascii.



% Pretty print of `a(bc|de)*g`:
%
% exp([
%    char(a),
%    iter(
%        exp(
%            or(
%                exp([
%                    char(b), char(c)
%                ]),
%                exp([
%                    char(d), char(e)
%                ])
%            )
%        )
%    ),
%    char(g)
% ])

:- begin_tests(exercise04).

% TODO could be improved, as I'm getting 'choicepoint' warnings...

% Given examples
test(abc) :-
    phrase(exp(E), [a, b, c], []),
    assertion(E == exp([char(a), char(b), char(c)])).

test(aiterbpointa) :-
    phrase(exp(E), [a, b, '*' ,'.', a], []),
    assertion(E == exp([char(a), iter(char(b)), point, char(a)])).

test(iterabc) :-
    phrase(exp(E), ['(', a, b, ')', '*', c], []),
    assertion(E == exp([iter(exp([char(a), char(b)])), char(c)])).

test(orabcd) :- % FIXME
    phrase(exp(E), [a, b, '|', c, d], []),
    assertion(E == exp(or(exp([char(a), char(b)]), exp([char(c), char(d)])))).

test(aiterorg) :- % FIXME
    phrase(exp(E), [a, '(', b, c, '|', d, e, ')', '*', g], []),
    assertion(E == exp([char(a), iter(exp(or(exp([char(b), char(c)]), exp([char(d), char(e)])))), char(g)])).

% Own tests
test(aorb) :- % FIXME or is it correct?
    phrase(exp(E), [a, '|', b], []),
    assertion(E == exp(or(char(a), char(b)))).

:- end_tests(exercise04).
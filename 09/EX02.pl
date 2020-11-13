% Implémentez un analyseur syntaxique pour les grammaires qui suivent à l'aide des différences de listes. 
% Vous pouvez utiliser le prédicat prédéfini integer(X)qui retourne vrai si X est un entier.
% 1.  S → B B
%     B → 0 B | 1
s1(S,R):- b1(S,R2), b1(R2,R).

b1([1|R],R).
b1([0|S],R):- b1(S,R).

% 2.  S → a b S | ɛ
s2([a,b | S2],R):- s2(S2,R).
s2(S,S).


% 3.  S → a b T c T
%     S → T 
%     T → U T d
%     T → ε
%     U → k S

s3([a,b|S2],R):- t3(S2, [c|R3]), t3(R3,R).
s3(S,R):- t3(S,R).

t3(S,R):- u3(S,R1), t3(R1,[d|R]).
t3(S,S).

u3([k|S2],R):- s3(S2,R).
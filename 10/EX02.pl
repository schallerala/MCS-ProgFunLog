% # 2. DCG et langage naturel (20 points)
% La grammaire ci-dessous reconnaît des phrases en français constituées d’un groupe
% nominal suivi d’un groupe verbal. Implémentez un analyseur syntaxique pour cette
% grammaire qui vérifie que :
%  - le groupe nominal est masculin ou féminin
%  - le groupe nominal et le groupe verbal sont au pluriel ou au singulier

% maPhrase -> groupeNominal groupeVerbal
% groupeNominal -> article substantif | article substantif adjectif | prenom
% groupeVerbal -> verbe
% prenom -> ruth | david
% article -> le | la | les |un |une |des
% substantif -> chien | chat |amis |voiture | souris
% verbe -> chante | roule | marche | racontent | avancent
% adjectif -> rouge | rouges | blanc | blancs | blanche | blanches

maPhrase --> groupeNominal(_, SP), groupeVerbal(SP).
groupeNominal(MF, SP) --> article(MF, SP), substantif(MF, SP).
groupeNominal(MF, SP) --> article(MF, SP), substantif(MF, SP), adjectif(MF, SP).
groupeNominal(MF, SP) --> prenom(MF, SP).

groupeVerbal(SP) --> verbe(SP).

prenom(fem, sing) --> [ruth].
prenom(mas, sing) --> [david].

article(mas, sing) --> [le].
article(fem, sing) --> [la].
article(_  , pl  ) --> [les].
article(mas, sing) --> [un].
article(fem, sing) --> [une].
article(_  , pl  ) --> [des].

substantif(mas, sing) --> [chien].
substantif(mas, sing) --> [chat].
substantif(mas, pl) --> [amis].
substantif(fem, sing) --> [voiture].
substantif(fem, _) --> [souris].

verbe(sing) --> [chante].
verbe(sing) --> [roule].
verbe(sing) --> [marche].
verbe(pl  ) --> [racontent].
verbe(pl  ) --> [avancent].

adjectif(_  , sing) --> [rouge].
adjectif(_  , pl  ) --> [rouges].
adjectif(mas, sing) --> [blanc].
adjectif(mas, pl  ) --> [blancs].
adjectif(fem, sing) --> [blanche].
adjectif(fem, pl  ) --> [blanches].
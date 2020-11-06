% myLength(?N,+L): vrai si N est le nombre d’éléments de la liste L
% exemple:? -mylength(N,[a,b,c]). 
%            N=3
mylength(N,L).

% myAppend(?L1,?L2,?L3) vrai si L3 est la concaténation des listes L1 et L2
% exemple:? -myAppend([a,b,c],[d,e],L). 
%            L=[a,b,c,d,e]
myAppend(L1, L2, L3). 

% myLast(?E,+L): vrai si E est le dernier élément de L
% exemple:? -myLast(X,[a,b,c]). 
%            X=c
myLast(E, L).

% mySelect(?E,+L1,?L2): vrai si L2 est la liste L1 sans une occurrence de E
% exemple:? -mySelect(b,[a,b,c],L). 
%            L=[a,c]
mySelect(E,L1,L2).

% atoms(+L) : vrai si L est une liste dont les éléments sont des atoms. Indication: utilisez le prédicat prédéfini atom/1
% exemple:? -atoms([a,[1,2],b,c]). 
%            false
atoms(L).

% insert(+X,?L1,?L2): vrai si L1 et L2 sont des listes triées et L2 est la liste L1 augmentée de l'élément X
% exemple:? -insert(5,[2,4,7,12],L).
%            L=[2,4,5,7,12]
insert(X,L1,L2).

% mergeLists(+L1,+L2,?L3) vrai si L1, L2 et L3 sont triées et L3 est la fusion des listes L1 et L2
% exemple:? -mergeLists([2,6,9],[1,8,13,23],L).
%            L=[1,2,6,8,9,12,23]
mergeLists(L1,L2,L3).

% sum_list(+L,?S): vrai si S est la somme des éléments de L
sum_list(L,S).

% reverseRec(+L1,?L2): vrai si L2 est la liste L1 renversée à tous les niveaux (y compris les listes internes)
% exemple:? -reverseRec([a,[b,c],d,e,[f,g,h]],L).
%            L=[[h,g,h],e,d,[c,b],a]
reverseRec(L1,L2).

% myMin(+L,?X): vrai si X est le plus petit élément de L
myMin(L,X).
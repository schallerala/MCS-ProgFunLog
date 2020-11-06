% myLength(?N,+L): vrai si N est le nombre d’éléments de la liste L
% exemple:? -myLength(N,[a,b,c]). 
%            N=3
myLength(0,[]).
myLength(N,[_|Ls]):- myLength(N1, Ls), N is N1 + 1.

% myAppend(?L1,?L2,?L3) vrai si L3 est la concaténation des listes L1 et L2
% exemple:? -myAppend([a,b,c],[d,e],L). 
%            L=[a,b,c,d,e]
%myAppend(L1, L2, L3). 

% myLast(?E,+L): vrai si E est le dernier élément de L
% exemple:? -myLast(X,[a,b,c]). 
%            X=c
myLast(null,[]). % TODO: Not sure -> actually, if the list is empty, there is no predicate and then the evaluation is false (what we want)
myLast(E, [E]).
myLast(E, [_|Ls]):- myLast(E, Ls). % FALSE

% mySelect(?E,+L1,?L2): vrai si L2 est la liste L1 sans une occurrence de E
% exemple:? -mySelect(b,[a,b,c],L). 
%            L=[a,c]
mySelect(E, [L1], L2):- E \== L1, L2 = [L1].
mySelect(E, [L1], L2):- E == L1, L2 = [].
mySelect(E,[L1|Ls1],L2):- mySelect(E,Ls1, L3), E == L1, L2 = L3.
mySelect(E,[L1|Ls1],L2):- mySelect(E,Ls1, L3), E \== L1, L2 = [L1|L3].

% atoms(+L) : vrai si L est une liste dont les éléments sont des atoms. Indication: utilisez le prédicat prédéfini atom/1
% exemple:? -atoms([a,[1,2],b,c]). 
%            false
atoms([L]):- atom(L).
atoms([L|Ls]):- atom(L), atoms(Ls).

% insert(+X,?L1,?L2): vrai si L1 et L2 sont des listes triées et L2 est la liste L1 augmentée de l'élément X
% exemple:? -insert(5,[2,4,7,12],L).
%            L=[2,4,5,7,12]
%insert(X,[l|ls],L2): insert(X,ls).
%insert(X,[l|ls],L2): insert(X,ls).

% mergeLists(+L1,+L2,?L3) vrai si L1, L2 et L3 sont triées et L3 est la fusion des listes L1 et L2
% exemple:? -mergeLists([2,6,9],[1,8,13,23],L).
%            L=[1,2,6,8,9,12,23]
mergeLists([],L2,L3):- L3 = L2.
mergeLists([L1],[],L3):- L3 = L1.
mergeLists([L1|Ls1],[L2|Ls2],L3):- L1 >= L2, mergeLists([L1|Ls1], Ls2, L4), L3 = [L2|L4].
mergeLists([L1|Ls1],[L2|Ls2],L3):- L1 < L2, mergeLists(Ls1, [L2|Ls2], L4), L3 = [L1|L4].

% sum_list(+L,?S): vrai si S est la somme des éléments de L
sum_list([L], L).
sum_list([L|Ls],S):- sum_list(Ls,S1), S is L + S1.

% reverseRec(+L1,?L2): vrai si L2 est la liste L1 renversée à tous les niveaux (y compris les listes internes)
% exemple:? -reverseRec([a,[b,c],d,e,[f,g,h]],L).
%            L=[[h,g,f],e,d,[c,b],a]
% reverseRec(L1,L2).

% myMin(+L,?X): vrai si X est le plus petit élément de L
myMin([L],L).
myMin([L|Ls],X):- myMin(Ls, X1), L >= X1, X is X1.   % L is greater or equal to the actual min value
myMin([L|Ls],X):- myMin(Ls, X1), L < X1, X is L.     % L is smaller than the actual min value 

hanoi(0,_,_,_).
hanoi(N,D,I,G):- 
    N > 0,
    N1 is N-1,
    hanoi(N1,D,G,I),
    writef("dep de %q vers %q \n",[D,I]),
    hanoi(N1,G,I,D).


main:- hanoi(3,p1,p3,p2). % here p2 and p3 are inversed to have exactly the same output as given
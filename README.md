![Screenshot](game-of-life-screenshot.gif?raw=true)

    q life.q -p 5000

[localhost:5000/index.html](http://localhost:5000/index.html)

You can tweak the rendering speed by changing `\t` and the size by changing the values passed to `R` when initializing board.

Compare `life` with these alternate implementations found at [Game of Life in (one line of) q](https://thesweeheng.wordpress.com/2009/02/10/game-of-life-in-one-line-of-q/)

    life:{any(1b;x)&'3 4=\:sum sum f(f:rotate'\:[1 0 -1])x} / by Aaron Davies
    life:{any(1;x)&3 4=\:2 sum/2(1 0 -1 rotate'\:)/x}       / by Attila Vrabecz
    life:{(3=a)|x&4=a:2 sum/2 rotate'\:[1 0 -1]/x}          / by Attila Vrabecz
    life:{3=a-x*4=a:2 sum/2(1 0 -1 rotate'\:)/x}            / by Attila Vrabecz
    life:{0<x+0 1@4-2 sum/2(1 0 -1 rotate'\:)/x}            / by Swee Heng


scale: {[l;n] ,/{+,/{(n; n)#x}'x}'l}

newboard: {x; 8 8 # (8*8)?8}
m: newboard ()
mview: scale[m; 16]

toolbar: scale[,(0 1 2 3 4 5 6 7); 16]

pal: ("red"; "yellow"; "green"; "blue"; "purple"; "brown"; "white"; "gray")

txt: {~,/'+text@`i$x}
score: 0
t:: txt "Score: ",$score
gametxt:: ,0

adjacent: (-1 0; /left
           -1 -1; /up-left
           1 -1; /up-right
           1 0; /right
           0 -1; /up
           1 1; / down-right
           -1 1; /down-left
           0 1) /down

bounded: {7 7&0 0|x}

idxof:{[v;a] *&{v~x}'a}

floodfill: {[m;t;r;v;i]
  i:bounded i;
    $[~(()~idxof[i;v]);0w;
        {x; v:v,,i;
         $[t=r;0N; t=m.i;(m[i]:r; {floodfill[m;t;r;v;i+x]}'adjacent); 0N];
         0N}[0N]
    ]
}

gameover: 0
iswin: {[m] 1=#?,/m}
checkwin: {[m] won:iswin[m]; gameover::won|score>25; gametxt::$[won; txt "You Win! (R)"; score>25; txt "Game Over! (R)"; ,0]}
turn: {[color] oldcolor: m.(0 0); score::score+1; floodfill[m; oldcolor; color; (); 0 0]; mview:: scale[m; 16]; checkwin[m]}
reset: {x; gameover::0;score::0;gametxt::,0;m::newboard();mview:: scale[m; 16]}

ku: {[k] color:k-49; $[k=82;reset ();
                      (~gameover)&(color>-1)&color<8;turn[color]; 0N]}

foo: ((0 0); ("#000";"#F00"); `t)
game: (; pal; `mview)
toolbarb: ((0, h-16); pal; `toolbar)
toolbart: ((4, 4+h-16); ("transparent";"#000"); txt "1 2 3 4 5 6 7 8")
gametxtb: (; ("transparent";"#000"); `gametxt)
draw: {(foo; game; toolbarb; toolbart; gametxtb)}
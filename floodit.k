scale: {[l;n] ,/{+,/{(n; n)#x}'x}'l}


m: (1 2 1 1 2 1 5 7
    3 7 0 2 3 6 7 1
    0 7 1 2 4 4 7 7
    0 2 1 4 5 4 0 2
    6 4 6 0 4 7 4 3
    7 6 7 3 5 1 1 1
    1 5 2 0 3 1 0 0
    4 5 3 4 7 2 2 1)
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

iswin: {[m] 1=#?,/m}
checkwin: {[m] gametxt::$[iswin[m]; txt "You Win!"; score>25; txt "Game Over!"; ,0]}

ku: {color:x-49; oldcolor: m.(0 0); print color; score::score+1; floodfill[m; oldcolor; color; (); 0 0]; mview:: scale[m; 16]; checkwin[m]}

foo: ((0 0); ("#000";"#F00"); `t)
game: (; pal; `mview)
toolbarb: ((0, h-16); pal; `toolbar)
toolbart: ((4, 4+h-16); ("transparent";"#000"); txt "1 2 3 4 5 6 7 8")
gametxtb: (; ("transparent";"#000"); `gametxt)
draw: {(foo; game; toolbarb; toolbart; gametxtb)}
rot: {n: *x; 1_x,n}
rots: {rot\x}
last: {x[(#x)-1]}
bwt: {n: rots[x]; last' n@<n}

bwt: {rot: {1_x,*x}; {x[(#x)-1]}' {x@<x}[rot\x]}

{{x[(#x)-1]}'{x@<x}[{1_x,*x}\x]}


/ last: {*|x}
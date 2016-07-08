/ Compress some bytes using Huffman coding

histogram: {#:'=x}

values: {x[!x]} / values of dict
init: {((#x)-1)#x} / everything but last
insert: { (x#y), (,z), x_y } / insert z at index x in list y

/ construct a priority queue of lists, sorted by the second element of the pairs
priqueue: {x@<{x[1]}'x}

/ insert y into the priority queue x
priqueueinsert: {idx: *&y[1]<{x[1]}' x; idx: $[(idx~());#x;idx]; insert[idx; x; y]}

/ test data
test: "aaaaaaaaaaaaaaabbbbbbbccccccddddddeeeee"
testfreqs: histogram test
freqpairs: +(values testfreqs; !testfreqs)

leaves: {{(`l; x[0]; x[1])}' x}
node: {(`n; (x[1]+y[1]); x; y)}

/ priority queue of leaf nodes
pq: priqueue leaves freqpairs

/ build huffman tree

/ while there is more than one node, construct the tree bottom up by making a new node with the two first least probable nodes

iter: {
    n: node[x[0]; x[1]];
    priqueueinsert[2_x; n]
}

build: { {(#x)>1} iter/ x }

hufftree: *build pq

/ build the codes from the huffman tree, following each path and noting the leaf value
codes: [] / codebook
buildcodes: { [tree;path]
    $[`l~*tree; codes:: codes,((,tree[2])!,path);
      / not a leaf, must be a node
      buildcodes[tree[2]; path,0];
      buildcodes[tree[3]; path,1]]
}

buildcodes[hufftree; ()]

encode: {,/codes[x]} / get huffman encoded bits

/ decode list of bits encoded from the huffman tree
/ traverse the tree using the bit markers until we hit a leaf
/ return a pair, the decoded char and the rest of the bitstream
decodech: {[s]
    t::hufftree; n::0;
    rst: {`n~*t} {n::n+1; t::t[2+*x]; 1_x}/ s
    (t[2]; rst)
}

/ decode full bitstring
decode: {[s]
    xs:: ();
    {~x~()} {c:decodech x; xs::xs,*c; c[1]}/ s
    xs
}

byteencode: {(8#2)/'0N 8#x} / encode bitstream to set of bytes

/ test the encoding/decoding and get a compression ratio
ratio: (#byteencode encode test)%#test
ratio

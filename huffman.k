/ A somewhat functional-style Huffman codebook generator

histogram: {#:'=x}

values: {x[!x]} / values of dict
init: {((#x)-1)#x} / everything but last

/ insert z at index x in list y
insert: { (x#y), (,z), x_y }

/ construct a priority queue of lists, sorted by the second element of the pairs
priqueue: {x@<{x[1]}'x}

/ insert y into the priority queue x
priqueueinsert: {idx: *&y[1]<{x[1]}' x; idx: $[(idx~());#x;idx]; insert[idx; x; y]}

/ test data
test: "aaaaaaaaaaaaaaabbbbbbbccccccddddddeeeee"
testfreqs: histogram test
freqpairs: +(values testfreqs; !testfreqs)

leaves: {(`l; x[0]; x[1])}' freqpairs
node: {(`n; (x[1]+y[1]); x; y)}

/ priority queue of leaf nodes
pq: priqueue leaves

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
codes
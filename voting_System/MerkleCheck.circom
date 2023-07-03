
include https://github.com/demis1997/circomlib/tree/master/circuits;
template MerkleCheck(depth) {
    signal input root;
    signal private input leaf;
    signal private input[depth] path;
    signal private input[depth] pathIndex;

    signal intermediate rootComputed;

    rootComputed <== leaf;

    for (var i = 0; i < depth; i++) {
        component hash = Pedersen(512); // 256 bits for each child
        rootComputed <== hash.in[0];
        path[i] <== hash.in[1];

        signal computed;
        computed <== hash.out;

        rootComputed <== (pathIndex[i] === 0) ? computed : path[i];
    }

    signal output valid;
    valid <== (root === rootComputed);
}

component main = MerkleCheck(256);

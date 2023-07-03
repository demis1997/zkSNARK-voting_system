include "MerkleCheck.circom";
include https://github.com/demis1997/circomlib/tree/master/circuits;
template IsRegistered() {
    signal private input voterID;
    signal private input[256] merkleProof; // Assume 256 for a binary tree depth
    signal input merkleRoot;

    // Validate the Merkle proof
    component merkleCheck = MerkleCheck(256);
    voterID <== merkleCheck.leaf;
    merkleRoot <== merkleCheck.root;
    for (var i = 0; i < 256; i++) {
        merkleProof[i] <== merkleCheck.path[i];
    }

    signal output valid;
    valid <== merkleCheck.valid;
}

component main = IsRegistered();

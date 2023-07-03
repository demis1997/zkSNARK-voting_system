include "HashCheck.circom";
include "MerkleCheck.circom";
include https://github.com/demis1997/circomlib/tree/master/circuits;

template HasNotVotedBefore() {
    signal private input nonce;
    signal input hashedNonce;
    signal private input[256] merkleProof; // Assume 256 for a binary tree depth
    signal input merkleRoot;

    // Verify the nonce hash
    component hashCheck = HashCheck();
    nonce <== hashCheck.preimage;
    hashedNonce <== hashCheck.image;

    // Validate the Merkle proof
    component merkleCheck = MerkleCheck(256);
    hashedNonce <== merkleCheck.leaf;
    merkleRoot <== merkleCheck.root;
    for (var i = 0; i < 256; i++) {
        merkleProof[i] <== merkleCheck.path[i];
    }

    signal output valid;
    valid <== hashCheck.valid * (1 - merkleCheck.valid); // valid if hashCheck.valid == 1 and merkleCheck.valid == 0
}

component main = HasNotVotedBefore();

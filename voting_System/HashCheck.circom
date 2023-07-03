
include https://github.com/demis1997/circomlib/tree/master/circuits;

template HashCheck() {
    signal private input preimage;
    signal output image;

    component hash = Pedersen(256);
    preimage <== hash.in[0];
    image <== hash.out;
}

component main = HashCheck();

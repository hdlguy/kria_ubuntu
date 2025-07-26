#include "ap_int.h"
#include <ap_fixed.h>
#include <stdio.h>

ap_uint<8> hls_tpg ();

int main()
{
    ap_uint<8> tval=1;

    int N = 1000;

    int errors=0;
    ap_uint<8> rval;
    for (int i=0; i<N; i++) {
        rval = hls_tpg();
        if (tval != rval) errors++;
        tval++;
    }
    printf("\n*** N=%d, errors = %d\n\n", N, errors);

    return(errors);

}
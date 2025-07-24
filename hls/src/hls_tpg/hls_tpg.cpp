#include "ap_int.h"
#include <ap_fixed.h>

ap_uint<8> hls_tpg ()
{
    static ap_uint<8> dval;

    dval++;

    return(dval);

}
#include "ap_int.h"
#include <ap_fixed.h>

ap_uint<8> hls_tpg (uint32_t* wval, rval)
{
    static uint32_t dval[16];

    dval = wval;

    rval = dval;

    return(0);

}

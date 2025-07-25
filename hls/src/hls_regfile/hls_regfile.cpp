#include "ap_int.h"
#include <ap_fixed.h>
#include <stdint.h>

void hls_regfile ( uint32_t wval[16], uint32_t rval[16])
{
#pragma HLS INTERFACE mode=s_axilite port=wval bundle=ctl_bus
#pragma HLS INTERFACE mode=s_axilite port=rval bundle=ctl_bus


}

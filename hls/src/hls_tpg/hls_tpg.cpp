#include "ap_int.h"
#include <ap_fixed.h>
#include <stdint.h>
#include "ap_axi_sdata.h"
#include "hls_stream.h"

#define DWIDTH 32
#define L 10

typedef ap_axiu<DWIDTH, 1, 1, 1> line_pkt;


void hls_tpg (ap_uint<32> wval[16], ap_uint<32> rval[16], hls::stream<line_pkt> &dout)
{
#pragma HLS INTERFACE mode=s_axilite port=wval      bundle=control
#pragma HLS INTERFACE mode=s_axilite port=rval      bundle=control
#pragma HLS INTERFACE mode=s_axilite port=return    bundle=control
#pragma HLS INTERFACE mode=axis port=dout

    line_pkt t_out;

    for (int i=0; i<L; i++) {
        t_out.data = i;
        t_out.keep = -1; //Enabling all bytes
        if (i==L-1) {
            t_out.last = 1;
        } else {
            t_out.last = 0;
        }
    }
    dout.write(t_out);

}

#include "ap_int.h"
#include <ap_fixed.h>
#include <stdint.h>
#include "ap_axi_sdata.h"
#include "hls_stream.h"

#define DWIDTH 32

typedef ap_axiu<DWIDTH, 1, 1, 1> line_pkt;


void hls_tpg (
    ap_uint<32> height,     // number of lines per video frame
    ap_uint<32> width,      // number of pixels per line of video
    hls::stream<line_pkt> &dout)
{
#pragma HLS INTERFACE mode=s_axilite port=height      bundle=control
#pragma HLS INTERFACE mode=s_axilite port=width      bundle=control
#pragma HLS INTERFACE mode=s_axilite port=return    bundle=control
#pragma HLS INTERFACE mode=axis port=dout

    line_pkt t_out;

    for (int j=0; j<height; j++) {
        for (int i=0; i<width; i++) {

            t_out.data = i;
            t_out.keep = -1; //Enabling all bytes

            // indicate start of frame
            if ((i==0) && (j==0)) {
                t_out.user = 1;
            } else {
                t_out.user = 0;
            }
            // indicate in of line
            if (i==(width-1)) {
                t_out.last = 1;
            } else {
                t_out.last = 0;
            }

            dout.write(t_out);
        }
    }

}

// hls_tpg.cpp - Video Test Pattern Generator
#include "ap_int.h"
#include <ap_fixed.h>
#include <stdint.h>
#include "ap_axi_sdata.h"
#include "hls_stream.h"

#define DWIDTH 24

typedef ap_axiu<DWIDTH, 1, 1, 1> line_pkt;


void hls_tpg (
    // axilite memory mapped registers
    ap_uint<12> height,     // number of lines per video frame
    ap_uint<12> width,      // number of pixels per line of video
    ap_uint<12> xhair_row,  // crosshair position
    ap_uint<12> xhair_col,  // crosshair position
    // streaming output
    hls::stream<line_pkt> &dout)
{
#pragma HLS INTERFACE mode=s_axilite port=height    bundle=control
#pragma HLS INTERFACE mode=s_axilite port=width     bundle=control
#pragma HLS INTERFACE mode=s_axilite port=xhair_row bundle=control
#pragma HLS INTERFACE mode=s_axilite port=xhair_col bundle=control
#pragma HLS INTERFACE mode=s_axilite port=return    bundle=control
#pragma HLS INTERFACE mode=axis port=dout

    line_pkt t_out;

    static uint32_t fcount;
    for (uint32_t j=0; j<height; j++) { // loop over the lines
        for (uint32_t i=0; i<width; i++) { // loop over the pixels

            //Enable all bytes
            t_out.keep = -1; 

            // calculate the pixel value
            if ((i==xhair_col) || (j==xhair_row)) {
                t_out.data = 0xffffff;
            } else {
                t_out.data = 0x000000;
                t_out.data |= (0xff&fcount) << 16;
                t_out.data |= (0xff&j) << 8;
                t_out.data |= (0xff&i) << 0;
            }

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
    fcount++;

}

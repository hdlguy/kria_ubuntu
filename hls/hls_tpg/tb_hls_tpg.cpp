#include "ap_int.h"
#include <ap_fixed.h>
#include <stdio.h>
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
    hls::stream<line_pkt> &dout // output (pass by reference)
);

int main()
{

    ap_uint<12> height = 10;
    ap_uint<12> width  = 20;
    ap_uint<12> xhair_row = height/2;
    ap_uint<12> xhair_col = width/2;
    hls::stream<line_pkt> dout;

    hls_tpg(height, width, xhair_row, xhair_col, dout);

    //std::cout << dout << "\n";

    int errors = 0;
    return(errors);

}

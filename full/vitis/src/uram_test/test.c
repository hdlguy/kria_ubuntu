
#include <stdio.h>
#include <stdlib.h>
#include "xil_printf.h"
#include "xparameters.h"
#include "fpga.h"

int main()
{

//    uint32_t* regptr = (uint32_t *) XPAR_REGFILE_CTL_BASEADDR;
//    uint32_t* ramptr = (uint32_t *) XPAR_AXI_BRAM_CTRL_0_BASEADDR;
//    uint32_t ramsize = (uint32_t)XPAR_AXI_BRAM_CTRL_0_HIGHADDR - (uint32_t)XPAR_AXI_BRAM_CTRL_0_BASEADDR + 1;

	uint32_t* regptr = (uint32_t *) XPAR_REGFILE_CTL_S_AXI_BASEADDR;
    uint32_t* ramptr = (uint32_t *) XPAR_AXI_BRAM_CTRL_0_S_AXI_BASEADDR;
    uint32_t ramsize = (uint32_t)XPAR_AXI_BRAM_CTRL_0_S_AXI_HIGHADDR - (uint32_t)XPAR_AXI_BRAM_CTRL_0_S_AXI_BASEADDR + 1;


    xil_printf("ramsize = 0x%08x, ramptr = %p\n\r", ramsize, ramptr);
    

    xil_printf("Hello World\n\r");
    uint32_t whilecount=0;
    while(1) {

//        uint32_t version = ramptr[FPGA_VERSION];
//        uint32_t id      = ramptr[FPGA_ID];
        uint32_t version = regptr[FPGA_VERSION];
        uint32_t id      = regptr[FPGA_ID];
        xil_printf("%08u: FPGA_VERSION = 0x%08x, FPGA_ID = 0x%08x\n\r", whilecount, version, id);


        // fill ram with random numbers
        srand(whilecount);
        for (uint32_t i=0; i<ramsize/4; i++){
            ramptr[i] = rand();
        }
        

        // check ram contents
        int errors = 0;
        srand(whilecount);
        for (uint32_t i=0; i<ramsize/4; i++){
            uint32_t rval = rand();
            if (rval != ramptr[i]) {
                errors++;
            }
        }
        xil_printf("%08u: ram errors = %d\n\r", whilecount, errors);

        
        for(int i=0; i<50000000; i++); // delay
        whilecount++;
    }

    return(0);
    
}


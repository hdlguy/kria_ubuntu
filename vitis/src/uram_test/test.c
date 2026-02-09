#include <stdlib.h>
#include "xil_printf.h"
#include "xparameters.h"
#include "fpga.h"


int main()
{

    xil_printf("Hello World\n\r");
    
    // uint32_t *regptr = (uint32_t *)XPAR_M00_AXI_BASEADDR;
    uint32_t *regptr = (uint32_t *)XPAR_AXI_REGFILE_CTRL_BASEADDR;
    uint32_t *ramptr = (uint32_t *)XPAR_AXI_BRAM_CTRL_0_BASEADDR;
    uint32_t ramsize = XPAR_AXI_BRAM_CTRL_0_HIGHADDR - XPAR_AXI_BRAM_CTRL_0_BASEADDR +1;
    

    xil_printf("regptr = %p\n\r", regptr);
    
    uint32_t whilecount=0, errors;
	while(1){

        xil_printf("%08d: FPGA_ID = 0x%08x, FPGA_VERSION = 0x%08x\n\r", whilecount, regptr[FPGA_ID], regptr[FPGA_VERSION]);


        // test uram memory
        srand(whilecount);
        for (uint32_t i=0; i<ramsize/4; i++) ramptr[i] = rand();
        srand(whilecount);
        errors = 0;
        for (uint32_t i=0; i<ramsize/4; i++) {
            if (ramptr[i] != (uint32_t)rand()) errors++;
        }
        xil_printf("uram errors = %d\n\r", errors);


        for(int i=0; i<100000000; i++);
        whilecount++;
        
    }
    
    return 0;
}

#include <stdio.h>
#include <stdlib.h>
#include "platform.h"
#include "xil_printf.h"
#include "xparameters.h"

#define ULTRARAM_SIZE 	(XPAR_BRAM_0_HIGHADDR - XPAR_BRAM_0_BASEADDR + 1)
#define TESTBLOCK_SIZE 	(ULTRARAM_SIZE/32)

uint32_t write_data[TESTBLOCK_SIZE];

int main()
{
    init_platform();

    uint32_t *bram_ptr, *ultraram_ptr;
    ultraram_ptr = (uint32_t *) XPAR_BRAM_0_BASEADDR;

    int errors;
    
    xil_printf("ULTRARAM_SIZE = 0x%08x, ultraram_ptr = %p\n\r", ULTRARAM_SIZE, ultraram_ptr);

    xil_printf("Hello1\n\r");
    for(int j=0; 1; j++) {

    	for(int i=0; i<100000000; i++);
    	printf("j = 0x%08x = %d\n", j, j);

        bram_ptr = ultraram_ptr;
        xil_printf("testing memory at %p\n\r", bram_ptr);
        for (int i=0; i<TESTBLOCK_SIZE; i++) bram_ptr[i] = write_data[i] = rand(); // create and write test data.
        errors = 0;
        for (int i=0; i<TESTBLOCK_SIZE; i++) if (bram_ptr[i] != write_data[i]) errors++; // check results
        xil_printf("errors = %d\n\r", errors);

    }

    cleanup_platform();

    return 0;
}

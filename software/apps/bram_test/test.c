#include <stdio.h>
#include <stdint.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <fcntl.h>
#include <string.h>

#include "mem-io.h"
#include "utils.h"
#include "proto2_hw.h"


int main(int argc,char** argv)
{
    void* pcie_addr;

    uint32_t pcie_bar0_addr=BASE_ADDRESS;
    uint32_t pcie_bar0_size=PROTO_SIZE;

    pcie_addr=phy_addr_2_vir_addr(pcie_bar0_addr,pcie_bar0_size);
    if(pcie_addr==NULL)
    {
       fprintf(stderr,"can't mmap phy_addr 0x%08x with size 0x%08x to viraddr. you must be in root.\n",pcie_bar0_addr,pcie_bar0_size);
       exit(-1);
    }
    //fprintf(stdout,"phy_addr 0x%08x with size 0x%08x to viraddr 0x%p.\n",pcie_bar0_addr,pcie_bar0_size, pcie_addr);

    uint32_t *regbuf = (uint32_t *)(pcie_addr+REGFILE_OFFSET);

    fprintf(stdout,"FPGA_ID=0x%08X, VERSION=0x%08X\n", regbuf[FPGA_ID], regbuf[FPGA_VERSION]);

    //fprintf(stdout,"VERSION: 0x%08X\n",read_reg(pcie_addr,FPGA_VERSION));

    uint32_t *write_data, *read_data, *bram_ptr;
    int errors;

    fprintf(stdout, "testing block ram\n");
    write_data = malloc(TEST_BRAM_SIZE);
    read_data  = malloc(TEST_BRAM_SIZE);
    for (int i=0; i<TEST_BRAM_SIZE/4; i++) write_data[i] = rand(); // create test data.
    bram_ptr = pcie_addr + TEST_BRAM_OFFSET;
    for (int i=0; i<TEST_BRAM_SIZE/4; i++) bram_ptr[i] = write_data[i]; // write bram
    for (int i=0; i<TEST_BRAM_SIZE/4; i++) read_data[i] = bram_ptr[i]; // read bram
    errors = 0;
    for (int i=0; i<TEST_BRAM_SIZE/4; i++) if (read_data[i] != write_data[i]) errors++; // check bram results
    free(write_data);
    free(read_data);
    fprintf(stdout, "block ram errors = %d\n", errors);


    fprintf(stdout, "testing ultraram\n");
    write_data = malloc(ULTRARAM_SIZE);
    read_data  = malloc(ULTRARAM_SIZE);
    for (int i=0; i<ULTRARAM_SIZE/4; i++) write_data[i] = rand(); // create test data.
    bram_ptr = pcie_addr + ULTRARAM_OFFSET;
    for (int i=0; i<ULTRARAM_SIZE/4; i++) bram_ptr[i] = write_data[i]; // write bram
    for (int i=0; i<ULTRARAM_SIZE/4; i++) read_data[i] = bram_ptr[i]; // read bram
    errors = 0;
    for (int i=0; i<ULTRARAM_SIZE/4; i++) if (read_data[i] != write_data[i]) errors++; // check bram results
    free(write_data);
    free(read_data);
    fprintf(stdout, "ultraram errors = %d\n", errors);


    return 0;

}

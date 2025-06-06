#include <stdio.h>
#include <stdint.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <fcntl.h>
#include <string.h>

#include "fpga.h"


int main(int argc,char** argv)
{
    void* base_addr;

    int fd = open("/dev/mem",O_RDWR|O_SYNC);
    if(fd < 0) {
        fprintf(stderr,"Can't open /dev/mem, you must be root!\n");
    } else {
        base_addr=mmap(0,FPGA_SIZE,PROT_READ|PROT_WRITE,MAP_SHARED,fd,FPGA_BASE_ADDRESS);
        if(base_addr == NULL) fprintf(stderr,"Can't mmap\n");
    }

    uint32_t *regptr = base_addr + FPGA_REG_OFFSET;

    fprintf(stdout,"FPGA_ID=0x%08X, VERSION=0x%08X\n", regptr[FPGA_ID], regptr[FPGA_VERSION]);

    uint32_t *write_data, *read_data, *bram_ptr;
    int errors;

    fprintf(stdout, "testing block ram\n");
    write_data = malloc(TEST_BRAM_SIZE);
    read_data  = malloc(TEST_BRAM_SIZE);
    for (int i=0; i<TEST_BRAM_SIZE/4; i++) write_data[i] = rand(); // create test data.
    bram_ptr = base_addr + TEST_BRAM_OFFSET;
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
    bram_ptr = base_addr + ULTRARAM_OFFSET;
    for (int i=0; i<ULTRARAM_SIZE/4; i++) bram_ptr[i] = write_data[i]; // write bram
    for (int i=0; i<ULTRARAM_SIZE/4; i++) read_data[i] = bram_ptr[i]; // read bram
    errors = 0;
    for (int i=0; i<ULTRARAM_SIZE/4; i++) if (read_data[i] != write_data[i]) errors++; // check bram results
    free(write_data);
    free(read_data);
    fprintf(stdout, "ultraram errors = %d\n", errors);

    munmap(base_addr,FPGA_SIZE);

    return 0;

}


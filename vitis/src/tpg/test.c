#include "xil_printf.h"
#include "xparameters.h"
#include "xv_tpg_hw.h"
#include "fpga.h"


int main()
{

    xil_printf("Hello World\n\r");
    
    uint32_t *regptr = (uint32_t *)XPAR_AXI_REGFILE_CTRL_BASEADDR;    
    xil_printf("regptr = %p\n\r", regptr);
    uint32_t *tpgptr = (uint32_t *)XPAR_V_TPG_0_BASEADDR;
    xil_printf("tpgptr = %p\n\r", tpgptr);

    tpgptr[XV_TPG_CTRL_ADDR_AP_CTRL/4] = 0x00;
    tpgptr[XV_TPG_CTRL_ADDR_GIE/4] = 0;
    tpgptr[XV_TPG_CTRL_ADDR_IER/4] = 0;
    tpgptr[XV_TPG_CTRL_ADDR_ISR/4] = 0;
    tpgptr[XV_TPG_CTRL_ADDR_HEIGHT_DATA/4] = 128;
    tpgptr[XV_TPG_CTRL_ADDR_WIDTH_DATA/4] = 70;
    tpgptr[XV_TPG_CTRL_ADDR_BCKGNDID_DATA/4] = 0x0E;
    tpgptr[XV_TPG_CTRL_ADDR_OVRLAYID_DATA/4] = 2;
    tpgptr[XV_TPG_CTRL_ADDR_MASKID_DATA/4] = 0;
    tpgptr[XV_TPG_CTRL_ADDR_MOTIONSPEED_DATA/4] = 3;
    tpgptr[XV_TPG_CTRL_ADDR_COLORFORMAT_DATA/4] = 0;
    tpgptr[XV_TPG_CTRL_ADDR_CROSSHAIRX_DATA/4] = 35;
    tpgptr[XV_TPG_CTRL_ADDR_CROSSHAIRY_DATA/4] = 5;
    tpgptr[XV_TPG_CTRL_ADDR_ZPLATEHORCONTSTART_DATA/4] = 0;
    tpgptr[XV_TPG_CTRL_ADDR_ZPLATEHORCONTDELTA_DATA/4] = 0;

    tpgptr[XV_TPG_CTRL_ADDR_AP_CTRL/4] = 0x81;


    for (int i=0; i<16; i++) xil_printf("reg[%02d] = 0x%08x\n\r", i, tpgptr[i]);

    
    uint32_t whilecount=0;
	while(1){

        xil_printf("%08d: FPGA_ID = 0x%08x, FPGA_VERSION = 0x%08x\n\r", whilecount, regptr[FPGA_ID], regptr[FPGA_VERSION]);

        for(int i=0; i<200000000; i++);
        whilecount++;

    }
    
    return 0;
}

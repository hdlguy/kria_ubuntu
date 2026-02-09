//
module top (
    output  logic       fan_pwm,
    output  logic[8:1]  pmod
);

    localparam logic[31:0] FPGA_VERSION     = 32'h00000101;
    localparam logic[31:0] FPGA_ID          = 32'hDEADBEEF;
    
    logic           axi_aclk;
    logic [0:0]     axi_aresetn;
    
    logic [11:0]    regfile_addr;
    logic           regfile_clk;
    logic [31:0]    regfile_din;
    logic [31:0]    regfile_dout;
    logic           regfile_en;
    logic           regfile_rst;
    logic [3:0]     regfile_we;
  
    system system_i  (
        .axi_aclk           (axi_aclk),
        .axi_aresetn        (axi_aresetn),
        //
        .regfile_addr       (regfile_addr),
        .regfile_clk        (regfile_clk),
        .regfile_din        (regfile_din),
        .regfile_dout       (regfile_dout),
        .regfile_en         (regfile_en),
        .regfile_rst        (regfile_rst),
        .regfile_we         (regfile_we)        
    );
    
    logic[31:0] count=0;
    always_ff @(posedge axi_aclk) begin
        count <= count + 1;
        if ($unsigned(count[12:0]) < 900) fan_pwm <= 0; else fan_pwm <= 1;
    end
        
    assign pmod = count[31:24];
    
    // This register file gives software contol over unit under test (UUT).
    localparam int Nregs = 16;
    logic [Nregs-1:0][31:0] slv_reg, slv_read;

    assign slv_read[0] = FPGA_ID;
    assign slv_read[1] = FPGA_VERSION;

    assign slv_read[2] = slv_reg[2];
    assign slv_read[3] = slv_reg[3];
    assign slv_read[4] = slv_reg[4];
    assign slv_read[5] = slv_reg[5];
    assign slv_read[6] = slv_reg[6];
    assign slv_read[7] = slv_reg[7];
    assign slv_read[8] = slv_reg[8];
    assign slv_read[ 9] = slv_reg[ 9];
    assign slv_read[10] = slv_reg[10];
    assign slv_read[11] = slv_reg[11];
    assign slv_read[12] = slv_reg[12];
    assign slv_read[13] = slv_reg[13];
    assign slv_read[14] = slv_reg[14];
    assign slv_read[15] = slv_reg[15];

    
    mem_regfile #(
       .Naddr(4)  // 16 registers
    ) uut (
        .clk        (regfile_clk),
        .addr       (regfile_addr[5:2]),
        .wr_data    (regfile_din),
        .rd_data    (regfile_dout),
        .en         (regfile_en),
        .reset      (regfile_rst),
        .we         (regfile_we),
        //
        .reg_val    (slv_reg),
        .pul_val    (),
        .read_val   (slv_read)
    );

  
endmodule

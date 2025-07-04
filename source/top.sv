
module top (
    output  logic       fan_pwm,
    output  logic[8:1]  pmod
);

  logic axi_aclk;
  logic axi_aresetn;
  
  logic [11:0]  regfile_addr;
  logic         regfile_clk;
  logic [31:0]  regfile_din;
  logic [31:0]  regfile_dout;
  logic         regfile_en;
  logic         regfile_rst;
  logic [3:0]   regfile_we;

  system system_i (
        //
        .regfile_addr   (regfile_addr),
        .regfile_clk    (regfile_clk),
        .regfile_din    (regfile_din),
        .regfile_dout   (regfile_dout),
        .regfile_en     (regfile_en),
        .regfile_rst    (regfile_rst),
        .regfile_we     (regfile_we),
        //
        .axi_aclk       (axi_aclk),
        .axi_aresetn    (axi_aresetn)
    );
    
    // This register file gives software contol over unit under test (UUT).
    localparam int Nregs = 16;
    logic [Nregs-1:0][31:0] slv_reg, slv_read;

    assign slv_read[0] = 32'hdeadbeef;
    assign slv_read[1] = 32'h76543210;

    assign slv_read[2] = slv_reg[2];

    assign slv_read[Nregs-1:3] = slv_reg[Nregs-1:3];

    mem_regfile #(
       .Naddr(4)  // 16 registers
    ) mem_regfile_inst (
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

    
    logic[31:0] axi_count = -1;
    logic fan_pwm_pre = 0;
    logic[7:0] pmod_led;
    always_ff @(posedge axi_aclk) begin
        axi_count <= axi_count + 1;

        if (axi_count[12:0] < 800) fan_pwm_pre <= 0; else fan_pwm_pre <= 1;
        fan_pwm <= fan_pwm_pre;

        pmod_led <= axi_count[31:24];
    end

    assign pmod[8:1] = pmod_led[7:0];
        
    
    // debug
    top_ila ila_inst (.clk(axi_aclk), .probe0({axi_count[15:0], fan_pwm_pre})); // 17
    
endmodule

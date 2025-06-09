
module top (
    output  logic       fan_pwm
);

  logic [31:0]M00_araddr;
  logic [2:0]M00_arprot;
  logic M00_arready;
  logic M00_arvalid;
  logic [31:0]M00_awaddr;
  logic [2:0]M00_awprot;
  logic M00_awready;
  logic M00_awvalid;
  logic M00_bready;
  logic [1:0]M00_bresp;
  logic M00_bvalid;
  logic [31:0]M00_rdata;
  logic M00_rready;
  logic [1:0]M00_rresp;
  logic M00_rvalid;
  logic [31:0]M00_wdata;
  logic M00_wready;
  logic [3:0]M00_wstrb;
  logic M00_wvalid;  
  logic axi_aclk;
  logic axi_aresetn;

  system system_i (
        .M00_araddr(M00_araddr),
        .M00_arprot(M00_arprot),
        .M00_arready(M00_arready),
        .M00_arvalid(M00_arvalid),
        .M00_awaddr(M00_awaddr),
        .M00_awprot(M00_awprot),
        .M00_awready(M00_awready),
        .M00_awvalid(M00_awvalid),
        .M00_bready(M00_bready),
        .M00_bresp(M00_bresp),
        .M00_bvalid(M00_bvalid),
        .M00_rdata(M00_rdata),
        .M00_rready(M00_rready),
        .M00_rresp(M00_rresp),
        .M00_rvalid(M00_rvalid),
        .M00_wdata(M00_wdata),
        .M00_wready(M00_wready),
        .M00_wstrb(M00_wstrb),
        .M00_wvalid(M00_wvalid),
        .axi_aclk(axi_aclk),
        .axi_aresetn(axi_aresetn)
    );
    
    // This register file gives software contol over unit under test (UUT).
    localparam int Nregs = 16;
    logic [Nregs-1:0][31:0] slv_reg, slv_read;

    assign slv_read[0] = 32'hdeadbeef;
    assign slv_read[1] = 32'h76543210;

    assign slv_read[2] = slv_reg[2];

    assign slv_read[Nregs-1:3] = slv_reg[Nregs-1:3];

    axi_regfile_v1_0_S00_AXI #  (
        .C_S_AXI_DATA_WIDTH(32),
        .C_S_AXI_ADDR_WIDTH(6) // 16 32 bit registers.
    ) axi_regfile_inst (
        // register interface
        .slv_read(slv_read),
        .slv_reg (slv_reg),
        // axi interface
        .S_AXI_ACLK    (axi_aclk),
        .S_AXI_ARESETN (axi_aresetn),
        //
        .S_AXI_ARADDR  (M00_AXI_araddr ),
        .S_AXI_ARPROT  (M00_AXI_arprot ),
        .S_AXI_ARREADY (M00_AXI_arready),
        .S_AXI_ARVALID (M00_AXI_arvalid),
        .S_AXI_AWADDR  (M00_AXI_awaddr ),
        .S_AXI_AWPROT  (M00_AXI_awprot ),
        .S_AXI_AWREADY (M00_AXI_awready),
        .S_AXI_AWVALID (M00_AXI_awvalid),
        .S_AXI_BREADY  (M00_AXI_bready ),
        .S_AXI_BRESP   (M00_AXI_bresp  ),
        .S_AXI_BVALID  (M00_AXI_bvalid ),
        .S_AXI_RDATA   (M00_AXI_rdata  ),
        .S_AXI_RREADY  (M00_AXI_rready ),
        .S_AXI_RRESP   (M00_AXI_rresp  ),
        .S_AXI_RVALID  (M00_AXI_rvalid ),
        .S_AXI_WDATA   (M00_AXI_wdata  ),
        .S_AXI_WREADY  (M00_AXI_wready ),
        .S_AXI_WSTRB   (M00_AXI_wstrb  ),
        .S_AXI_WVALID  (M00_AXI_wvalid )
    );
    
    logic[31:0] axi_count = -1;
    logic fan_pwm_pre = 0;
    always_ff @(posedge axi_aclk) begin
        axi_count <= axi_count - 1;
        fan_pwm_pre <= ~((axi_count[12]) & (axi_count[11]) & (axi_count[10]) & (axi_count[9])); // 1/8 duty factor at 12KHz
        fan_pwm <= fan_pwm_pre;
    end    
    
    // debug
    top_ila ila_inst (.clk(axi_aclk), .probe0({axi_count[15:0], fan_pwm_pre})); // 17
    
endmodule

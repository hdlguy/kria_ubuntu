//
module top (
    output  logic       fan_pwm,
    output  logic[8:1]  pmod
);

    logic pl_clk;
    logic[31:0] count;
    system system_i  (
        .pl_clk(pl_clk),
        .count(count)
    );
    
    always_ff @(pl_clk) begin
        if (count[12:0] < 800) fan_pwm <= 0; else fan_pwm <= 1;
    end
        
    assign pmod = count[31:24];
  
endmodule

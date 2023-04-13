`timescale 1ns / 1ps
module pll_test(
input      sys_clk_p,            //system clock 200Mhz on board
input      sys_clk_n,            //system clock 200Mhz on board
input       rst_n,             //reset ,low active
output      clk_out           //pll clock output 

    );
    
wire        locked;
    
clk_wiz_0 clk_wiz_0_inst
       (
        // Clock out ports
        .clk_out1(),     // output clk_out1
        .clk_out2(),     // output clk_out2
        .clk_out3(),     // output clk_out3
        .clk_out4(clk_out),     // output clk_out4
        // Status and control signals
        .reset(~rst_n), // input reset
        .locked(locked),       // output locked
       // Clock in ports
        .clk_in1_p(sys_clk_p),    // input clk_in1_p
        .clk_in1_n(sys_clk_n));    // input clk_in1_n

endmodule

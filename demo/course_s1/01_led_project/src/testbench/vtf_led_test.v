`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: vtf_led_test
//////////////////////////////////////////////////////////////////////////////////

module vtf_led_test;
// Inputs
reg sys_clk_p;
reg rst_n ;
wire sys_clk_n;
// Outputs
wire led;

// Instantiate the Unit Under Test (UUT)
led uut (
    .sys_clk_p(sys_clk_p),  
    .sys_clk_n(sys_clk_n),     
    .rst_n(rst_n),
    .led(led)
 );

initial 
begin
// Initialize Inputs
    sys_clk_p = 0;
    rst_n = 0;
// Wait for global reset to finish
	#1000;
    rst_n = 1; 
end
//Create clock
always #2.5 sys_clk_p = ~ sys_clk_p;  
assign  sys_clk_n = ~sys_clk_p ;

endmodule 

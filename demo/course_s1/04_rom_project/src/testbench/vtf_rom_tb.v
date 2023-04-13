`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/10/28 17:01:15
// Design Name: 
// Module Name: vtf_rom_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module vtf_rom_tb;
// Inputs
reg sys_clk_p;
wire sys_clk_n;
reg rst_n;


// Instantiate the Unit Under Test (UUT)
rom_test uut (
	.sys_clk_p(sys_clk_p), 		
	.sys_clk_n(sys_clk_n), 	
	.rst_n		(rst_n)
);

initial 
begin
	// Initialize Inputs
	sys_clk_p = 0;
	rst_n = 0;

	// Wait 100 ns for global reset to finish
	#100;
      rst_n = 1;       

 end

always #2.5 sys_clk_p = ~ sys_clk_p;   //5ns一个周期，产生200MHz时钟源

assign sys_clk_n = ~ sys_clk_p;
   
endmodule

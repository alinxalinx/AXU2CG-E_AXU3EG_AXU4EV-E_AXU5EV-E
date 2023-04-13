`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: vtf_pll_test
//////////////////////////////////////////////////////////////////////////////////

module vtf_pll_test;
// Inputs
reg sys_clk_p;
wire sys_clk_n;
reg rst_n;

// Outputs
wire clk_out;

// Instantiate the Unit Under Test (UUT)
pll_test uut (
	.sys_clk_p(sys_clk_p), 		
	.sys_clk_n(sys_clk_n), 		
	.rst_n(rst_n), 
	.clk_out(clk_out)
);

initial begin
	// Initialize Inputs
	sys_clk_p = 0;
	rst_n = 0;

	// Wait 100 ns for global reset to finish
	#100;
      rst_n = 1;      

 end

always #2.5 sys_clk_p = ~ sys_clk_p;   //5nsһ�����ڣ�����200MHzʱ��Դ

assign sys_clk_n = ~ sys_clk_p;
   
endmodule

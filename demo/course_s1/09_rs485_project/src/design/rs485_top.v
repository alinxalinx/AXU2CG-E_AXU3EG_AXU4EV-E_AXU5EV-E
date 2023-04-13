`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/01 13:02:50
// Design Name: 
// Module Name: rs485_top
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


module rs485_top(
	input      					 sys_clk_p,            //system clock 200Mhz postive pin
    input      					 sys_clk_n,            //system clock 200Mhz negetive pin 
    input                        rst_n,        //reset ,low active
	input 						 rs485_rx1,	
	output                       rs485_tx1,
	output                       rs485_de1,
	input 						 rs485_rx2,	
	output                       rs485_tx2,
	output                       rs485_de2
    );

wire sys_clk ;

IBUFDS #(
   .DIFF_TERM("FALSE"),       // Differential Termination
   .IBUF_LOW_PWR("TRUE"),     // Low power="TRUE", Highest performance="FALSE" 
   .IOSTANDARD("DEFAULT")     // Specify the input I/O standard
) IBUFDS_inst (
   .O(sys_clk),  // Buffer output
   .I(sys_clk_p),  // Diff_p buffer input (connect directly to top-level port)
   .IB(sys_clk_n) // Diff_n buffer input (connect directly to top-level port)
);

rs485_test rs485_m0
(
    .sys_clk	(sys_clk),       //system clock 50Mhz on board
    .rst_n		(rst_n	),        //reset ,low active
	.rs485_rx	(rs485_rx1),
	.rs485_tx	(rs485_tx1),
	.rs485_de   (rs485_de1)
);
	
rs485_test rs485_m1
(
    .sys_clk	(sys_clk),       //system clock 50Mhz on board
    .rst_n		(rst_n	),        //reset ,low active
	.rs485_rx	(rs485_rx2),
	.rs485_tx	(rs485_tx2),
	.rs485_de   (rs485_de2)
);
	
endmodule

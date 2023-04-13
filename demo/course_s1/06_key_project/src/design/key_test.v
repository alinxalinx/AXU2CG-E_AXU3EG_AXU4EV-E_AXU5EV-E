//////////////////////////////////////////////////////////////////////////////////
 //  key test                                                                    //
 //                                                                              //
 //  Author: meisq                                                               //
 //          msq@qq.com                                                          //
 //          ALINX(shanghai) Technology Co.,Ltd                                  //
 //          heijin                                                              //
 //     WEB: http://www.alinx.cn/                                                //
 //     BBS: http://www.heijin.org/                                              //
//                                                                              //
//////////////////////////////////////////////////////////////////////////////////
//                                                                              //
// Copyright (c) 2017,ALINX(shanghai) Technology Co.,Ltd                        //
//                    All rights reserved                                       //
//                                                                              //
// This source file may be used and distributed without restriction provided    //
// that this copyright statement is not removed from the file and that any      //
// derivative work contains the original copyright notice and the associated    //
// disclaimer.                                                                  //
//                                                                              //
//////////////////////////////////////////////////////////////////////////////////
                        
//================================================================================
//  Revision History:
 //  Date          By            Revision    Change Description
//--------------------------------------------------------------------------------
//  2017/7/19     meisq          1.0         Original
//*******************************************************************************/
                        
`timescale 1ns / 1ps
module key_test
(
	input      			  sys_clk_p,            //system clock 200Mhz postive pin
    input      			  sys_clk_n,            //system clock 200Mhz negetive pin 
	input            	  key,       //input four key signal,when the keydown,the value is 0
	output           	  led        //LED display ,when the siganl low,LED lighten
);

reg  led_r;           //define the first stage register , generate four D Flip-flop 
reg  led_r1;          //define the second stage register ,generate four D Flip-flop

wire clk ;


IBUFDS IBUFDS_inst (
      .O(clk),   // 1-bit output: Buffer output
      .I(sys_clk_p),   // 1-bit input: Diff_p buffer input (connect directly to top-level port)
      .IB(sys_clk_n)  // 1-bit input: Diff_n buffer input (connect directly to top-level port)
   );

always@(posedge clk)
begin
	led_r <=  ~key;        //first stage latched data
end

always@(posedge clk)
begin
	led_r1 <= led_r;      //second stage latched data
end

assign led = led_r1;

endmodule 

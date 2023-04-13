`timescale 1ns / 1ps

module rom_test(
	input      sys_clk_p,            //system clock 200Mhz postive pin
    input      sys_clk_n,            //system clock 200Mhz negetive pin 
	input rst_n		//复位，低电平有效
    );

wire [7:0] rom_data;	  //ROM读出数据
reg	 [4:0] rom_addr;      //ROM输入地址 

wire sys_clk ;

IBUFDS IBUFDS_inst (
      .O(sys_clk),   // 1-bit output: Buffer output
      .I(sys_clk_p),   // 1-bit input: Diff_p buffer input (connect directly to top-level port)
      .IB(sys_clk_n)  // 1-bit input: Diff_n buffer input (connect directly to top-level port)
   );

//产生ROM地址读取数据
always @ (posedge sys_clk or negedge rst_n)
begin
    if(!rst_n)
        rom_addr <= 10'd0;
    else
        rom_addr <= rom_addr+1'b1;
end        
//实例化ROM
rom_ip rom_ip_inst
(
    .clka   (sys_clk    ),      //inoput clka
    .addra  (rom_addr   ),      //input [4:0] addra
    .douta  (rom_data   )       //output [7:0] douta
);
//实例化逻辑分析仪
ila_0 ila_m0
(
    .clk    (sys_clk),
    .probe0 (rom_addr),
	.probe1 (rom_data)
);

endmodule
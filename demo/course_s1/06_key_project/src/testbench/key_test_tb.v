`timescale 1ns/1ns
module key_test_tb;
reg sys_clk_p;
wire sys_clk_n;
reg[3:0] key;
wire[3:0] led;
initial
begin
	sys_clk_p = 1'b0;
	key = 4'b1111;
	#12  key = 4'b0101;
	#25  key = 4'b1010;
	#8   key[0] = 1'b1;
	#16  key[0] = 1'b0;
	#100
	$stop;
end

always #2.5 sys_clk_p = ~ sys_clk_p;   //5ns一个周期，产生200MHz时钟源

assign sys_clk_n = ~ sys_clk_p;

key_test dut
(
	.sys_clk_p(sys_clk_p), 		
	.sys_clk_n(sys_clk_n), 	
	.key (key),  //4位按键输入，按下是0，弹起是1
	.led (led)   //4位LED显示，0为亮，1为灭
);
endmodule 
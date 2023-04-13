`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module ram_test(
			input      sys_clk_p,            //system clock 200Mhz on board
            input      sys_clk_n,            //system clock 200Mhz on board
			input rst_n	             	//��λ�źţ��͵�ƽ��Ч	
		);

//-----------------------------------------------------------
reg		[8:0]  		w_addr;	   		//RAM PORTAд��ַ
reg		[15:0] 		w_data;	   		//RAM PORTAд����
reg 	      		wea;	    	//RAM PORTAʹ��
reg		[8:0]  		r_addr;	  	 	//RAM PORTB����ַ
wire	[15:0] 		r_data;			//RAM PORTB������


wire clk ;

IBUFDS IBUFDS_inst (
      .O(clk),   // 1-bit output: Buffer output
      .I(sys_clk_p),   // 1-bit input: Diff_p buffer input (connect directly to top-level port)
      .IB(sys_clk_n)  // 1-bit input: Diff_n buffer input (connect directly to top-level port)
   );

//����RAM PORTB����ַ
always @(posedge clk or negedge rst_n)
begin
  if(!rst_n) 
	r_addr <= 9'd0;
  else if (|w_addr)			//w_addrλ�򣬲�����0
    r_addr <= r_addr+1'b1;
  else
	r_addr <= 9'd0;	
end

//����RAM PORTAдʹ���ź�
always@(posedge clk or negedge rst_n)
begin	
  if(!rst_n) 
  	  wea <= 1'b0;
  else 
  begin
     if(&w_addr) 			//w_addr��bitλȫΪ1����д��512�����ݣ�д�����
        wea <= 1'b0;                 
     else               
        wea	<= 1'b1;        //ramдʹ��
  end 
end 

//����RAM PORTAд��ĵ�ַ������
always@(posedge clk or negedge rst_n)
begin	
  if(!rst_n) 
  begin
	  w_addr <= 9'd0;
	  w_data <= 16'd1;
  end
  else 
  begin
     if(wea) 					//ramдʹ����Ч
	 begin        
		if (&w_addr)			//w_addr��bitλȫΪ1����д��512�����ݣ�д�����
		begin
			w_addr <= w_addr ;	//����ַ�����ݵ�ֵ����ס��ֻдһ��RAM
			w_data <= w_data ;
		end
		else
		begin
			w_addr <= w_addr + 1'b1;
			w_data <= w_data + 1'b1;
		end
	 end
  end 
end 

//-----------------------------------------------------------
//ʵ����RAM	
ram_ip ram_ip_inst (
  .clka      (clk          ),     // input clka
  .wea       (wea          ),     // input [0 : 0] wea
  .addra     (w_addr       ),     // input [8 : 0] addra
  .dina      (w_data       ),     // input [15 : 0] dina
  .clkb      (clk          ),     // input clkb
  .addrb     (r_addr       ),     // input [8 : 0] addrb
  .doutb     (r_data       )      // output [15 : 0] doutb
);

//ʵ����ila�߼�������
ila_0 ila_0_inst (
	.clk	(clk	), 
	.probe0	(r_data	), 
	.probe1	(r_addr	) 
);

	
endmodule

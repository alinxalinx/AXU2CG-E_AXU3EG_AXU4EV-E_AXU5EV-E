//////////////////////////////////////////////////////////////////////////////////
//   The external memory test module writes the address as data and compares    //
//   it to the address                                                          //
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
//2017/6/28                    1.0          Original
//*******************************************************************************/
module mem_test
#(
	parameter MEM_DATA_BITS          = 32,  //external memory user interface data width
	parameter ADDR_BITS              = 23,  //external memory user interface address width
	parameter BUSRT_BITS             = 10,  //external memory user interface burst width
	parameter BURST_SIZE             = 128  //burst size
)
(
	input                            rst,
	input                            mem_clk,                             // external memory controller user interface clock
	(*mark_debug = "true"*)output reg                       rd_burst_req,                        // to external memory controller,send out a burst read request
	(*mark_debug = "true"*)output reg                       wr_burst_req,                        // to external memory controller,send out a burst write request
	(*mark_debug = "true"*)output reg[BUSRT_BITS - 1:0]     rd_burst_len,                        // to external memory controller,data length of the burst read request, not bytes
	(*mark_debug = "true"*)output reg[BUSRT_BITS - 1:0]     wr_burst_len,                        // to external memory controller,data length of the burst write request, not bytes
	(*mark_debug = "true"*)output reg[ADDR_BITS - 1:0]      rd_burst_addr,                       // to external memory controller,base address of the burst read request 
	(*mark_debug = "true"*)output reg[ADDR_BITS - 1:0]      wr_burst_addr,                       // to external memory controller,base address of the burst write request 
	(*mark_debug = "true"*)input                            rd_burst_data_valid,                 // from external memory controller,read data valid 
	(*mark_debug = "true"*)input                            wr_burst_data_req,                   // from external memory controller,write data request ,before data 1 clock
	(*mark_debug = "true"*)input[MEM_DATA_BITS - 1:0]       rd_burst_data,                       // from external memory controller,read request data
	(*mark_debug = "true"*)output reg[MEM_DATA_BITS - 1:0]  wr_burst_data,                       // to external memory controller,write data
	(*mark_debug = "true"*)input                            rd_burst_finish,                     // from external memory controller,burst read finish
	(*mark_debug = "true"*)input                            wr_burst_finish,                     // from external memory controller,burst write finish
	(*mark_debug = "true"*)output reg                       error,                               // test data error
	output reg                       heartbeat
);
//state machine code
localparam IDLE                      = 3'd0;
localparam MEM_READ                  = 3'd1;  //read state
localparam MEM_WRITE                 = 3'd2;  //write state

localparam ONE                       = 512'd1; //512 bit '1' , ONE[n-1:0] for n bit '1'
localparam ZERO                      = 512'd0; //512 bit '0'
(*mark_debug = "true"*)reg[2:0]      state;
(*mark_debug = "true"*)reg[BUSRT_BITS - 1:0]                wr_cnt;   //write data counter for once burst 
(*mark_debug = "true"*)reg[BUSRT_BITS - 1:0]                rd_cnt;   //read data counter for once burst
reg[31:0]                            heartbeat_cnt;   //heartbeat counter
(*mark_debug = "true"*)reg[15:0]     test_cnt;
wire[511:0]                          test_cnt_512b;
wire[511:0]                          wr_burst_addr_512b;
wire[511:0]                          rd_burst_addr_512b;
reg[ADDR_BITS - 1:0]                 next_wr_burst_addr; //next burst write address
reg[ADDR_BITS - 1:0]                 next_rd_burst_addr; //next burst read address
(*mark_debug = "true"*)reg[15:0]     wr_data_pre_add;
(*mark_debug = "true"*)reg[15:0]     rd_data_pre_add;
wire[511:0] next_wr_burst_data;
assign next_wr_burst_data       = {(MEM_DATA_BITS/16){wr_data_pre_add}};// next_wr_burst_data = wr_burst_addr + wr_cnt
wire[511:0] expect_read_data;
assign  expect_read_data         = {(MEM_DATA_BITS/16){rd_data_pre_add}};;// next_wr_burst_data = rd_burst_addr + rd_cnt
assign  test_cnt_512b = {496'd0,test_cnt};
assign  wr_burst_addr_512b = {ZERO[511 - ADDR_BITS : 0],wr_burst_addr};
assign  rd_burst_addr_512b = {ZERO[511 - ADDR_BITS : 0],rd_burst_addr};
always@(posedge mem_clk or posedge rst)
begin
	if(rst == 1'b1)
		error <= 1'b0;
	else if(state == MEM_READ && rd_burst_data_valid == 1'b1 && rd_burst_data != expect_read_data[MEM_DATA_BITS - 1:0])
		//Read the data and compare
		error <= 1'b1;
end
//generate heartbeat signal
always@(posedge mem_clk or posedge rst)
begin
	if(rst == 1'b1)
		heartbeat_cnt  <= 32'd0;
	else if(rd_burst_data_valid == 1'b1 || wr_burst_data_req == 1'b1)
		heartbeat_cnt  <=  (heartbeat_cnt > 32'd99_999_999) ? 32'd0 : heartbeat_cnt + 32'd1;
end
always@(posedge mem_clk or posedge rst)
begin
	if(rst == 1'b1)
		heartbeat  <= 1'b0;
	else if(heartbeat_cnt > 32'd99_999_999)
		heartbeat <= ~heartbeat;
end
always@(*)
begin
	wr_data_pre_add <= wr_burst_addr_512b[15:0] + test_cnt + {8'd0,wr_cnt[7:0]};
end

always@(*)
begin
	rd_data_pre_add <= rd_burst_addr_512b[15:0] + test_cnt + {8'd0,rd_cnt[7:0]};
end

//wr_burst_data = write address
always@(posedge mem_clk or posedge rst)
begin
	if(rst == 1'b1)
		wr_burst_data <= ZERO[MEM_DATA_BITS - 1:0]; //wr_burst_data <= 0;
	else if(wr_burst_data_req == 1'b1)
		wr_burst_data <= next_wr_burst_data[MEM_DATA_BITS - 1:0];
end
//in order to avoid combinational logic is too complex,so preparing data ahead of time
always@(posedge mem_clk or posedge rst)
begin
	if(rst == 1'b1)
		next_wr_burst_addr <= ZERO[ADDR_BITS - 1:0]; //next_wr_burst_addr <= 0;
	else
		next_wr_burst_addr <= wr_burst_addr + BURST_SIZE[ADDR_BITS - 1:0];
end

always@(posedge mem_clk or posedge rst)
begin
	if(rst == 1'b1)
		next_rd_burst_addr <= ZERO[ADDR_BITS - 1:0]; //next_wr_burst_addr <= 0;
	else
		next_rd_burst_addr <= rd_burst_addr + BURST_SIZE[ADDR_BITS - 1:0];
end

//write data counter 
always@(posedge mem_clk or posedge rst)
begin
	if(rst == 1'b1)
		wr_cnt <= ZERO[BUSRT_BITS - 1:0]; // wr_cnt <= 0;
	else if(state == MEM_WRITE)
		if(wr_burst_data_req == 1'b1)
				wr_cnt <= wr_cnt + ONE[BUSRT_BITS - 1:0];//wr_cnt <= wr_cnt + 1;
		else if(wr_burst_finish == 1'b1)
			wr_cnt <= ZERO[BUSRT_BITS - 1:0];// wr_cnt <= 0;
end
//read data counter 
always@(posedge mem_clk or posedge rst)
begin
	if(rst == 1'b1)
	begin
		rd_cnt <= ZERO[BUSRT_BITS - 1:0]; // rd_cnt <= 0;
	end
	else if(state == MEM_READ)
	begin
		if(rd_burst_data_valid)
			begin
				rd_cnt <= rd_cnt + ONE[BUSRT_BITS - 1:0];//rd_cnt <= rd_cnt + 1;
			end
		else if(rd_burst_finish)
			rd_cnt <= ZERO[BUSRT_BITS - 1:0];// rd_cnt <= 0;
	end
	else
		rd_cnt <= ZERO[BUSRT_BITS - 1:0];// rd_cnt <= 0;
end

always@(posedge mem_clk or posedge rst)
begin
	if(rst == 1'b1)
	begin
		state <= IDLE;
		wr_burst_req <= 1'b0;
		rd_burst_req <= 1'b0;
		rd_burst_len <= BURST_SIZE[BUSRT_BITS - 1:0];
		wr_burst_len <= BURST_SIZE[BUSRT_BITS - 1:0];
		rd_burst_addr <= ZERO[ADDR_BITS - 1:0]; // rd_burst_addr <= 0;
		wr_burst_addr <= ZERO[ADDR_BITS - 1:0]; // wr_burst_addr <= 0
		test_cnt <= 16'd0;
	end
	else
	begin
		case(state)
			IDLE:
			begin
				state <= MEM_WRITE;
				wr_burst_req <= 1'b1;
				wr_burst_len <= BURST_SIZE[BUSRT_BITS - 1:0];
				test_cnt <= 16'd0;
			end
			MEM_WRITE:
			begin
		
				if(wr_burst_finish == 1'b1)
				begin
					wr_burst_addr <= next_wr_burst_addr;
					if(next_wr_burst_addr == ZERO[ADDR_BITS - 1:0])//address reached maximum
					//if(next_wr_burst_addr == wr_burst_addr + BURST_SIZE[BUSRT_BITS - 1:0])					
					begin
						//goto read state
						state <= MEM_READ;
						wr_burst_req <= 1'b0;
						rd_burst_req <= 1'b1;
						rd_burst_addr <= ZERO[ADDR_BITS - 1:0];
                       // rd_burst_addr <= wr_burst_addr ;
					end
					else
					begin
						wr_burst_req <= 1'b1;
					end
					rd_burst_len <= BURST_SIZE[BUSRT_BITS - 1:0];
				end
			end
			
			MEM_READ:
			begin
				if(rd_burst_data_valid == 1'b1)
					rd_burst_req <= 1'b0;
					
				if(rd_burst_finish == 1'b1)
				begin
					rd_burst_addr <= rd_burst_addr + BURST_SIZE[ADDR_BITS - 1:0];
					if(next_rd_burst_addr == ZERO[ADDR_BITS - 1:0])//address reached maximum
					//if(next_rd_burst_addr == rd_burst_addr + BURST_SIZE[ADDR_BITS - 1:0])
					begin
						//goto write state
						state <= MEM_WRITE;
						test_cnt <= test_cnt + 16'd1;
						wr_burst_req <= 1'b1;
						wr_burst_len <= BURST_SIZE[BUSRT_BITS - 1:0];
						wr_burst_addr <= ZERO[BUSRT_BITS - 1:0];
					end
					else
					begin
						rd_burst_req <= 1'b1;
						rd_burst_len <= BURST_SIZE[BUSRT_BITS - 1:0];
					end
				end
			end
			default:
				state <= IDLE;
		endcase
	end
end

endmodule
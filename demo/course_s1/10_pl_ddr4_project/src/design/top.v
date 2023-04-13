`timescale 1ps/1ps

module top
(
	output                             c0_ddr4_act_n   ,
	output [16:0]                      c0_ddr4_adr     ,
	output [1:0]                       c0_ddr4_ba      ,
	output [0:0]                       c0_ddr4_bg      ,
	output [0:0]                       c0_ddr4_cke     ,
	output [0:0]                       c0_ddr4_odt     ,
	output [0:0]                       c0_ddr4_cs_n    ,
	output [0:0]                       c0_ddr4_ck_t    ,
	output [0:0]                       c0_ddr4_ck_c    ,
	output                             c0_ddr4_reset_n ,
	inout [1:0]                       c0_ddr4_dm_dbi_n,
	inout [15:0]                      c0_ddr4_dq      ,
	inout [1:0]                       c0_ddr4_dqs_c   ,
	inout [1:0]                       c0_ddr4_dqs_t   ,               
	
	//Differential system clocks
	input                              c0_sys_clk_p,
	input                              c0_sys_clk_n,
	//output[2:0]                        led,
	input                              sys_rst
   );

localparam nCK_PER_CLK                 = 4;
localparam ADDR_WIDTH                  = 28;
localparam MEM_IF_ADDR_BITS            = 29;
localparam PAYLOAD_WIDTH               = 16;
localparam APP_DATA_WIDTH              = 2 * nCK_PER_CLK * PAYLOAD_WIDTH;
localparam APP_MASK_WIDTH              = APP_DATA_WIDTH / 8;
// Wire declarations
wire [MEM_IF_ADDR_BITS-1:0]            app_addr;
wire [2:0]                             app_cmd;
wire                                   app_en;
wire                                   app_rdy;
wire [APP_DATA_WIDTH-1:0]              app_rd_data;
wire                                   app_rd_data_end;
wire                                   app_rd_data_valid;
wire [APP_DATA_WIDTH-1:0]              app_wdf_data;
wire                                   app_wdf_end;
wire [APP_MASK_WIDTH-1:0]              app_wdf_mask;
wire                                   app_wdf_rdy;
wire                                   app_wdf_wren;
wire                                   mem_clk;
wire                                   rst;
(* MARK_DEBUG="true" *)wire                                   init_calib_complete;
(* MARK_DEBUG="true" *)wire                                   error;
wire                                   heartbeat;

(* MARK_DEBUG="true" *)wire                                   wr_burst_data_req;
(* MARK_DEBUG="true" *)wire                                   wr_burst_finish;
(* MARK_DEBUG="true" *)wire                                   rd_burst_finish;
(* MARK_DEBUG="true" *)wire                                   rd_burst_req;
(* MARK_DEBUG="true" *)wire                                   wr_burst_req;
(* MARK_DEBUG="true" *)wire[9:0]                              rd_burst_len;
(* MARK_DEBUG="true" *)wire[9:0]                              wr_burst_len;
(* MARK_DEBUG="true" *)wire[ADDR_WIDTH - 1:0]                 rd_burst_addr;
(* MARK_DEBUG="true" *)wire[ADDR_WIDTH - 1:0]                 wr_burst_addr;
(* MARK_DEBUG="true" *)wire                                   rd_burst_data_valid;
(* MARK_DEBUG="true" *)wire[APP_DATA_WIDTH - 1 : 0]           rd_burst_data;
(* MARK_DEBUG="true" *)wire[APP_DATA_WIDTH - 1 : 0]           wr_burst_data;








ddr4 u_ddr4
   (
   .sys_rst                    (~sys_rst                  ),
   .c0_sys_clk_p               (c0_sys_clk_p              ),
   .c0_sys_clk_n               (c0_sys_clk_n              ),
   .c0_ddr4_act_n              (c0_ddr4_act_n             ),
   .c0_ddr4_adr                (c0_ddr4_adr               ),
   .c0_ddr4_ba                 (c0_ddr4_ba                ),
   .c0_ddr4_bg                 (c0_ddr4_bg                ),
   .c0_ddr4_cke                (c0_ddr4_cke               ),
   .c0_ddr4_odt                (c0_ddr4_odt               ),
   .c0_ddr4_cs_n               (c0_ddr4_cs_n              ),
   .c0_ddr4_ck_t               (c0_ddr4_ck_t              ),
   .c0_ddr4_ck_c               (c0_ddr4_ck_c              ),
   .c0_ddr4_reset_n            (c0_ddr4_reset_n           ),
   .c0_ddr4_dm_dbi_n           (c0_ddr4_dm_dbi_n          ),
   .c0_ddr4_dq                 (c0_ddr4_dq                ),
   .c0_ddr4_dqs_c              (c0_ddr4_dqs_c             ),
   .c0_ddr4_dqs_t              (c0_ddr4_dqs_t             ),
   .c0_init_calib_complete     (init_calib_complete       ),
   .c0_ddr4_ui_clk             (mem_clk                   ),
   .c0_ddr4_ui_clk_sync_rst    (rst                       ),
   .dbg_clk                    (                          ),
   .c0_ddr4_app_addr           (app_addr                  ),
   .c0_ddr4_app_cmd            (app_cmd                   ),
   .c0_ddr4_app_en             (app_en                    ),
   .c0_ddr4_app_hi_pri         (1'b0                      ),
   .c0_ddr4_app_wdf_data       (app_wdf_data              ),
   .c0_ddr4_app_wdf_end        (app_wdf_end               ),
   .c0_ddr4_app_wdf_mask       (app_wdf_mask              ),
   .c0_ddr4_app_wdf_wren       (app_wdf_wren              ),
   .c0_ddr4_app_rd_data        (app_rd_data               ),
   .c0_ddr4_app_rd_data_end    (app_rd_data_end           ),
   .c0_ddr4_app_rd_data_valid  (app_rd_data_valid         ),
   .c0_ddr4_app_rdy            (app_rdy                   ),
   .c0_ddr4_app_wdf_rdy        (app_wdf_rdy               ),
   .dbg_bus                    (                          )
   );

// End of User Design top instance

mem_burst
#(
	.MEM_DATA_BITS                  (APP_DATA_WIDTH),
	.MEM_IF_ADDR_BITS               (MEM_IF_ADDR_BITS),
	.ADDR_BITS                      (ADDR_WIDTH)
)
 mem_burst_m0
(
	.rst                            (rst                      ),
	.mem_clk                        (mem_clk                  ),
	.rd_burst_req                   (rd_burst_req             ),
	.wr_burst_req                   (wr_burst_req             ),
	.rd_burst_len                   (rd_burst_len             ),
	.wr_burst_len                   (wr_burst_len             ),
	.rd_burst_addr                  (rd_burst_addr            ),
	.wr_burst_addr                  (wr_burst_addr            ),
	.rd_burst_data_valid            (rd_burst_data_valid      ),
	.wr_burst_data_req              (wr_burst_data_req        ),
	.rd_burst_data                  (rd_burst_data            ),
	.wr_burst_data                  (wr_burst_data            ),
	.rd_burst_finish                (rd_burst_finish          ),
	.wr_burst_finish                (wr_burst_finish          ),
	.burst_finish                   (                         ),
	.app_addr                       (app_addr                 ),
	.app_cmd                        (app_cmd                  ),
	.app_en                         (app_en                   ),
	.app_wdf_data                   (app_wdf_data             ),
	.app_wdf_end                    (app_wdf_end              ),
	.app_wdf_mask                   (app_wdf_mask             ),
	.app_wdf_wren                   (app_wdf_wren             ),
	.app_rd_data                    (app_rd_data              ),
	.app_rd_data_end                (app_rd_data_end          ),
	.app_rd_data_valid              (app_rd_data_valid        ),
	.app_rdy                        (app_rdy                  ),
	.app_wdf_rdy                    (app_wdf_rdy              ),
	.ui_clk_sync_rst                (                         ),
	.init_calib_complete            (init_calib_complete      )
);
mem_test
#(
	.MEM_DATA_BITS                  (APP_DATA_WIDTH),
	.ADDR_BITS                      (ADDR_WIDTH)
)
mem_test_m0
(
	.rst                            (rst                      ),
	.mem_clk                        (mem_clk                  ),
	.rd_burst_req                   (rd_burst_req             ),
	.wr_burst_req                   (wr_burst_req             ),
	.rd_burst_len                   (rd_burst_len             ),
	.wr_burst_len                   (wr_burst_len             ),
	.rd_burst_addr                  (rd_burst_addr            ),
	.wr_burst_addr                  (wr_burst_addr            ),
	.rd_burst_data_valid            (rd_burst_data_valid      ),
	.wr_burst_data_req              (wr_burst_data_req        ),
	.rd_burst_data                  (rd_burst_data            ),
	.wr_burst_data                  (wr_burst_data            ),
	.rd_burst_finish                (rd_burst_finish          ),
	.wr_burst_finish                (wr_burst_finish          ),
	.error                          (error                    ),
	.heartbeat                      (heartbeat                )
);
endmodule

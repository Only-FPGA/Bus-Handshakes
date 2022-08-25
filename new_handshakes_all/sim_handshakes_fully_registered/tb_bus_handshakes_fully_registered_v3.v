// -----------------------------------------------------------------------------
// Copyright (c) 2014-2022 All rights reserved
// -----------------------------------------------------------------------------
// Author : WangXinzhe  215756479@qq.com
// wechat : wxz18066913150
// File   : tb_bus_handshakes_fully_registered_v3.v
// Create : 2022-08-25 08:56:04
// Revise : 2022-08-25 08:56:04
// Editor : sublime text3, tab size (4)
// -----------------------------------------------------------------------------
`timescale 1ns/1ns
module tb_bus_handshakes_fully_registered_v3();
localparam 	WIDTH = 9,
			DEPTH = 256;

reg		clk  		;
reg		s_rst		;
reg		vaild_in	;

reg		ready_in	;


wire [WIDTH-1:0]	src_data  	;
wire [WIDTH-1:0]	dst_data  	;
wire				src_ready	;
wire				src_vaild	;
wire				dst_ready	;
wire				dst_vaild	;



initial begin
	forever #10 clk = ~clk;
end

initial begin
	clk = 0;
	s_rst = 1;
	vaild_in = 0;
	#100
	s_rst = 0;
end

reg   temp;

integer i;
initial begin
	ready_in = 1;
	#160
	// @(posedge clk)
	// begin
	// 	vaild_in = 1;
	// 	ready_in = 0;
	// end
	// #40;
	// @(posedge clk)
	// vaild_in = 0;
	// #40
	// @(posedge clk)
	// ready_in = 1;
	// #20
	// @(posedge clk)
	// ready_in = 0;

	repeat(300)begin	
		@(posedge clk)
		begin
		ready_in = {$random};
		temp = {$random};//如果vaild == 0 
		if(temp == 0);
			begin
				if(src_vaild == 1 && src_ready == 0)
					vaild_in = 1;
				else
					vaild_in = temp;
			end
		end
	end
	#20
	vaild_in = 1;
	ready_in = 1;
end

source_v3 #( 
	.WIDTH(WIDTH),
	.DEPTH(DEPTH) 
	)
source_v3_inst
(
	.clk		(clk  ),
	.s_rst		(s_rst),
	.vaild_in	(vaild_in),
	.ready		(src_ready),

	.vaild		(src_vaild),
	.data_out	(src_data )
	);


Fully_Registered_v3 #( 
	.WIDTH(WIDTH),
	.DEPTH(DEPTH)
	)
Fully_Registered_v3_inst
(
	.clk			(clk  ),
	.s_rst			(s_rst),
	.idle			(),
	.src_vaild		(src_vaild),
	.src_data_in	(src_data ),

	.src_ready		(src_ready),

	.dst_ready		(dst_ready),

	.dst_vaild		(dst_vaild),
	.dst_data_out	(dst_data )

	);


destination_v3 #( 
	.WIDTH(WIDTH),
	.DEPTH(DEPTH)  
	)
destination_v3_inst
(
	.clk		(clk  ),
	.s_rst		(s_rst),
	.vaild		(dst_vaild),
	.data_in	(dst_data),

	.ready		(dst_ready),

	.ready_in 	(ready_in)
	);

endmodule
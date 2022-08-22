// -----------------------------------------------------------------------------
// Copyright (c) 2014-2022 All rights reserved
// -----------------------------------------------------------------------------
// Author : WangXinzhe  215756479@qq.com
// wechat : wxz18066913150
// File   : tb_bus_handshakes_foward_registered_v1.v
// Create : 2022-08-22 08:26:58
// Revise : 2022-08-22 08:26:58
// Editor : sublime text3, tab size (4)
// -----------------------------------------------------------------------------
`timescale 1ns/1ns
module tb_bus_handshakes_foward_registered_v1();
localparam 	WIDTH = 9,
			DEPTH = 256;


reg		clk  	;
reg		s_rst	;
reg		start	;
reg		idle	;


wire				src_vaild	;
wire				src_ready	;
wire [WIDTH-1:0]	src_data  	;

wire				dst_vaild	;
wire				dst_ready	;
wire [WIDTH-1:0]	dst_data  	;
initial begin
	forever #10 clk = ~clk;
end

initial begin
	clk = 1;
	s_rst = 1;
	start = 0;
	#100
	s_rst = 0;
	#60
	start = 1;
	#40
	start = 0;
	#40
	start = 1;
	#60
	start = 0;
	#60
	start = 1;
end

integer i;
initial begin
	idle = 0;
	#130
	idle = 1;
	repeat(10)begin
		for(i=20;i<301;i=i+10)
		#i
		idle = ~idle;
	end
	#20
	idle = 1;
end

source #( 
	.WIDTH(WIDTH),
	.DEPTH(DEPTH) 
	)
source_inst
(
	.clk		(clk  ),
	.s_rst		(s_rst),
	.start		(start),
	.ready		(src_ready),

	.vaild		(src_vaild),
	.data_out	(src_data )
	);

Forward_Registered_v1 #( 
	.WIDTH(WIDTH),
	.DEPTH(DEPTH)
	)
Forward_Registered_v1_inst
(
	.clk			(clk  ),
	.s_rst			(s_rst),
	.start			(start),
	.src_vaild		(src_vaild),
	.src_data_in	(src_data ),

	.src_ready		(src_ready),

	.dst_ready		(dst_ready),

	.dst_vaild		(dst_vaild),
	.dst_data_out	(dst_data )

	);


destination_v1 #( 
	.WIDTH(WIDTH),
	.DEPTH(DEPTH)  
	)
destination_v1_inst
(
	.clk		(clk  ),
	.s_rst		(s_rst),
	.vaild		(dst_vaild),
	.data_in	(dst_data),

	.ready		(dst_ready),

	.idle 		(idle)
	);
endmodule
// -----------------------------------------------------------------------------
// Copyright (c) 2014-2022 All rights reserved
// -----------------------------------------------------------------------------
// Author : WangXinzhe  215756479@qq.com
// wechat : wxz18066913150
// File   : tb_bus_handshakes_v1.v
// Create : 2022-08-22 08:08:08
// Revise : 2022-08-22 08:08:08
// Editor : sublime text3, tab size (4)
// -----------------------------------------------------------------------------
`timescale 1ns/1ns
module tb_bus_handshakes_v1();
localparam 	WIDTH = 9,
			DEPTH = 256;


reg		clk  	;
reg		s_rst	;
reg		start	;

reg		idle	;

wire				vaild	;
wire				ready	;
wire [WIDTH-1:0]	data  	;

initial begin
	forever #10 clk = ~clk;
end

initial begin
	clk = 0;
	s_rst = 1;
	start = 0;
	#100
	s_rst = 0;
	#60
	start = 1;
	#40
	start = 0;
	#60
	start = 1;
	#60
	start = 0;
	#60
	start = 1;
end

integer i;
initial begin
	idle = 0;
	#160
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
	.ready		(ready),

	.vaild		(vaild),
	.data_out	(data)
	);


destination_v1 #( 
	.WIDTH(WIDTH),
	.DEPTH(DEPTH)  
	)
destination_v1_inst
(
	.clk		(clk  ),
	.s_rst		(s_rst),
	.vaild		(vaild),
	.data_in	(data),

	.ready		(ready),

	.idle 		(idle)
	);
endmodule
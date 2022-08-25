// -----------------------------------------------------------------------------
// Copyright (c) 2014-2022 All rights reserved
// -----------------------------------------------------------------------------
// Author : WangXinzhe  215756479@qq.com
// wechat : wxz18066913150
// File   : Backward_Registered_v3.v
// Create : 2022-08-24 18:39:40
// Revise : 2022-08-24 18:39:40
// Editor : sublime text3, tab size (4)
// -----------------------------------------------------------------------------
module Backward_Registered_v3#( 
	parameter	WIDTH = 8 ,
	parameter 	DEPTH = 256 
	)
(
	clk,
	s_rst,
	idle,//原本start改为idle
	src_vaild,
	src_data_in,

	src_ready,

	dst_ready,

	dst_vaild,
	dst_data_out

	);
input						clk			;
input						s_rst		;
input						idle		;
input						src_vaild	;
input		[WIDTH-1:0]		src_data_in ;
input						dst_ready	;

output						dst_vaild	;
output		[WIDTH-1:0]		dst_data_out;
output						src_ready 	;

reg 	data_buffer_full	;
reg [WIDTH-1:0]	data_buffer_data;

//============================data buffer ===================

always @(posedge clk) begin
	if (s_rst == 1'b1) begin
		// reset
		data_buffer_full <= 1'b0;
		end
	else if ((src_vaild && src_ready) && (dst_vaild && !dst_ready)) begin
		data_buffer_full <= 1'b1;
	end
	else if (dst_ready == 1'b1)
		data_buffer_full <= 1'b0;
end

always@(posedge clk)begin
	if(s_rst == 1'b1)begin
		data_buffer_data <= 'd0;
	end
	else if(src_ready)begin
		data_buffer_data <= src_data_in;
	end
end

//=============================== data buffer end====================================

assign  src_ready = !data_buffer_full;//data buffer 没有数据的时候，拉高，取master数据



assign dst_data_out = (data_buffer_full == 1'b1) ?data_buffer_data:src_data_in;//


assign dst_vaild = data_buffer_full | src_vaild;



endmodule
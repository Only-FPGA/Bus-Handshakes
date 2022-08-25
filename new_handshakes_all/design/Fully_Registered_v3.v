// -----------------------------------------------------------------------------
// Copyright (c) 2014-2022 All rights reserved
// -----------------------------------------------------------------------------
// Author : WangXinzhe  215756479@qq.com
// wechat : wxz18066913150
// File   : Fully_Registered_v3.v
// Create : 2022-08-25 08:57:36
// Revise : 2022-08-25 08:57:36
// Editor : sublime text3, tab size (4)
// -----------------------------------------------------------------------------
module Fully_Registered_v3#( 
	parameter	WIDTH = 8 ,
	parameter 	DEPTH = 256 
	)
(
	clk,
	s_rst,
	idle,
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


wire 			data_buffer_full_1			;
reg [WIDTH-1:0]	data_buffer_data_1			;

wire 			data_buffer_full_2			;
reg [WIDTH-1:0]	data_buffer_data_2			;

wire 			load_data_buffer			;
reg 			switch_load					;

reg             vaild_1						;
reg  			vaild_2						;
wire  			switch_sel					;
reg 			sel							;


//======================== ping-pong buffer ===============================
assign load_data_buffer = src_vaild && src_ready;


always @(posedge clk) begin
	if (s_rst) begin
		// reset
		switch_load <= 1'b0;
	end
	else if (load_data_buffer) begin
		switch_load <= ~switch_load;
	end
end

assign data_buffer_full_1 = ~switch_load & src_vaild & src_ready;
assign data_buffer_full_2 = switch_load & src_vaild & src_ready;

always @(posedge clk) begin
	if (s_rst) begin
		// reset
		data_buffer_data_1 <= 'd0;
	end
	else if (data_buffer_full_1) begin
		data_buffer_data_1 <= src_data_in;
	end
end

always @(posedge clk) begin
	if (s_rst) begin
		// reset
		data_buffer_data_2 <= 'd0;
	end
	else if (data_buffer_full_2) begin
		data_buffer_data_2 <= src_data_in;
	end
end

//======================== ping-pong buffer end===============================


always @(posedge clk) begin
	if (s_rst) begin
		// reset
		vaild_1 <= 1'b0;
	end
	else if (data_buffer_full_1) begin
		vaild_1 <= 1'b1;
	end
	else if(~sel & dst_vaild & dst_ready) begin
		vaild_1 <= 1'b0;
	end
	else begin
		vaild_1 <= vaild_1;
	end


end

always @(posedge clk) begin
	if (s_rst) begin
		// reset
		vaild_2 <= 1'b0;
	end
	else if (data_buffer_full_2) begin
		vaild_2 <= 1'b1;
	end
	else if(sel & dst_vaild & dst_ready) begin
		vaild_2 <= 1'b0;
	end
	else begin
		vaild_2 <= vaild_2;
	end

end

assign src_ready = ~vaild_1 | ~vaild_2;
assign dst_vaild = vaild_1 | vaild_2;

assign switch_sel = dst_ready && dst_vaild;
assign dst_data_out = (sel == 1'b0) ? data_buffer_data_1 : data_buffer_data_2;


always @(posedge clk) begin
	if (s_rst) begin
		// reset
		sel <= 1'b0;
	end
	else if (switch_sel) begin
		sel <= ~sel;
	end
end
endmodule
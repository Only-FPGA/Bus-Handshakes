// -----------------------------------------------------------------------------
// Copyright (c) 2014-2022 All rights reserved
// -----------------------------------------------------------------------------
// Author : WangXinzhe  215756479@qq.com
// wechat : wxz18066913150
// File   : Backward_Registered.v
// Create : 2022-08-20 17:52:20
// Revise : 2022-08-20 17:52:20
// Editor : sublime text3, tab size (4)
// -----------------------------------------------------------------------------
module Backward_Registered#( 
	parameter	WIDTH = 8 ,
	parameter 	DEPTH = 256 
	)
(
	clk,
	s_rst,
	start,
	src_vaild,
	src_data_in,

	src_ready,

	dst_ready,

	dst_vaild,
	dst_data_out

	);
input						clk			;
input						s_rst		;
input						start		;
input						src_vaild	;
input		[WIDTH-1:0]		src_data_in ;
input						dst_ready	;

output						dst_vaild	;
output		[WIDTH-1:0]		dst_data_out;
output	reg					src_ready 	;

reg 				data_flag		;
reg 				data_flag_r1	;
reg 				data_flag_r2	;
reg [WIDTH-1:0]		data_buff		;

reg                 data_hold 		;

always@(posedge clk)begin
	if(s_rst == 1'b1)
	begin
		data_flag <= 1'b0;
		data_flag_r1 <= 1'b0;
		data_flag_r2 <= 1'b0;
	end
	else
	begin
		data_flag <= src_vaild;
		data_flag_r1 <= data_flag;
		data_flag_r2 <= data_flag_r1;
	end
end

always @(posedge clk) begin
	if (s_rst == 1'b1) 
		src_ready <= 1'b0;
	else
		src_ready <= dst_ready;	

end

always @(posedge clk) begin
	if (s_rst == 1'b1) begin
		data_buff <= {WIDTH{1'b0}};		
	end
	else 
		data_buff <= src_data_in;
end

always @(posedge clk) begin
	if (s_rst == 1'b1) begin
		data_hold <= 1'b0;
	end
	else if (src_vaild & src_ready) begin
		data_hold <= 1'b1;
	end
	else begin
		data_hold <= 1'b0;
	end
end

assign dst_data_out = (src_ready == 1)?src_data_in:data_buff;

assign dst_vaild = (src_vaild & !(!data_flag_r2 & data_flag_r1) ) | data_hold;//消去第三周期的dst_vaild信号，防止多存数据, data_hold,为了延长一个数据有效

endmodule
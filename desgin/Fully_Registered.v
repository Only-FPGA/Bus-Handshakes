// -----------------------------------------------------------------------------
// Copyright (c) 2014-2022 All rights reserved
// -----------------------------------------------------------------------------
// Author : WangXinzhe  215756479@qq.com
// wechat : wxz18066913150
// File   : Fully_Registered.v
// Create : 2022-08-21 09:04:39
// Revise : 2022-08-21 09:04:39
// Editor : sublime text3, tab size (4)
// -----------------------------------------------------------------------------
module Fully_Registered#( 
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

output	reg					dst_vaild	;
output	reg	[WIDTH-1:0]		dst_data_out;
output	reg					src_ready 	;

reg 				error_data_flag		;
reg 				error_data_flag_r1	;
reg 				error_data_flag_r2	;

always@(posedge clk)begin
	if(s_rst == 1'b1)
		begin
			error_data_flag		<= 1'b0;
			error_data_flag_r1	<= 1'b0;
			error_data_flag_r2	<= 1'b0;
		end
	else begin
		error_data_flag		<= src_vaild			;
		error_data_flag_r1	<= error_data_flag		;
		error_data_flag_r2	<= error_data_flag_r1	;
	end
end



always @(posedge clk) 
	if (s_rst == 1'b1) 
		dst_vaild <= 1'b0;
	else
		dst_vaild <=  src_vaild & (!  (!error_data_flag_r2 & error_data_flag_r1) | (!error_data_flag_r1 & error_data_flag ) )   ;//去除没用的数据，并把ready信号减少了	, | 为了补足有效vaild进行流水

always @(posedge clk) 
	if (s_rst == 1'b1) 
		dst_data_out <= {WIDTH{1'b0}};
	else
		dst_data_out <= src_data_in;	

always @(posedge clk) 
	if (s_rst == 1'b1) 
		src_ready <= 1'b0;
	else
		src_ready <= dst_ready | (src_ready & src_vaild);//为了流水，补足ready信号保持时间，根据是否还有有用数据	


	


endmodule
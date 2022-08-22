// -----------------------------------------------------------------------------
// Copyright (c) 2014-2022 All rights reserved
// -----------------------------------------------------------------------------
// Author : WangXinzhe  215756479@qq.com
// wechat : wxz18066913150
// File   : Forward_Registered_v1.v
// Create : 2022-08-22 08:53:28
// Revise : 2022-08-22 08:53:28
// Editor : sublime text3, tab size (4)
// -----------------------------------------------------------------------------
module Forward_Registered_v1#( 
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
output	reg	[WIDTH-1:0]		dst_data_out;
output						src_ready 	;



reg 				error_data_flag		;
reg 				error_data_flag_r1	;
reg 				error_data_flag_r2	;

reg 				dst_vaild_r			;

reg 				src_ready_r			;

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


always @(posedge clk) begin
	if (s_rst == 1'b1) 
		dst_vaild_r <= 1'b0;
	else
		dst_vaild_r <= src_vaild & ( !(  (!error_data_flag_r2 & error_data_flag_r1) | (!error_data_flag_r1 & error_data_flag ) ));
end

assign dst_vaild = dst_vaild_r | ((src_vaild && (src_ready && !src_ready_r)));//补足正确的数据存储

always @(posedge clk) begin
	if (s_rst == 1'b1)
		dst_data_out <= 'd0;
	else if(src_ready)
		dst_data_out <= src_data_in;

end

always @(posedge clk) begin
	if (s_rst == 1'b1) begin
		// reset
		src_ready_r <= 1'b0;
	end
	else begin
		src_ready_r <= src_ready;
	end
end


assign src_ready = dst_ready;

endmodule
// -----------------------------------------------------------------------------
// Copyright (c) 2014-2022 All rights reserved
// -----------------------------------------------------------------------------
// Author : WangXinzhe  215756479@qq.com
// wechat : wxz18066913150
// File   : Forward_Registered.v
// Create : 2022-08-20 17:52:20
// Revise : 2022-08-20 17:52:20
// Editor : sublime text3, tab size (4)
// -----------------------------------------------------------------------------
module Forward_Registered#( 
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
output						src_ready 	;


reg				start_r1				;
reg				start_r2				;
reg				start_r3				;
reg				start_r4				; 

always @(posedge clk)begin
	if(s_rst == 1'b1)
	begin
		start_r1 <= 1'b0;
		start_r2 <= 1'b0;
		start_r3 <= 1'b0;
	end
	else
	begin
		start_r1 <= start;
		start_r2 <= start_r1;
		start_r3 <= start_r2;
		start_r4 <= start_r3;
	end
end

always @(posedge clk) begin
	if (s_rst == 1'b1) 
		dst_vaild <= 1'b0;
	else if(dst_ready == 1'b1)
		dst_vaild <= src_vaild;
	else if({start_r3,start_r4} == 2'b10)
		dst_vaild <= src_vaild;
end

always @(posedge clk) begin
	if (s_rst == 1'b1)
		dst_data_out <= 'd0;
	else if(dst_ready == 1'b1)
		dst_data_out <= src_data_in;
	else if({start_r3,start_r4} == 2'b10)
		dst_data_out <= src_data_in;

end

assign src_ready = dst_ready | dst_vaild;

endmodule
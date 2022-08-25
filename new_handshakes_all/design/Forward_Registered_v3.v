// -----------------------------------------------------------------------------
// Copyright (c) 2014-2022 All rights reserved
// -----------------------------------------------------------------------------
// Author : WangXinzhe  215756479@qq.com
// wechat : wxz18066913150
// File   : Forward_Registered_v3.v
// Create : 2022-08-24 14:36:36
// Revise : 2022-08-24 14:36:36
// Editor : sublime text3, tab size (4)
// -----------------------------------------------------------------------------
module Forward_Registered_v3#( 
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



always @(posedge clk) begin
	if (s_rst == 1'b1)
		dst_vaild <= 'd0;
	else if(src_ready)
		dst_vaild <= src_vaild;

end


always @(posedge clk) begin
	if (s_rst == 1'b1)
		dst_data_out <= 'd0;
	else if(src_ready)
		dst_data_out <= src_data_in;

end



assign src_ready = dst_ready | ~dst_vaild;

endmodule
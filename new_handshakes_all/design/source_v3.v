// -----------------------------------------------------------------------------
// Copyright (c) 2014-2022 All rights reserved
// -----------------------------------------------------------------------------
// Author : WangXinzhe  215756479@qq.com
// wechat : wxz18066913150
// File   : source_v3.v
// Create : 2022-08-24 11:06:01
// Revise : 2022-08-24 11:06:01
// Editor : sublime text3, tab size (4)
// -----------------------------------------------------------------------------
module source_v3#( 
	parameter	WIDTH = 8 ,
	parameter 	DEPTH = 256 
	)
(
	clk,
	s_rst,
	vaild_in,
	ready,

	vaild,
	data_out
	);
localparam wt = $clog2(DEPTH);

input						clk				;
input						s_rst 			;
input						vaild_in 		;
input						ready 			;

output  reg 	[WIDTH-1:0]	data_out		;
output						vaild 			;



reg 	[WIDTH-1:0] mem 	[DEPTH-1:0]	;
reg		[wt:0]	rd_addr					;			


//=================== 初始化 ==================
integer i;
always@(posedge clk)
	if(s_rst == 1'b1)
	for(i = 0;i < DEPTH; i= i + 1)begin
		mem[i] <= i +1;
	end
//==================  end  ===================


//==================vaild ==================
// always@(posedge clk)begin
// 	if(s_rst == 1'b1)
// 		vaild <= 1'b0;
// 	else if(rd_addr == (DEPTH))//To prevent livelocks
// 		vaild <= 1'b0;
// 	else if(vaild_in == 1'b0 && vaild == 1'b1 && ready == 1'b0)
// 		vaild <= 1'b1;
// 	else if(vaild_in == 1'b1)//To prevent deadlocks
// 		vaild <= 1'b1;
// 	else
// 		vaild <= 1'b0;		
// end
assign vaild = vaild_in;
//==================end===============


//===================payload_out=====================
always@(posedge clk)begin
	if(s_rst == 1'b1)//first data
		data_out <= mem[0];
	else if(ready == 1'b1 && vaild == 1'b1)
		data_out <= mem[rd_addr];
	else
		data_out <= data_out;	
end

always @(posedge clk) begin
	if (s_rst == 1'b1)
		rd_addr <= 'd1;
	else if(rd_addr == (DEPTH) && ready == 1'b1 && vaild == 1'b1)
		rd_addr <= rd_addr;
	else if (ready == 1'b1 && vaild == 1'b1) //handshake is complete,next begin
		rd_addr <= rd_addr + 1'b1;
end
//===================end ====================================================

endmodule
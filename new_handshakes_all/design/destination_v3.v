// -----------------------------------------------------------------------------
// Copyright (c) 2014-2022 All rights reserved
// -----------------------------------------------------------------------------
// Author : WangXinzhe  215756479@qq.com
// wechat : wxz18066913150
// File   : destination_v3.v
// Create : 2022-08-24 11:49:27
// Revise : 2022-08-24 11:49:27
// Editor : sublime text3, tab size (4)
// -----------------------------------------------------------------------------
module destination_v3#( 
	parameter	WIDTH = 8 ,
	parameter 	DEPTH = 256  
	)
(
	clk,
	s_rst,
	ready_in,//contrl ready
	vaild,
	data_in,

	ready
	);
localparam wt = $clog2(DEPTH);

input						clk				;
input						s_rst 			;
input						vaild 			;
input 		[WIDTH-1:0]		data_in			;

output						ready			;

input 						ready_in			;

reg 	[WIDTH-1:0] mem 	[DEPTH-1:0]	;
reg		[wt-1:0]	wr_addr				;



		
assign ready = ready_in && vaild;//the destination interface can wait for the source interface to assert valid before asserting ready 

// always @(posedge clk) begin
// 	if (s_rst == 1'b1) begin
// 		// reset
// 		ready <= 1'b0;
// 	end
// 	else begin
// 		ready <= ready_in && vaild;
// 	end
// end


always @(posedge clk) begin
	if (s_rst == 1'b1)
		wr_addr <= {wt{1'b0}};
	else if(wr_addr == (DEPTH-1) && vaild == 1'b1 && ready == 1'b1)
		wr_addr <= wr_addr;
	else if (vaild == 1'b1 && ready == 1'b1) 
		wr_addr <= wr_addr + 1'b1;

end

integer i;
always @(posedge clk)begin
	//======================= 初始化 =================
	if(s_rst == 1'b1)begin
		for(i = 0;i < DEPTH;i = i + 1)
			begin
			 	mem[i] <='d0;
			end
	end 
	//======================= end ===================
	else if(vaild == 1'b1 && ready == 1'b1)
		mem[wr_addr] <= data_in;
end
endmodule
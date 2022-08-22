// -----------------------------------------------------------------------------
// Copyright (c) 2014-2022 All rights reserved
// -----------------------------------------------------------------------------
// Author : WangXinzhe  215756479@qq.com
// wechat : wxz18066913150
// File   : Backward_Registered_v1.v
// Create : 2022-08-22 10:14:59
// Revise : 2022-08-22 10:14:59
// Editor : sublime text3, tab size (4)
// -----------------------------------------------------------------------------
module Backward_Registered_v1#( 
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

reg 				data_flag		;
reg 				data_flag_r1	;
reg 				data_flag_r2	;


reg 				hold_ready		;

reg  				hold_ready_flag ;


reg 				idle_r			;
reg  				src_ready_r		;


reg		idle_r1	;
reg		idle_r2	;
reg  	delr		;
//======== 异步转同步======
always @(posedge clk) begin
	if (s_rst == 1'b1) begin
		// reset
		idle_r1 <= 1'b0;
		idle_r2 <= 1'b0;
	end
	else begin
		idle_r1 <= idle;
		idle_r2 <= idle_r1;
	end
end
//============ end =========

always @(posedge clk) begin
	if (s_rst == 1'b1) begin
		// reset
		idle_r <= 1'b0;
	end
	else begin
		idle_r <= idle_r2;
	end
end


always @(posedge clk) begin
	if (s_rst == 1'b1) begin
		// reset
		hold_ready <= 1'b0;
	end
	else  begin
		hold_ready <= (!data_flag_r2 & data_flag_r1);
	end
end


always @(posedge clk) begin
	if (s_rst == 1'b1) begin
		// reset
		hold_ready_flag <= 1'b0;
	end
	else if (src_vaild == 1'b0) begin
		hold_ready_flag <= 1'b0;
	end
	else if(hold_ready == 1'b1)begin
		hold_ready_flag <= 1'b1;
	end
end


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
		src_ready_r <= 1'b0;
	else
		src_ready_r <= dst_ready & dst_vaild | (hold_ready & idle_r);	//修改部分，dst_vaild 没有的时候取消 (hold_ready & idle_r)去除多的高电平，防止让source多加

end


always @(posedge clk) begin
	if (s_rst == 1'b1) begin
		// reset
		delr <= 1'b0;
	end
	else if (hold_ready_flag) begin
		delr <= dst_ready;
	end
end


assign src_ready = ((hold_ready_flag && src_vaild && idle_r) | src_ready_r) & (!(delr && !dst_ready)) ; 
//(!(delr && !dst_ready)) 去除多一拍 (hold_ready_flag && src_vaild && idle_r) 提前一拍



assign dst_data_out = src_data_in;



assign dst_vaild = (src_vaild & !(!data_flag_r2 & data_flag_r1) ) ;//消去第三周期的dst_vaild信号，防止多存数据, 

endmodule
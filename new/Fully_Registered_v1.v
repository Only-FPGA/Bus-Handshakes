// -----------------------------------------------------------------------------
// Copyright (c) 2014-2022 All rights reserved
// -----------------------------------------------------------------------------
// Author : WangXinzhe  215756479@qq.com
// wechat : wxz18066913150
// File   : Fully_Registered_v1.v
// Create : 2022-08-22 17:10:24
// Revise : 2022-08-22 17:10:24
// Editor : sublime text3, tab size (4)
// -----------------------------------------------------------------------------
module Fully_Registered_v1#( 
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

reg  	[WIDTH-1:0]	dst_data_out_r;
reg 				dst_vaild_r;

reg 				brust_flag;

reg					flag;

reg                 src_ready_r;

reg		idle_r1	;
reg		idle_r2	;

reg [3:0]	cnt;
reg [3:0]	cnt1;

wire 	a;
/*
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
	if (s_rst == 1'b1) begin
		// reset
		brust_flag <= 1'b0;
	end
	else if (src_vaild == 1'b0) begin
		brust_flag <= 1'b0;
	end
	else if (!error_data_flag_r2 && error_data_flag_r1)begin
		brust_flag <= 1'b1;
	end
end

always @(posedge clk) 
	if (s_rst == 1'b1) 
		dst_vaild_r <= 1'b0;
	else
		dst_vaild_r <=  src_vaild & (! (!error_data_flag_r2 & error_data_flag_r1) ) ;//&& (!(brust_flag && !src_ready) );//去除没用的数据，并把ready信号减少了	, | 为了补足有效vaild进行流水



assign dst_vaild = dst_vaild_r & (src_vaild | src_ready); //& flag;

always @(posedge clk) begin
	if (s_rst) begin
		// reset
		flag <= 1'b1;
	end
	else 
		flag <= (!error_data_flag_r2 & error_data_flag_r1);

end

always @(posedge clk) 
	if (s_rst == 1'b1) 
		dst_data_out <= {WIDTH{1'b0}};
	else
		dst_data_out <= src_data_in;	

always @(posedge clk) 
	if (s_rst == 1'b1) 
		src_ready <= 1'b0;
	else
		src_ready <= dst_ready & !(flag);//| (src_ready & src_vaild);//为了流水，补足ready信号保持时间，根据是否还有有用数据	

always @(posedge clk) 
	if (s_rst == 1'b1) 
		src_ready_r <= 1'b0;
	else
		src_ready_r <= src_ready;
	
*/


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

always @(posedge clk) begin
	if (s_rst == 1'b1) begin
		// reset
		cnt1 <= 'd0;
	end
	else if(cnt1 == 'd15 && idle_r2)begin
		cnt1 <= cnt1;
	end
	else if (idle_r2) begin
		cnt1 <= cnt1 + 1'b1;
	end
	else begin
		cnt1 <= 'd0;
	end
end

always @(posedge clk) begin
	if (s_rst == 1'b1) begin
		// reset
		cnt <= 'd0;
	end
	else if(cnt == 'd15 && src_vaild)begin
		cnt <= cnt;
	end
	else if (src_vaild) begin
		cnt <= cnt + 1'b1;
	end
	else begin
		cnt <= 'd0;
	end
end



always @(posedge clk) 
	if (s_rst == 1'b1) 
		dst_vaild_r <= 1'b0;
	else
		dst_vaild_r <=  src_vaild & (!  (cnt == 'd2) )   ;//去除没用的数据，并把ready信号减少了	, | 为了补足有效vaild进行流水

assign dst_vaild = (dst_vaild_r | (src_vaild == 1 && src_ready_r)) && a ;

assign a = (!(idle_r2 == 0 && cnt1 > 'd5 ));

always @(posedge clk) 
	if (s_rst == 1'b1) 
		dst_data_out_r <= {WIDTH{1'b0}};
	else
		dst_data_out_r <= src_data_in;	

assign dst_data_out = (cnt >=5 & !(cnt > 8))?dst_data_out_r : src_data_in;

always @(posedge clk) 
	if (s_rst == 1'b1) 
		src_ready_r <= 1'b0;
	else
		src_ready_r <= dst_ready| (cnt == 'd4 && src_vaild) && !(cnt1 >= 4 && idle_r2 == 0);//为了流水，补足ready信号保持时间，根据是否还有有用数据

assign src_ready = src_ready_r | (cnt >= 'd4 && cnt1 == 'd1) && !(cnt1 > 4 && idle_r2 == 0) ;	
endmodule
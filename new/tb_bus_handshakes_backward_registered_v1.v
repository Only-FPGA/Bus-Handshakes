//               ii.                                         ;9ABH,          
//              SA391,                                    .r9GG35&G          
//              &#ii13Gh;                               i3X31i;:,rB1         
//              iMs,:,i5895,                         .5G91:,:;:s1:8A         
//               33::::,,;5G5,                     ,58Si,,:::,sHX;iH1        
//                Sr.,:;rs13BBX35hh11511h5Shhh5S3GAXS:.,,::,,1AG3i,GG        
//                .G51S511sr;;iiiishS8G89Shsrrsh59S;.,,,,,..5A85Si,h8        
//               :SB9s:,............................,,,.,,,SASh53h,1G.       
//            .r18S;..,,,,,,,,,,,,,,,,,,,,,,,,,,,,,....,,.1H315199,rX,       
//          ;S89s,..,,,,,,,,,,,,,,,,,,,,,,,....,,.......,,,;r1ShS8,;Xi       
//        i55s:.........,,,,,,,,,,,,,,,,.,,,......,.....,,....r9&5.:X1       
//       59;.....,.     .,,,,,,,,,,,...        .............,..:1;.:&s       
//      s8,..;53S5S3s.   .,,,,,,,.,..      i15S5h1:.........,,,..,,:99       
//      93.:39s:rSGB@A;  ..,,,,.....    .SG3hhh9G&BGi..,,,,,,,,,,,,.,83      
//      G5.G8  9#@@@@@X. .,,,,,,.....  iA9,.S&B###@@Mr...,,,,,,,,..,.;Xh     
//      Gs.X8 S@@@@@@@B:..,,,,,,,,,,. rA1 ,A@@@@@@@@@H:........,,,,,,.iX:    
//     ;9. ,8A#@@@@@@#5,.,,,,,,,,,... 9A. 8@@@@@@@@@@M;    ....,,,,,,,,S8    
//     X3    iS8XAHH8s.,,,,,,,,,,...,..58hH@@@@@@@@@Hs       ...,,,,,,,:Gs   
//    r8,        ,,,...,,,,,,,,,,.....  ,h8XABMMHX3r.          .,,,,,,,.rX:  
//   :9, .    .:,..,:;;;::,.,,,,,..          .,,.               ..,,,,,,.59  
//  .Si      ,:.i8HBMMMMMB&5,....                    .            .,,,,,.sMr 
//  SS       :: h@@@@@@@@@@#; .                     ...  .         ..,,,,iM5 
//  91  .    ;:.,1&@@@@@@MXs.                            .          .,,:,:&S 
//  hS ....  .:;,,,i3MMS1;..,..... .  .     ...                     ..,:,.99 
//  ,8; ..... .,:,..,8Ms:;,,,...                                     .,::.83 
//   s&: ....  .sS553B@@HX3s;,.    .,;13h.                            .:::&1 
//    SXr  .  ...;s3G99XA&X88Shss11155hi.                             ,;:h&, 
//     iH8:  . ..   ,;iiii;,::,,,,,.                                 .;irHA  
//      ,8X5;   .     .......                                       ,;iihS8Gi
//         1831,                                                 .,;irrrrrs&@
//           ;5A8r.                                            .:;iiiiirrss1H
//             :X@H3s.......                                .,:;iii;iiiiirsrh
//              r#h:;,...,,.. .,,:;;;;;:::,...              .:;;;;;;iiiirrss1
//             ,M8 ..,....,.....,,::::::,,...         .     .,;;;iiiiiirss11h
//             8B;.,,,,,,,.,.....          .           ..   .:;;;;iirrsss111h
//            i@5,:::,,,,,,,,.... .                   . .:::;;;;;irrrss111111
//            9Bi,:,,,,......                        ..r91;;;;;iirrsss1ss1111
// -----------------------------------------------------------------------------
// Copyright (c) 2014-2022 All rights reserved
// -----------------------------------------------------------------------------
// Author : WangXinzhe  215756479@qq.com
// wechat : wxz18066913150
// File   : tb_bus_handshakes_backward_registered_v1.v
// Create : 2022-08-22 10:05:41
// Revise : 2022-08-22 15:49:35
// Editor : sublime text3, tab size (4)
// -----------------------------------------------------------------------------
`timescale 1ns/1ns
module tb_bus_handshakes_backward_registered_v1();
localparam 	WIDTH = 9,
			DEPTH = 256;


reg		clk  	;
reg		s_rst	;
reg		start	;
reg		idle	;

wire				src_vaild	;
wire				src_ready	;
wire [WIDTH-1:0]	src_data  	;

wire				dst_vaild	;
wire				dst_ready	;
wire [WIDTH-1:0]	dst_data  	;
initial begin
	forever #10 clk = ~clk;
end

initial begin
	clk = 1;
	s_rst = 1;
	start = 0;
	#100
	s_rst = 0;
	#60
	start = 1;
	#80
	start = 0;
	#60
	start = 1;
	#60
	start = 0;
	#60
	start = 1;
end

integer i;
initial begin
	idle = 0;
	#130
	idle = 1;
	repeat(10)begin
		for(i=20;i<301;i=i+10)
		#i
		idle = ~idle;
	end
	#20
	idle = 1;
end
source #( 
	.WIDTH(WIDTH),
	.DEPTH(DEPTH) 
	)
source_inst
(
	.clk		(clk  ),
	.s_rst		(s_rst),
	.start		(start),
	.ready		(src_ready),

	.vaild		(src_vaild),
	.data_out	(src_data )
	);

Backward_Registered_v1#( 
	.WIDTH(WIDTH),
	.DEPTH(DEPTH)
	)
Backward_Registered_v1_inst
(
	.clk			(clk  ),
	.s_rst			(s_rst),
	.idle			(idle),
	.src_vaild		(src_vaild),
	.src_data_in	(src_data ),

	.src_ready		(src_ready),

	.dst_ready		(dst_ready),

	.dst_vaild		(dst_vaild),
	.dst_data_out	(dst_data )

	);

destination_v1 #( 
	.WIDTH(WIDTH),
	.DEPTH(DEPTH)  
	)
destination_v1_inst
(
	.clk		(clk  ),
	.s_rst		(s_rst),
	.vaild		(dst_vaild),
	.data_in	(dst_data),

	.ready		(dst_ready),

	.idle 		(idle)
	);
endmodule
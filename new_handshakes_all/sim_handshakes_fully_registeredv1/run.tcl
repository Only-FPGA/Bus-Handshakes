quit -sim
#退出仿真
.main clear
#清除仿真临时文件

vlib work
#创建工作库
vlog ./tb_bus_handshakes_fully_registered_v4.v
#添加文件,放在编译库里面
vlog ../design/source_v3.v
vlog ../design/destination_v3.v
vlog ../design/Backward_Registered_v3.v
vlog ../design/Forward_Registered_v3.v

vsim    -voptargs=+acc work.tb_bus_handshakes_fully_registered_v4


########################## add wave #########################################
add wave /tb_bus_handshakes_fully_registered_v4/*

add wave -expand -group sim:/tb_bus_handshakes_fully_registered_v4/source_v3_inst/Group1 -radix unsigned /tb_bus_handshakes_fully_registered_v4/source_v3_inst/clk
add wave -expand -group sim:/tb_bus_handshakes_fully_registered_v4/source_v3_inst/Group1 -radix unsigned /tb_bus_handshakes_fully_registered_v4/source_v3_inst/s_rst
add wave -expand -group sim:/tb_bus_handshakes_fully_registered_v4/source_v3_inst/Group1 -radix unsigned /tb_bus_handshakes_fully_registered_v4/source_v3_inst/vaild_in
add wave -expand -group sim:/tb_bus_handshakes_fully_registered_v4/source_v3_inst/Group1 -radix unsigned /tb_bus_handshakes_fully_registered_v4/source_v3_inst/rd_addr
add wave -expand -group sim:/tb_bus_handshakes_fully_registered_v4/source_v3_inst/Group1 -color Red -radix unsigned /tb_bus_handshakes_fully_registered_v4/source_v3_inst/data_out
add wave -expand -group sim:/tb_bus_handshakes_fully_registered_v4/source_v3_inst/Group1 -color Red -radix unsigned /tb_bus_handshakes_fully_registered_v4/source_v3_inst/vaild
add wave -expand -group sim:/tb_bus_handshakes_fully_registered_v4/source_v3_inst/Group1 -color Blue -radix unsigned /tb_bus_handshakes_fully_registered_v4/source_v3_inst/ready

add wave -expand -group sim:/tb_bus_handshakes_fully_registered_v4/Backward_Registered_v3_inst/Group1 -radix unsigned /tb_bus_handshakes_fully_registered_v4/Backward_Registered_v3_inst/clk
add wave -expand -group sim:/tb_bus_handshakes_fully_registered_v4/Backward_Registered_v3_inst/Group1 -radix unsigned /tb_bus_handshakes_fully_registered_v4/Backward_Registered_v3_inst/s_rst
add wave -expand -group sim:/tb_bus_handshakes_fully_registered_v4/Backward_Registered_v3_inst/Group1 -color Red -radix unsigned /tb_bus_handshakes_fully_registered_v4/Backward_Registered_v3_inst/src_vaild
add wave -expand -group sim:/tb_bus_handshakes_fully_registered_v4/Backward_Registered_v3_inst/Group1 -color Blue -radix unsigned /tb_bus_handshakes_fully_registered_v4/Backward_Registered_v3_inst/dst_vaild
add wave -expand -group sim:/tb_bus_handshakes_fully_registered_v4/Backward_Registered_v3_inst/Group1 -color Red -radix unsigned /tb_bus_handshakes_fully_registered_v4/Backward_Registered_v3_inst/src_data_in
add wave -expand -group sim:/tb_bus_handshakes_fully_registered_v4/Backward_Registered_v3_inst/Group1 -color Blue -radix unsigned /tb_bus_handshakes_fully_registered_v4/Backward_Registered_v3_inst/dst_data_out
add wave -expand -group sim:/tb_bus_handshakes_fully_registered_v4/Backward_Registered_v3_inst/Group1 -color Red -radix unsigned /tb_bus_handshakes_fully_registered_v4/Backward_Registered_v3_inst/src_ready
add wave -expand -group sim:/tb_bus_handshakes_fully_registered_v4/Backward_Registered_v3_inst/Group1 -color Blue -radix unsigned /tb_bus_handshakes_fully_registered_v4/Backward_Registered_v3_inst/dst_ready 
add wave -expand -group sim:/tb_bus_handshakes_fully_registered_v4/Backward_Registered_v3_inst/Group1 -radix unsigned /tb_bus_handshakes_fully_registered_v4/Backward_Registered_v3_inst/data_buffer_full
add wave -expand -group sim:/tb_bus_handshakes_fully_registered_v4/Backward_Registered_v3_inst/Group1 -radix unsigned /tb_bus_handshakes_fully_registered_v4/Backward_Registered_v3_inst/data_buffer_data

add wave -expand -group sim:/tb_bus_handshakes_fully_registered_v4/Forward_Registered_v3_inst/Group1 -radix unsigned /tb_bus_handshakes_fully_registered_v4/Forward_Registered_v3_inst/clk
add wave -expand -group sim:/tb_bus_handshakes_fully_registered_v4/Forward_Registered_v3_inst/Group1 -radix unsigned /tb_bus_handshakes_fully_registered_v4/Forward_Registered_v3_inst/s_rst
add wave -expand -group sim:/tb_bus_handshakes_fully_registered_v4/Forward_Registered_v3_inst/Group1 -color Red -radix unsigned /tb_bus_handshakes_fully_registered_v4/Forward_Registered_v3_inst/src_vaild
add wave -expand -group sim:/tb_bus_handshakes_fully_registered_v4/Forward_Registered_v3_inst/Group1 -color Blue -radix unsigned /tb_bus_handshakes_fully_registered_v4/Forward_Registered_v3_inst/dst_vaild
add wave -expand -group sim:/tb_bus_handshakes_fully_registered_v4/Forward_Registered_v3_inst/Group1 -color Red -radix unsigned /tb_bus_handshakes_fully_registered_v4/Forward_Registered_v3_inst/src_data_in
add wave -expand -group sim:/tb_bus_handshakes_fully_registered_v4/Forward_Registered_v3_inst/Group1 -color Blue -radix unsigned /tb_bus_handshakes_fully_registered_v4/Forward_Registered_v3_inst/dst_data_out
add wave -expand -group sim:/tb_bus_handshakes_fully_registered_v4/Forward_Registered_v3_inst/Group1 -color Red -radix unsigned /tb_bus_handshakes_fully_registered_v4/Forward_Registered_v3_inst/src_ready
add wave -expand -group sim:/tb_bus_handshakes_fully_registered_v4/Forward_Registered_v3_inst/Group1 -color Blue -radix unsigned /tb_bus_handshakes_fully_registered_v4/Forward_Registered_v3_inst/dst_ready 


add wave -expand -group sim:/tb_bus_handshakes_fully_registered_v4/destination_v3_inst/Group1 -radix unsigned /tb_bus_handshakes_fully_registered_v4/destination_v3_inst/clk
add wave -expand -group sim:/tb_bus_handshakes_fully_registered_v4/destination_v3_inst/Group1 -radix unsigned /tb_bus_handshakes_fully_registered_v4/destination_v3_inst/s_rst
add wave -expand -group sim:/tb_bus_handshakes_fully_registered_v4/destination_v3_inst/Group1 -color Red -radix unsigned /tb_bus_handshakes_fully_registered_v4/destination_v3_inst/data_in
add wave -expand -group sim:/tb_bus_handshakes_fully_registered_v4/destination_v3_inst/Group1 -color Red -radix unsigned /tb_bus_handshakes_fully_registered_v4/destination_v3_inst/vaild
add wave -expand -group sim:/tb_bus_handshakes_fully_registered_v4/destination_v3_inst/Group1 -color Blue -radix unsigned /tb_bus_handshakes_fully_registered_v4/destination_v3_inst/ready
add wave -expand -group sim:/tb_bus_handshakes_fully_registered_v4/destination_v3_inst/Group1 -radix unsigned /tb_bus_handshakes_fully_registered_v4/destination_v3_inst/ready_in
add wave -expand -group sim:/tb_bus_handshakes_fully_registered_v4/destination_v3_inst/Group1 -radix unsigned /tb_bus_handshakes_fully_registered_v4/destination_v3_inst/wr_addr
add wave -expand -group sim:/tb_bus_handshakes_fully_registered_v4/destination_v3_inst/Group1 -radix unsigned /tb_bus_handshakes_fully_registered_v4/destination_v3_inst/mem

########################## end ##############################################
run 1us
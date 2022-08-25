quit -sim
#退出仿真
.main clear
#清除仿真临时文件

vlib work
#创建工作库
vlog ./tb_bus_handshakes_foward_registered_v3.v
#添加文件,放在编译库里面
vlog ../design/source_v3.v
vlog ../design/destination_v3.v
vlog ../design/Forward_Registered_v3.v

vsim    -voptargs=+acc work.tb_bus_handshakes_foward_registered_v3


########################## add wave #########################################
add wave /tb_bus_handshakes_foward_registered_v3/*

add wave -expand -group sim:/tb_bus_handshakes_foward_registered_v3/source_v3_inst/Group1 -radix unsigned /tb_bus_handshakes_foward_registered_v3/source_v3_inst/clk
add wave -expand -group sim:/tb_bus_handshakes_foward_registered_v3/source_v3_inst/Group1 -radix unsigned /tb_bus_handshakes_foward_registered_v3/source_v3_inst/s_rst
add wave -expand -group sim:/tb_bus_handshakes_foward_registered_v3/source_v3_inst/Group1 -radix unsigned /tb_bus_handshakes_foward_registered_v3/source_v3_inst/vaild_in
add wave -expand -group sim:/tb_bus_handshakes_foward_registered_v3/source_v3_inst/Group1 -radix unsigned /tb_bus_handshakes_foward_registered_v3/source_v3_inst/rd_addr
add wave -expand -group sim:/tb_bus_handshakes_foward_registered_v3/source_v3_inst/Group1 -color Red -radix unsigned /tb_bus_handshakes_foward_registered_v3/source_v3_inst/data_out
add wave -expand -group sim:/tb_bus_handshakes_foward_registered_v3/source_v3_inst/Group1 -color Red -radix unsigned /tb_bus_handshakes_foward_registered_v3/source_v3_inst/vaild
add wave -expand -group sim:/tb_bus_handshakes_foward_registered_v3/source_v3_inst/Group1 -color Blue -radix unsigned /tb_bus_handshakes_foward_registered_v3/source_v3_inst/ready

add wave -expand -group sim:/tb_bus_handshakes_foward_registered_v3/Forward_Registered_v3_inst/Group1 -radix unsigned /tb_bus_handshakes_foward_registered_v3/Forward_Registered_v3_inst/clk
add wave -expand -group sim:/tb_bus_handshakes_foward_registered_v3/Forward_Registered_v3_inst/Group1 -radix unsigned /tb_bus_handshakes_foward_registered_v3/Forward_Registered_v3_inst/s_rst
add wave -expand -group sim:/tb_bus_handshakes_foward_registered_v3/Forward_Registered_v3_inst/Group1 -color Red -radix unsigned /tb_bus_handshakes_foward_registered_v3/Forward_Registered_v3_inst/src_vaild
add wave -expand -group sim:/tb_bus_handshakes_foward_registered_v3/Forward_Registered_v3_inst/Group1 -color Blue -radix unsigned /tb_bus_handshakes_foward_registered_v3/Forward_Registered_v3_inst/dst_vaild
add wave -expand -group sim:/tb_bus_handshakes_foward_registered_v3/Forward_Registered_v3_inst/Group1 -color Red -radix unsigned /tb_bus_handshakes_foward_registered_v3/Forward_Registered_v3_inst/src_data_in
add wave -expand -group sim:/tb_bus_handshakes_foward_registered_v3/Forward_Registered_v3_inst/Group1 -color Blue -radix unsigned /tb_bus_handshakes_foward_registered_v3/Forward_Registered_v3_inst/dst_data_out
add wave -expand -group sim:/tb_bus_handshakes_foward_registered_v3/Forward_Registered_v3_inst/Group1 -color Red -radix unsigned /tb_bus_handshakes_foward_registered_v3/Forward_Registered_v3_inst/src_ready
add wave -expand -group sim:/tb_bus_handshakes_foward_registered_v3/Forward_Registered_v3_inst/Group1 -color Blue -radix unsigned /tb_bus_handshakes_foward_registered_v3/Forward_Registered_v3_inst/dst_ready 

add wave -expand -group sim:/tb_bus_handshakes_foward_registered_v3/destination_v3_inst/Group1 -radix unsigned /tb_bus_handshakes_foward_registered_v3/destination_v3_inst/clk
add wave -expand -group sim:/tb_bus_handshakes_foward_registered_v3/destination_v3_inst/Group1 -radix unsigned /tb_bus_handshakes_foward_registered_v3/destination_v3_inst/s_rst
add wave -expand -group sim:/tb_bus_handshakes_foward_registered_v3/destination_v3_inst/Group1 -color Red -radix unsigned /tb_bus_handshakes_foward_registered_v3/destination_v3_inst/data_in
add wave -expand -group sim:/tb_bus_handshakes_foward_registered_v3/destination_v3_inst/Group1 -color Red -radix unsigned /tb_bus_handshakes_foward_registered_v3/destination_v3_inst/vaild
add wave -expand -group sim:/tb_bus_handshakes_foward_registered_v3/destination_v3_inst/Group1 -color Blue -radix unsigned /tb_bus_handshakes_foward_registered_v3/destination_v3_inst/ready
add wave -expand -group sim:/tb_bus_handshakes_foward_registered_v3/destination_v3_inst/Group1 -radix unsigned /tb_bus_handshakes_foward_registered_v3/destination_v3_inst/ready_in
add wave -expand -group sim:/tb_bus_handshakes_foward_registered_v3/destination_v3_inst/Group1 -radix unsigned /tb_bus_handshakes_foward_registered_v3/destination_v3_inst/wr_addr
add wave -expand -group sim:/tb_bus_handshakes_foward_registered_v3/destination_v3_inst/Group1 -radix unsigned /tb_bus_handshakes_foward_registered_v3/destination_v3_inst/mem

########################## end ##############################################
run 1us
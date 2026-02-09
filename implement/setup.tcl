# This script sets up a Vivado project with all ip references resolved.
close_project -quiet
file delete -force proj.xpr *.os *.jou *.log proj.srcs proj.cache proj.runs
#
create_project -force  proj 
set_property board_part xilinx.com:k26i:part0:1.4 [current_project]
#set_property board_connections {som240_1_connector xilinx.com:kv260_carrier:som240_1_connector:1.3} [get_projects proj]
#set_property board_part xilinx.com:kv260_som:part0:1.4 [current_project]

set_property target_language Verilog [current_project]
set_property default_lib work [current_project]
load_features ipintegrator

#read_ip ../source/vinstru/source/vinstru_ila/vinstru_ila.xci
#upgrade_ip -quiet  [get_ips *]
#generate_target {all} [get_ips *]

set_property  ip_repo_paths  ../hls/hls_tpg/dct_hls_tpg/hls/impl/ip [current_project]
update_ip_catalog

source ../source/system.tcl
generate_target {synthesis implementation} [get_files ./proj.srcs/sources_1/bd/system/system.bd]
set_property synth_checkpoint_mode None    [get_files ./proj.srcs/sources_1/bd/system/system.bd]

read_verilog -sv ../source/mem_regfile/mem_regfile.sv
read_verilog -sv ../source/top.sv

read_xdc ../source/top.xdc

close_project

#########################




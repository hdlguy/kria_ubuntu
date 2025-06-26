# run at linux command line 
#       xsct setup.tcl
#       vitis --classic --workspace ./workspace
#
file delete -force ./workspace

set hw ../implement/results/top.xsa
#set proc "ps7_cortexa9_0"
#set proc "psu_cortexr5_0"
set proc "psu_cortexa53_0"
#set proc "microblaze_0"

setws ./workspace

platform create -name "standalone_plat"    -hw $hw -proc $proc -os standalone
#bsp setlib -name lwip211 -ver 1.6
#bsp setlib -name xilffs 
#bsp setlib -name xilsecure 
#bsp setlib -name xilpm
platform generate


app create -name uram_test -platform standalone_plat -domain standalone_domain -template "Empty Application(C)"
file link -symbolic ./workspace/uram_test/src/test.c    ../../../src/uram_test/test.c
file link -symbolic ./workspace/uram_test/src/fpga.h    ../../../src/fpga.h
#file link -symbolic ./workspace/uram_test/src/platform.c            ../../../src/uram_test/platform.c
#file link -symbolic ./workspace/uram_test/src/platform.h            ../../../src/uram_test/platform.h
#file link -symbolic ./workspace/uram_test/src/platform_config.h     ../../../src/uram_test/platform_config.h


app build all


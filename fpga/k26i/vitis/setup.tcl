# run at linux command line 
#       xsct setup.tcl
#       vitis --workspace ./workspace
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
#bsp config stdout "usb_uartlite"
#bsp config stdin  "usb_uartlite"
platform generate


app create -name uram_test -platform standalone_plat -domain standalone_domain -template "Empty Application(C)"
file link -symbolic ./workspace/uram_test/src/test.c                ../../../src/uram_test/test.c
file link -symbolic ./workspace/uram_test/src/platform.c            ../../../src/uram_test/platform.c
file link -symbolic ./workspace/uram_test/src/platform.h            ../../../src/uram_test/platform.h
file link -symbolic ./workspace/uram_test/src/platform_config.h     ../../../src/uram_test/platform_config.h

#app create -name ts_test -platform standalone_plat -domain standalone_domain -template "Empty Application(C)"
#file link -symbolic ./workspace/ts_test/src/test.c ../../../src/ts_test/test.c
#file link -symbolic ./workspace/ts_test/src/fpga.h ../../../src/fpga.h
#file link -symbolic ./workspace/ts_test/src/platform.c ../../../src/sensor_test/platform.c
#file link -symbolic ./workspace/ts_test/src/platform.h ../../../src/sensor_test/platform.h
#file link -symbolic ./workspace/ts_test/src/platform_config.h ../../../src/sensor_test/platform_config.h
#file delete -force  ./workspace/ts_test/src/lscript.ld
#file link -symbolic ./workspace/ts_test/src/lscript.ld   ../../../src/ts_test/lscript.ld


#app create -name lwip_echo -platform standalone_plat -domain standalone_domain -template "Empty Application(C)"
#file link -symbolic ./workspace/lwip_echo/src/main.c                ../../../src/lwip_echo/main.c
#file link -symbolic ./workspace/lwip_echo/src/echo.c                ../../../src/lwip_echo/echo.c
#file link -symbolic ./workspace/lwip_echo/src/i2c_access.c          ../../../src/lwip_echo/i2c_access.c
#file link -symbolic ./workspace/lwip_echo/src/iic_phyreset.c        ../../../src/lwip_echo/iic_phyreset.c
#file link -symbolic ./workspace/lwip_echo/src/platform.c            ../../../src/lwip_echo/platform.c
#file link -symbolic ./workspace/lwip_echo/src/platform.h            ../../../src/lwip_echo/platform.h
#file link -symbolic ./workspace/lwip_echo/src/platform_mb.c         ../../../src/lwip_echo/platform_mb.c
#file link -symbolic ./workspace/lwip_echo/src/platform_config.h     ../../../src/lwip_echo/platform_config.h
#file link -symbolic ./workspace/lwip_echo/src/sfp.c                 ../../../src/lwip_echo/sfp.c
#file link -symbolic ./workspace/lwip_echo/src/si5324.c              ../../../src/lwip_echo/si5324.c
#file delete  -force ./workspace/lwip_echo/src/lscript.ld
#file link -symbolic ./workspace/lwip_echo/src/lscript.ld            ../../../src/lwip_echo/lscript.ld


#app create -name ddr_test -platform standalone_plat -domain standalone_domain -template "Empty Application(C)"
#file link -symbolic ./workspace/ddr_test/src/ddr_test.c     ../../../src/ddr_test/ddr_test.c
#file delete  -force ./workspace/ddr_test/src/lscript.ld
#file link -symbolic ./workspace/ddr_test/src/lscript.ld     ../../../src/ddr_test/lscript.ld


#app create -name UartLiteLowLevelExample -platform standalone_plat -domain standalone_domain -template "Empty Application(C)"
#file link -symbolic ./workspace/UartLiteLowLevelExample/src/xuartlite_low_level_example.c ../../../src/UartLiteLowLevelExample/xuartlite_low_level_example.c


#app create -name sensor_test -platform standalone_plat -domain standalone_domain -template "Empty Application(C)"
#file link -symbolic ./workspace/sensor_test/src/sensor_test.c ../../../src/sensor_test/sensor_test.c
#file link -symbolic ./workspace/sensor_test/src/fpga.h ../../../src/fpga.h
#file link -symbolic ./workspace/sensor_test/src/platform.c ../../../src/sensor_test/platform.c
#file link -symbolic ./workspace/sensor_test/src/platform.h ../../../src/sensor_test/platform.h
#file link -symbolic ./workspace/sensor_test/src/platform_config.h ../../../src/sensor_test/platform_config.h


#app create -name hello1 -platform standalone_plat -domain standalone_domain -template "Empty Application(C)"
#file link -symbolic ./workspace/hello1/src/helloworld.c ../../../src/hello1/helloworld.c
#file link -symbolic ./workspace/hello1/src/platform.c ../../../src/hello1/platform.c
#file link -symbolic ./workspace/hello1/src/platform.h ../../../src/hello1/platform.h
#file link -symbolic ./workspace/hello1/src/platform_config.h ../../../src/hello1/platform_config.h

app build all


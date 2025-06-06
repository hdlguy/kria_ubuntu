#set_property IOSTANDARD  LVCMOS33 [get_ports "som240_1_c24"]; # Net name HDA20
#set_property DRIVE 4   [get_ports "som240_1_c24"]; # Net name HDA20
#set_property SLEW SLOW [get_ports "som240_1_c24"]; # Net name HDA20
#set_property PACKAGE_PIN A12      [get_ports "som240_1_c24"] ;# Bank  45 VCCO - som240_1_b13 - IO_L11P_AD9P_45

set_property IOSTANDARD  LVCMOS33   [get_ports "fan_pwm"]; # Net name HDA20
set_property DRIVE 4                [get_ports "fan_pwm"]; # Net name HDA20
set_property SLEW SLOW              [get_ports "fan_pwm"]; # Net name HDA20
set_property PACKAGE_PIN A12        [get_ports "fan_pwm"] ;# Bank  45 VCCO - som240_1_b13 - IO_L11P_AD9P_45
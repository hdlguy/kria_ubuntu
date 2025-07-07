
set_property IOSTANDARD  LVCMOS33   [get_ports "fan_pwm"]
set_property DRIVE 4                [get_ports "fan_pwm"]
set_property SLEW SLOW              [get_ports "fan_pwm"]
set_property PACKAGE_PIN A12        [get_ports "fan_pwm"]

set_property IOSTANDARD  LVCMOS33   [get_ports "pmod[*]"];
set_property PACKAGE_PIN H12        [get_ports "pmod[1]"]
set_property PACKAGE_PIN B10        [get_ports "pmod[5]"]
set_property PACKAGE_PIN E10        [get_ports "pmod[2]"]
set_property PACKAGE_PIN E12        [get_ports "pmod[6]"]
set_property PACKAGE_PIN D10        [get_ports "pmod[3]"]
set_property PACKAGE_PIN D11        [get_ports "pmod[7]"]
set_property PACKAGE_PIN C11        [get_ports "pmod[4]"]
set_property PACKAGE_PIN B11        [get_ports "pmod[8]"]

#set_property IOSTANDARD LVCMOS33 [get_ports {led[*]}]
## put leds on PMOD connector for now. There are no LEDs on the carrier board.
#set_property PACKAGE_PIN C11 [get_ports {led[3]}]
#set_property PACKAGE_PIN D10 [get_ports {led[2]}]
#set_property PACKAGE_PIN E10 [get_ports {led[1]}]
#set_property PACKAGE_PIN H12 [get_ports {led[0]}]


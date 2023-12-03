# xsct sd_boot.tcl
connect
targets -set -filter {name =~ "PSU"}
stop

puts "Switch to SD1 bootmode"
# update multiboot to ZERO
mwr 0xffca0010 0x0
# change boot mode to SD
mwr 0xff5e0200 0x5100
# reset
rst -system
    
#Sometimes A53 may be held in reset catch .. so start it with "con"
after 2000
con

puts "Done!!"

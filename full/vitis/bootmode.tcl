#
    #proc set_bootmode {bootmode} {

        #set bootmode "jtag"
        set bootmode "sd"
        connect
        targets -set -filter {name =~ "PSU"}
        stop
        if {$bootmode == "jtag"} {
            puts "Switch to JTAG bootmode"
            targets -set -nocase -filter {name =~ "PSU"}
            stop
            # update multiboot to ZERO
            mwr 0xffca0010 0x0
            # change boot mode to JTAG
            mwr 0xff5e0200 0x0100
            # reset
            rst -system
        } elseif {$bootmode == "sd"} {
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
        } else {
            puts "Unsupported bootmode $bootmode"
        }
     
        puts "Done!!"

        #targets 5
        #rst -por

    #}


# Ubuntu on Kria Vision AI Development Kit
This kit is sold with a non-standard Kria module that has the QSPI flash set as the only boot device and write protected.  This means that the kit cannot be booted in the standard way. Luckily, Xilinx and Ubuntu provide a boot image that can just be copied to an SD card to boot full Ubuntu Desktop Linux.

## Prepare SD Card

Look here:

        https://www.xilinx.com/products/som/kria/kv260-vision-starter-kit/kv260-getting-started-ubuntu/setting-up-the-sd-card-image.html

Get the image:

        wget https://people.canonical.com/~platform/images/xilinx/kria/iot-kria-classic-desktop-2004-x03-20211110-98.img.xz

Get Balena Etcher (It looks legitimate):

        https://www.balena.io/etcher/

and write the image to your SD card.

## Connect and Boot

Connect the usb, ethernet and power cables. 

Open a terminal emulator.  I like putty.

    sudo putty

port = /dev/ttyUSB1, baud = 115200, 8-none-1


You will get a login prompt, username=ubuntu, password=ubuntu. It will force you to change your password to something strong. You can change it again later to something easier.

It is a good idea to create a user for yourself and give it sudoer privileges.

    adduser myuser
    usermod -aG sudo myuser

I like to ssh into the board. 

Using the terminal, find the ip address of the zcu104.

    ip address

    ssh myuser@<ip address>

You can update Ubuntu

    sudo apt update
    sudo apt upgrade

You can start installing things.

    sudo apt install man
    sudo apt install subversion
    sudo apt intall git

## Load and Test an FPGA design

Configure the PL side of the Zynq with an FPGA design. On the Kria do this stuff:

    mkdir ~/github

    cd ~/github

    git clone https://github.com/hdlguy/kria_ubuntu.git

    cp ~/github/kria_ubuntu/fpga/implement/results/top.bit.bin /lib/firmware (You may have to create /lib/firmware.)

    sudo su

    echo top.bit.bin > /sys/class/fpga_manager/fpga0/firmware

    exit
    
    cd ~/github/kria_ubuntu/software/apps/bram_test

    make

    sudo ./test

You should get something like this printing the ID and Version registers of the FPGA design and testing the bram.

pedro@kria:~/github/kria_ubuntu/software/apps/bram_test$ sudo ./test
@phy_addr_2_vir_addr:52, phy_addr 0xa0000000 mapped to 0x0xffff8ba69000 with size=0x2000000 bytes
phy_addr 0xa0000000 with size 0x02000000 to viraddr 0x0xffff8ba69000.
FPGA ID: 0xDEADBEEF
VERSION: 0x76543210
bram_ptr = 0xffff8ba79000
errors = 0



Good luck.




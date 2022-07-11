## One Time BSP Creation

petalinux-create --force --type project --template zynqMP --name bspproj

cp ./system-user.dtsi ./bspproj/project-spec/meta-user/recipes-bsp/device-tree/files/system-user.dtsi

cd bspproj/
petalinux-config --get-hw-description ../../implement/results/

        * Under "Image Packaging Configuration" -> "Root filesystem type" -> Select "SD Card"
        * Under "Image Packaging Configuration" -> "Device Node of SD Device" -> Change to mmcblk1p2
    
        * Under "Subsystem AUTO Hardware Settings" -> "Advanced bootable images storage Settings" -> "u-boot env partition settings" -> "image storage media" -> Select "primary sd"
        * Under "Subsystem AUTO Hardware Settings" -> "SD/SDIO Settings"  -> "Primary SD/SDIO" -> Select "psu_sd_1"
    
        * Save and exit the configuration menu. Wait for configuration to complete.

    cd ..
    petalinux-package --bsp -p bspproj/ --output uzed.bsp

## Petalinux Build Project

petalinux-create --force --type project --template zynqMP --source ./uzed.bsp --name proj1

cp ./system-user.dtsi ./bspproj/project-spec/meta-user/recipes-bsp/device-tree/files/system-user.dtsi

cd proj1

petalinux-config --silentconfig --get-hw-description=../../implement/results/

petalinux-config

        Yocto Settings --> Add pre-mirror url  ---> change "http:// ..." to "https :// ..."
        Yocto Settings --> Network sstate feeds URL ---> change "http:// ..." to "https :// ..."

petalinux-build -c device-tree -x cleansstate
petalinux-build -c device-tree
petalinux-build -c bootloader -x distclean
petalinux-build

petalinux-package --force --boot --u-boot --kernel --fpga ../../implement/results/top.bit

    BOOT.BIN contains the ATF, PMUFW, FSBL, U-Boot.
    image.ub contains the device tree and Linux kernel.

    ### Copy the boot files to the SD card.

cp images/linux/BOOT.BIN /media/pedro/BOOT/
cp images/linux/image.ub /media/pedro/BOOT/
cp images/linux/boot.scr /media/pedro/BOOT/

    It is assumed that you already partitioned the SD card.
        - sudo gparted  (make sure you have the correct drive selected!)
        - First partition called BOOT, FAT32, 512MB
        - Second partition called rootfs, ext4, use the rest of the card.

## Get the Root Filesystem

    wget https://releases.linaro.org/debian/images/developer-arm64/latest/linaro-stretch-developer-20180416-89.tar.gz

    sudo tar --preserve-permissions -zxvf linaro-stretch-developer-20180416-89.tar.gz

    sudo cp --recursive --preserve binary/* /media/pedro/rootfs/; sync



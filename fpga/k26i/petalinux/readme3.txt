petalinux-create --force --type project --template zynqMP --name proj1

#cp ./system-user.dtsi ./bspproj/project-spec/meta-user/recipes-bsp/device-tree/files/system-user.dtsi

cd proj1/
petalinux-config --silentconfig --get-hw-description ../../implement/results/

        # Under "Image Packaging Configuration" -> "Root filesystem type" -> Select "SD Card"
        # Under "Image Packaging Configuration" -> "Device Node of SD Device" -> Change to mmcblk1p2
    
        # Under "Subsystem AUTO Hardware Settings" -> "Advanced bootable images storage Settings" -> "u-boot env partition settings" -> "image storage media" -> Select "primary sd"
        # Under "Subsystem AUTO Hardware Settings" -> "SD/SDIO Settings"  -> "Primary SD/SDIO" -> Select "psu_sd_1"
    
        # Yocto Settings --> Add pre-mirror url  ---> change "http:// ..." to "https :// ..."
        # Yocto Settings --> Network sstate feeds URL ---> change "http:// ..." to "https :// ..."

        # Save and exit the configuration menu. Wait for configuration to complete.

petalinux-build

#petalinux-package --force --boot --u-boot --kernel --fpga ../../implement/results/top.bit
petalinux-package --force --boot --u-boot --kernel --offset 0xF40000 --fpga ../../implement/results/top.bit

cp images/linux/BOOT.BIN /media/pdudley/BOOT/
cp images/linux/image.ub /media/pdudley/BOOT/
cp images/linux/boot.scr /media/pdudley/BOOT/

    #or

petalinux-boot --jtag --prebuilt 3 --hw_server-url TCP:127.0.0.1:3121

    #or

petalinux-boot --jtag --kernel --bitstream ../../implement/results/top.bit --hw_server-url TCP:127.0.0.1:3121

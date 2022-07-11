# open https://petalinux.xilinx.com/ in a web browser

petalinux-create --force --type project --template zynqMP --name proj1

cp ./system-user.dtsi ./proj1/project-spec/meta-user/recipes-bsp/device-tree/files/system-user.dtsi

cd proj1/
petalinux-config --get-hw-description ../../implement/results/

        # Under "Image Packaging Configuration" -> "Root filesystem type" -> Select "SD Card"
    
        # Yocto Settings --> Add pre-mirror url  ---> change "http:// ..." to "https :// ..."
        # Yocto Settings --> Network sstate feeds URL ---> change "http:// ..." to "https :// ..."

        # Save and exit the configuration menu. Wait for configuration to complete.

petalinux-build -c device-tree -x cleansstate
petalinux-build -c device-tree
petalinux-build -c bootloader -x distclean
petalinux-build

# petalinux-build --execute mrproper
# petalinux-build

petalinux-package --force --boot --u-boot --kernel --offset 0xF40000 --fpga ../../implement/results/top.bit

cp images/linux/BOOT.BIN /media/pedro/BOOT/
cp images/linux/image.ub /media/pedro/BOOT/
cp images/linux/boot.scr /media/pedro/BOOT/







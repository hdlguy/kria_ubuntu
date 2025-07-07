
# Petalinux (2025.1) on Kria K26
In order to boot directly from the SD card R162 and R163 were removed from the carrier card.

## Download and uncompress sstate artifacts
I find that the compile time download from petalinux.xilinx.com is just unreliable. The trick is to have those files local. Then, in petalinux-config we point to the local files.

https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/embedded-design-tools.html
    * Downloads (TAR/GZIP - 61.27 GB) 
    * sstate_aarch64 (TAR/GZIP - 33.95 GB) 

## Convert XSA to SDT
rm -rf ./sdt/; /tools/Xilinx/2025.1/Vitis/bin/sdtgen -eval "set_dt_param -dir ./sdt -xsa ../implement/results/top.xsa -user_dts ./system-user.dtsi; generate_sdt;"

### Create Petalinux project
petalinux-create project --template zynqMP --name proj1
cd proj1



### configure project from hardware
petalinux-config --get-hw-description=../sdt/

    * Image Packaging Configuration -> Root Filesystem Type -> EXT4                         (if you want a persistent rootfs)
    * Image Packaging Configuration -> Device node of SD device -> mmcblk1p2                (if you have the eMMC device enabled in Vivado IPI)
    * Subsystem Auto Hardware Settings -> SD/SDIO Settings -> Primary SD/SDIO -> sdhci1     (if you have the eMMC device enabled in Vivado IPI)
    * DTG Settings -> Kernel Bootargs -> manual bootargs -> earlycon console=ttyPS0,115200 root=/dev/mmcblk1p2 rw rootwait clk_ignore_unused (mmc 1, rw, clk_ignore_unused)

    * Yocto Settings -> Local sstate feeds settings -> local sstate feeds url ->    file://~/Downloads/xilinx/petalinux/sstate_download_2025_1/aarch64/
    * Yocto Settings -> Add pre-mirror url ->                                       file://~/Downloads/xilinx/petalinux/mirror_download_2025_1/downloads/

    * save and exit

### Build the bootloader
petalinux-build -c bootloader -x distclean

### Configure the kernel
petalinux-config -c kernel --silentconfig

### Build
petalinux-build

### Package 
petalinux-package boot --force --u-boot --fpga

    * Use this to just update the bitfile.

petalinux-package boot --force --u-boot --fpga ../../implement/results/top.bit

    * This for u-boot only

petalinux-package boot --force --fsbl --pmufw --u-boot --fpga

### Copy to SD Card
rm /media/pedro/BOOT/*; cp images/linux/BOOT.BIN /media/pedro/BOOT/; cp images/linux/image.ub /media/pedro/BOOT/; cp images/linux/boot.scr /media/pedro/BOOT/; sync

### Trick Kria u-boot to reboot from SD card
setenv oldbootcmd 'setenv model $board_name; setexpr model gsub ".*${k24_starter}.*" starter; setexpr model gsub ".*${k26_starter}.*" starter; if test ${model} = "starter"; then run som_cc_boot; else run som_bootmenu; fi # Boot menu'
setenv sdbootcmd 'mw.l 00ff5e0200 0000e100 1; mw.l 00ff5e0218 00000010 1'
setenv bootcmd 'run sdbootcmd'
saveenv
boot



# kria_ubuntu
This is a project to demonstrate Xilinx Kria running Ubuntu.  The Xilinx Multi-Processor System On Chip (MPSOC) devices provide agile solutions to a large class of problems.

## Goals
- **Create a simple FPGA Design** - See the readme under fpga for instructions.  There is a block ram and a register file that can be accessed from a program running under Ubuntu Linux.
- **Install Ubuntu Linux on the Kria Vision AI dev kit** - Look at software/ubuntu/readme.md
- **Demonstrate basic access to FPGA features from Linux** - Look in software/app/bram_test.

## Stretch Goals
- **Boot Petalinux directly from the SD card using a debootstrap filesystem.

## Files
    - source - fpga source
    - implement  - fpga compilation project
    - petalinux  - petalinux build instructions
    - ubuntu - instructions to run Ubuntu via the Xilinx wic flow
    - vitis - Vitis bare metal C projects
    - apps  - C applications that can be run under linux on the Kria


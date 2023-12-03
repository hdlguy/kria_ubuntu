# Notes on FPGA Compilation
These instructions assume you are working from a supported Linux distribution.  I use Ubutu 20.04 LTS.

## Install some dependencies
    sudo apt update
    sudo apt upgrade
    sudo apt install libncurses5
    sudo apt install libtinfo5
    sudo apt install libncurses5-dev libncursesw5-dev
    sudo apt install ncurses-compat-libs  (I think this one fails. Don't worry about it.)

## Install Vivado
- Download the latest Xilinx_Unified_2021.2_1021_0703.tar.gz (72GB)
- tar -zxvf Xilinx_Unified_2021.2_1021_0703.tar.gz
- cd Xilinx_Unified_2021.2_1021_0703/
- sudo ./xsetup

Set the environment variables. I put these in a shell script for convenience.
- source /opt/Xilinx/Vivado/2021.2/settings64.sh; source /opt/Xilinx/Vitis/2021.2/settings64.sh

## Setup the Project
- cd .../fpga/implement
- vivado -mode batch -source setup.tcl
- That last step creates a Vivado project ready to compile, "proj.xpr"

## Compile the FPGA
- vivado -mode batch -source compile.tcl
- That last step runs Vivado in "project flow" to write the needed output files and reports.
- ls -lh ./results

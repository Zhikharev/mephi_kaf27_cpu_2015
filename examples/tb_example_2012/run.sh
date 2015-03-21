# script for import c functions to SV using DPI
# !/bin/bash
vlib work
vmap work work
#gcc -shared -o hello.so hello.c                  #compile C-code
gcc -fPIC -shared -o proc.so cmd_mcu.c mainfile.c
vlog -sv top.sv                                   #compile SV-code
vsim -c  top -sv_lib proc -novopt  -do 'run -all'        #link and load




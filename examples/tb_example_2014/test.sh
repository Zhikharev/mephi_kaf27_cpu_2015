#!/bin/bash
vlib work
vmap work work
vlog rtl.inc.v tb.inc.sv
vsim top -novopt -c -do 'run -all' -l test.log

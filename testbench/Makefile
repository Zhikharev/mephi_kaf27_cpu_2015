# Exports
export LM_LICENSE_FILE=/opt/questasim_v6.6c/license.dat

# Environment variables
MTI_HOME = /opt/questasim_v6.6c/questasim

# Main path variables
HOME       := $(shell pwd)
RTL         = $(RTL_HOME)
TB          = $(HOME)/testbench
RUN         = $(TB)/run

# RTL and SV files
RTL_SRC    = $(TB)/rtl.inc.v
SV_SRC     = $(TB)/tb.inc.sv
TOP_MODULE = testbench 

SEED = random
SIM_OPTS='-c'


# Make all (default)
all: build_rtl build_tb sim

# Do simulation
sim: 
	cd $(RUN);                     \
	vsim  -novopt                  \
		  -l $(TESTNAME).log       \
		  -sv_seed $(SEED)         \
		  -do 'run -all'           \
		  -l run.log               \
		  $(SIM_OPTS)              \
		  $(TOP_MODULE);


# Making all SystemVerilog code 
build_tb: 
	cd $(RUN);             \
	vlib work;             \
	vmap work work;        \
	vlog -sv               \
	-l build_sv.log        \
	+incdir+$(TB)          \
	$(SV_SRC);

# Making all Verilog code
build_rtl:
	echo $(RTL);          \
	cd $(RUN);            \
	vlib work;            \
	vmap work work;       \
	vlog                  \
	-l build_rtl.log     \
	+incdir+$(RTL)        \
	+incdir+$(TB)/verilog \
	$(RTL_SRC);


# Cleaning project files
.PHONY: clean
clean:
	rm -rf  $(RUN)/*
	rm -f .mod*
	rm -rf .ht*


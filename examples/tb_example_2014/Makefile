# Exports
export LM_LICENSE_FILE=/opt/questasim_v6/license.dat

# Environment variables
MTI_HOME = /opt/questasim_v6/questasim

# Main path variables
HOME       := $(shell pwd)
RTL         = $(HOME)/rtl
TB          = $(HOME)/testbench
TB_NAME     = pad
RUN         = $(TB)/$(TB_NAME)/run

# RTL and SV files
RTL_SRC    = $(TB_NAME)/verilog/rtl.inc.v
SV_SRC     = $(TB_NAME)/tb.inc.sv
TOP_MODULE = pad_top 

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


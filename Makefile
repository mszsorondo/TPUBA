# vhdl files
FILES = src/VHDL/systolic_node.vhd src/VHDL/systolic_array_pkg.vhd src/VHDL/systolic_array.vhd
DUT:=systolic_array

# testbench
TESTBENCHFILE = ${DUT}_tb
TESTBENCHPATH = src/VHDL/testbenches/${TESTBENCHFILE}.vhd

#GHDL CONFIG

GHDL_FLAGS  = --ieee=standard --warn-no-vital-generic
SIMDIR = simulation
STOP_TIME = 1ms

# Simulation break condition

#GHDL_SIM_OPT = --assert-level=error
GHDL_SIM_OPT = --stop-time=$(STOP_TIME)

.PHONY: clean compile run

all: setup compile run view

setup:
	@mkdir -p $(SIMDIR)

compile: setup

	ghdl -a $(GHDL_FLAGS) --workdir=$(SIMDIR) --work=work $(FILES) $(TESTBENCHPATH)
	ghdl -e $(GHDL_FLAGS) --workdir=$(SIMDIR) --work=work $(TESTBENCHFILE)

run:
	ghdl -r --workdir=$(SIMDIR) $(TESTBENCHFILE) --wave=$(SIMDIR)/$(TESTBENCHFILE).ghw $(GHDL_SIM_OPT)

view:
	gtkwave --autosavename --saveonexit $(SIMDIR)/$(TESTBENCHFILE).ghw

clean:
	@rm -rf $(SIMDIR) *.o
# Makefile
SIM ?= icarus
TOPLEVEL_LANG ?= verilog

VERILOG_SOURCES += $(PWD)/../player/tt_um_audio_player.v
VERILOG_SOURCES += $(PWD)/../player/player.v
VERILOG_SOURCES += $(PWD)/../player/audio_lookup_table.v
VERILOG_SOURCES += $(PWD)/tb.v

TOPLEVEL = tb_audio_player
MODULE = test

include $(shell cocotb-config --makefiles)/Makefile.sim

# Simulation settings
IVERILOG_OPTS = -I$(SRC_DIR) -I$(VERILOG_DIR) -DSIMULATION
VVP_OPTS = -N
WAVES = tb.vcd

.PHONY: all sim wave clean check

all: sim

sim: $(WAVES)

$(WAVES): tb.vvp
	vvp $(VVP_OPTS) $< +vcd=$@

tb.vvp: $(VERILOG_SOURCES)
	@echo "Compiling Verilog sources..."
	iverilog $(IVERILOG_OPTS) -o $@ $(VERILOG_SOURCES)

wave: $(WAVES)
	@echo "Opening waveform viewer..."
	code $(WAVES)

clean:
	rm -rf *.vvp *.vcd *.fst *.lxt *.txt waves/ *.gtkw

check:
	@echo "Checking source files..."
	@for file in $(VERILOG_SOURCES); do \
		if [ -f $$file ]; then \
			echo "Found: $$file"; \
		else \
			echo "Missing: $$file"; \
		fi \
	done

# Print debug info
debug:
	@echo "Source directory: $(SRC_DIR)"
	@echo "Verilog directory: $(VERILOG_DIR)"
	@echo "Verilog sources: $(VERILOG_SOURCES)"

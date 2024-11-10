# Directories
SRC_DIR = $(PWD)/../src
VERILOG_DIR = $(SRC_DIR)/verilog

# Source files
VERILOG_SOURCES = \
    $(SRC_DIR)/tt_um_audio_player.v \
    $(VERILOG_DIR)/player.v \
    $(VERILOG_DIR)/audio_lookup_table.v \
    tb.v

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

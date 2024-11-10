# Makefile
SIM ?= icarus
TOPLEVEL_LANG ?= verilog

# Source files
VERILOG_SOURCES += $(PWD)/../player/tt_um_audio_player.v
VERILOG_SOURCES += $(PWD)/../player/player.v
VERILOG_SOURCES += $(PWD)/../player/audio_lookup_table.v
VERILOG_SOURCES += $(PWD)/tb.v

# Test configuration
TOPLEVEL = tb_audio_player
MODULE = test

# Includes
EXTRA_ARGS += -I$(PWD)/../player

# Include cocotb makefile
include $(shell cocotb-config --makefiles)/Makefile.sim

# Additional targets
.PHONY: all clean wave

wave: tb.vcd
	gtkwave $< &

clean::
	rm -rf *.vcd *.xml sim_build __pycache__ results.xml
	find . -name "*.pyc" -delete

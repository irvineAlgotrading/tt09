# Makefile
SIM ?= icarus
TOPLEVEL_LANG ?= verilog

# Source files - update paths to match src/player structure
VERILOG_SOURCES += $(PWD)/../src/player/tt_um_audio_player.v
VERILOG_SOURCES += $(PWD)/../src/player/player.v
VERILOG_SOURCES += $(PWD)/../src/player/audio_lookup_table.v
VERILOG_SOURCES += $(PWD)/tb.v

# Test configuration
TOPLEVEL = tb_audio_player
MODULE = test

# Include cocotb makefile with defaults
include $(shell cocotb-config --makefiles)/Makefile.sim

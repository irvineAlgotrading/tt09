# Makefile
SIM ?= icarus
TOPLEVEL_LANG ?= verilog

VERILOG_SOURCES += $(PWD)/../player/tt_um_audio_player.v
VERILOG_SOURCES += $(PWD)/../player/player.v
VERILOG_SOURCES += $(PWD)/../player/audio_lookup_table.v
VERILOG_SOURCES += $(PWD)/tb.v

# Test configuration
TOPLEVEL = tb_audio_player
MODULE = test

# Include cocotb makefile
include $(shell cocotb-config --makefiles)/Makefile.sim

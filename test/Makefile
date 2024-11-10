# Makefile
SIM ?= icarus
TOPLEVEL_LANG ?= verilog
PYTHON_BIN ?= python3

# Check if COCOTB_SHARE_DIR is defined by cocotb installation
ifeq ($(shell cocotb-config --share 2>/dev/null),)
$(error "cocotb is not installed. Please run 'pip install cocotb cocotb-test pytest' first")
endif

# Source files
VERILOG_SOURCES += $(PWD)/../player/tt_um_audio_player.v
VERILOG_SOURCES += $(PWD)/../player/player.v
VERILOG_SOURCES += $(PWD)/../player/audio_lookup_table.v
VERILOG_SOURCES += $(PWD)/tb.v

TOPLEVEL = tb_audio_player
MODULE = test

# Debug info
$(info VERILOG_SOURCES = $(VERILOG_SOURCES))
$(info TOPLEVEL = $(TOPLEVEL))
$(info MODULE = $(MODULE))

# Include cocotb's makefile
include $(shell cocotb-config --makefiles)/Makefile.sim

# Additional debug targets
debug:
	@echo "Checking source files..."
	@for file in $(VERILOG_SOURCES); do \
		if [ -f $$file ]; then \
			echo "Found: $$file"; \
		else \
			echo "Missing: $$file"; \
		fi \
	done

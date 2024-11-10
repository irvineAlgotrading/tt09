# Makefile for TinyTapeout Audio Player Project

# Directory structure
SRC_DIR = src
VERILOG_DIR = $(SRC_DIR)/player
GEN_DIR = $(SRC_DIR)/generator
TEST_DIR = test

# Source files
WAV_FILE = $(GEN_DIR)/audiohifi.wav
LOOKUP_TABLE_V = $(VERILOG_DIR)/audio_lookup_table.v
LOOKUP_TABLE_HEX = $(VERILOG_DIR)/audio_data.hex
TOP_V = $(VERILOG_DIR)/tt_um_audio_player.v
PLAYER_V = $(VERILOG_DIR)/player.v

# Verilog sources for simulation
VERILOG_SOURCES = $(TOP_V) $(PLAYER_V) $(LOOKUP_TABLE_V) $(TEST_DIR)/tb.v

# Test files
TB_V = $(TEST_DIR)/tb.v
VCD_FILE = tb.vcd
VVP_FILE = $(TEST_DIR)/tb.vvp

# Tools
IVERILOG = iverilog
VVP = vvp
PYTHON = python3
GTKWAVE = gtkwave

# Default target
all: generate simulate wave

# Generate Verilog and hex files from WAV
.PHONY: generate
generate: $(LOOKUP_TABLE_V) $(LOOKUP_TABLE_HEX)
	@echo "Audio files generated"

$(LOOKUP_TABLE_V) $(LOOKUP_TABLE_HEX): $(WAV_FILE) $(GEN_DIR)/convert_wav_to_hex.py
	@echo "Generating audio lookup table..."
	@cd $(GEN_DIR) && \
	$(PYTHON) convert_wav_to_hex.py \
		audiohifi.wav \
		$(abspath $(LOOKUP_TABLE_HEX)) \
		$(abspath $(LOOKUP_TABLE_V))
	@cp $(LOOKUP_TABLE_HEX) $(TEST_DIR)/audio_data.hex
	@echo "Generated audio files successfully"

# Simulation targets
.PHONY: simulate
simulate: $(VVP_FILE)
	@echo "Running simulation..."
	$(VVP) $(VVP_FILE)

$(VVP_FILE): $(VERILOG_SOURCES)
	@echo "Compiling Verilog files..."
	$(IVERILOG) -o $@ $^

# View waveform
.PHONY: wave
wave: $(VCD_FILE)
	@echo "Opening waveform viewer..."
	code $(VCD_FILE)

# Run python tests if they exist
.PHONY: test
test: generate
	@if [ -f "$(TEST_DIR)/test.py" ]; then \
		cd $(TEST_DIR) && $(PYTHON) test.py; \
	else \
		echo "No Python tests found"; \
	fi

# Clean up generated files
.PHONY: clean
clean:
	# Remove lookup table files
	rm -f $(LOOKUP_TABLE_V) $(LOOKUP_TABLE_HEX)
	# Remove hex file from test directory
	rm -f $(TEST_DIR)/audio_data.hex
	# Remove VVP and VCD files
	rm -f $(VVP_FILE) $(VCD_FILE)
	# Remove Python cache files
	rm -rf $(TEST_DIR)/__pycache__
	rm -f $(TEST_DIR)/*.pyc
	# Remove results.xml
	rm -f results.xml

# Show help
.PHONY: help
help:
	@echo "Available targets:"
	@echo "  all        - Generate audio files, run simulation, and show waveform"
	@echo "  generate   - Generate Verilog and hex files from WAV"
	@echo "  simulate   - Run Verilog simulation"
	@echo "  wave      - View waveform in VSCode"
	@echo "  test       - Run Python tests if they exist"
	@echo "  clean      - Remove generated files"
	@echo "  help       - Show this help message"

# Prevent make from deleting intermediate files
.PRECIOUS: $(LOOKUP_TABLE_V) $(LOOKUP_TABLE_HEX)

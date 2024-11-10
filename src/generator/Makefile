# Paths
VERILOG_DIR = ../verilog

# Files
WAV_FILE = audiohifi.wav
HEX_FILE = $(VERILOG_DIR)/audio_data.hex
VERILOG_FILE = $(VERILOG_DIR)/audio_lookup_table.v

.PHONY: all clean check

all: $(HEX_FILE) $(VERILOG_FILE)

$(HEX_FILE) $(VERILOG_FILE): $(WAV_FILE) convert_wav_to_hex.py
	@echo "Converting WAV to Verilog and hex files..."
	python3 convert_wav_to_hex.py $(WAV_FILE) $(HEX_FILE) $(VERILOG_FILE)

clean:
	rm -f $(HEX_FILE) $(VERILOG_FILE) audio_data.bin

check:
	@echo "Checking required files..."
	@if [ -f "$(WAV_FILE)" ]; then \
		echo "Found WAV file: $(WAV_FILE)"; \
	else \
		echo "Missing WAV file: $(WAV_FILE)"; \
	fi
	@if [ -f "convert_wav_to_hex.py" ]; then \
		echo "Found converter script"; \
	else \
		echo "Missing converter script"; \
	fi
	@echo "Output directory: $(VERILOG_DIR)"

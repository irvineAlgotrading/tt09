#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to check file
check_file() {
    local file=$1
    local desc=$2
    if [ ! -f "$file" ]; then
        echo -e "${RED}❌ $desc not found at: $file${NC}"
        return 1
    else
        echo -e "${GREEN}✓ Found $desc${NC}"
        return 0
    fi
}

# Function to create config.json if it doesn't exist
create_config() {
    cat > src/config.json << 'EOF'
{
  "DESIGN_NAME": "tt_um_audio_player",
  "VERILOG_FILES": [
    "src/player/tt_um_audio_player.v",
    "src/player/player.v",
    "src/player/audio_lookup_table.v"
  ],
  "TOP_MODULE": "tt_um_audio_player",
  "CLOCK_PORT": "clk",
  "CLOCK_NET": "clk",
  "CLOCK_PERIOD": "25",
  "FP_SIZING": "absolute",
  "DIE_AREA": "0 0 168.36 111.52",
  "FP_PIN_ORDER_CFG": "src/pin_order.cfg",
  "PL_BASIC_PLACEMENT": 0,
  "PL_TARGET_DENSITY": 0.45,
  "FP_CORE_UTIL": 45,
  "MAX_TRANSITION_CONSTRAINT": 1.0,
  "MAX_FANOUT_CONSTRAINT": 16,
  "RUN_HEURISTIC_DIODE_INSERTION": 1,
  "RUN_CVC": 1,
  "DESIGN_IS_CORE": 0
}
EOF
    echo -e "${GREEN}✓ Created config.json${NC}"
}

# Main process
echo -e "${YELLOW}Checking required files...${NC}"

# Check for audio files first
if ! check_file "src/player/audio_lookup_table.v" "Verilog lookup table"; then
    echo -e "${YELLOW}Running ttgen to generate audio files...${NC}"
    ttgen
fi

# Create or check config.json
if ! check_file "src/config.json" "Config file"; then
    echo -e "${YELLOW}Creating config.json...${NC}"
    create_config
fi

# Final verification
all_files_present=true
for file in "src/player/audio_lookup_table.v" "src/player/audio_data.hex" "src/config.json"; do
    if ! check_file "$file" "$(basename $file)"; then
        all_files_present=false
    fi
done

if [ "$all_files_present" = true ]; then
    echo -e "${GREEN}✓ All required files present. Starting hardening...${NC}"
    ./tt/tt_tool.py --harden --openlane2
else
    echo -e "${RED}❌ Missing required files. Please check the errors above.${NC}"
    exit 1
fi

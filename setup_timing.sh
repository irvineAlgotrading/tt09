#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Setting up timing constraints...${NC}"

# Create timing.sdc
cat > src/timing.sdc << 'EOF'
# Setting up main clock (2500ns period from your config)
create_clock -name clk -period 2500 [get_ports clk]

# Input delays
set_input_delay -clock clk -max 250 [all_inputs]
set_input_delay -clock clk -min 25 [all_inputs]

# Output delays
set_output_delay -clock clk -max 250 [all_outputs]
set_output_delay -clock clk -min 25 [all_outputs]

# Drive strength and loads
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 [all_inputs]
set_load 0.1 [all_outputs]

# False paths for reset
set_false_path -from [get_ports rst_n]
EOF

echo -e "${GREEN}✓ Created timing.sdc${NC}"

# Update config.json with SDC references
if [ -f src/config.json ]; then
    # Using sed to add SDC file references before the last closing brace
    sed -i '' '/"ROUTING_CORES": 8/i\
  "PNR_SDC_FILE": "src/timing.sdc",\
  "SIGNOFF_SDC_FILE": "src/timing.sdc",\
' src/config.json
    echo -e "${GREEN}✓ Updated config.json with SDC references${NC}"
else
    echo -e "${RED}❌ config.json not found${NC}"
    exit 1
fi

# Make sure OpenROAD is properly installed
if ! command -v openroad &> /dev/null; then
    echo -e "${YELLOW}Installing OpenROAD...${NC}"
    brew install openroad
fi

echo -e "${GREEN}✓ Setup complete! You can now run 'tthard' again.${NC}"

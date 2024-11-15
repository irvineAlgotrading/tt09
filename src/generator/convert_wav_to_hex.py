#!/usr/bin/env python3
import wave
import numpy as np
import sys
import os
from scipy import signal

def verify_file_output(filepath, expected_type=""):
    """
    Verify that a file exists and has content
    Returns: (bool, str) - (success, error message if any)
    """
    if not os.path.exists(filepath):
        return False, f"Error: {expected_type} file was not created at {filepath}"
    
    if os.path.getsize(filepath) == 0:
        return False, f"Error: {expected_type} file is empty at {filepath}"
        
    return True, ""

def convert_wav_to_hex(input_wav, output_hex, output_v, target_sample_rate=8000, max_duration_seconds=2):
    print(f"Converting {input_wav} to {output_hex} and {output_v}")
    print(f"Target sample rate: {target_sample_rate} Hz")
    print(f"Max duration: {max_duration_seconds} seconds")

    # Check input file exists
    if not os.path.exists(input_wav):
        raise FileNotFoundError(f"Input WAV file not found: {input_wav}")

    # Load WAV file
    with wave.open(input_wav, 'r') as wav:
        n_channels, sampwidth, framerate, n_frames, _, _ = wav.getparams()

        if n_channels != 1 or sampwidth != 2:
            print("Error: WAV file must be 16-bit mono.")
            sys.exit(1)

        frames = wav.readframes(n_frames)
        pcm_data = np.frombuffer(frames, dtype=np.int16)

    # Resample to lower rate
    if framerate != target_sample_rate:
        print(f"Resampling from {framerate}Hz to {target_sample_rate}Hz")
        samples = len(pcm_data)
        new_samples = int(samples * target_sample_rate / framerate)
        pcm_data = signal.resample(pcm_data, new_samples)
        pcm_data = np.int16(pcm_data)

    # Truncate to maximum duration
    max_samples = target_sample_rate * max_duration_seconds
    if len(pcm_data) > max_samples:
        print(f"Truncating to {max_duration_seconds} seconds")
        pcm_data = pcm_data[:max_samples]

    # Round up to nearest power of 2 for memory size
    memory_size = 1
    while memory_size < len(pcm_data):
        memory_size *= 2

    # Calculate address width needed for the memory size
    address_width = (memory_size - 1).bit_length()
    
    # Pad with zeros to reach power of 2
    if len(pcm_data) < memory_size:
        pcm_data = np.pad(pcm_data, (0, memory_size - len(pcm_data)))

    print(f"Final samples: {len(pcm_data)} (memory size: {memory_size})")
    print(f"Duration: {len(pcm_data)/target_sample_rate:.2f} seconds")
    print(f"Memory required: {memory_size * 2 / 1024:.1f} KB")

    # Create output directories
    os.makedirs(os.path.dirname(output_hex) or '.', exist_ok=True)
    os.makedirs(os.path.dirname(output_v) or '.', exist_ok=True)

    # Generate hex file
    print(f"Writing hex file to {output_hex}")
    try:
        with open(output_hex, 'w') as f:
            for sample in pcm_data:
                unsigned_sample = (sample + 32768) & 0xFFFF
                f.write(f"{unsigned_sample:04x}\n")
    except Exception as e:
        print(f"Error writing hex file: {str(e)}")
        sys.exit(1)

    # Verify hex file
    success, error = verify_file_output(output_hex, "HEX")
    if not success:
        print(error)
        sys.exit(1)

    # Generate Verilog lookup table
    print(f"Writing Verilog file to {output_v}")
    try:
        with open(output_v, 'w') as f:
            f.write("`default_nettype none\n\n")
            f.write("module audio_lookup_table (\n")
            f.write(f"    input wire [{address_width-1}:0] address,\n")
            f.write("    output reg [15:0] data_out\n")
            f.write(");\n\n")
            f.write(f"    reg [15:0] rom [0:{memory_size-1}];\n\n")
            f.write("    initial begin\n")
            f.write('        $readmemh("test/audio_data.hex", rom);\n')
            f.write("    end\n\n")
            f.write("    always @(*) begin\n")
            f.write(f"        if (address < {memory_size}) begin\n")
            f.write("            data_out = rom[address];\n")
            f.write("        end else begin\n")
            f.write("            data_out = 16'd0;\n")
            f.write("        end\n")
            f.write("    end\n\n")
            f.write("endmodule\n")
    except Exception as e:
        print(f"Error writing Verilog file: {str(e)}")
        sys.exit(1)

    # Verify Verilog file
    success, error = verify_file_output(output_v, "Verilog")
    if not success:
        print(error)
        sys.exit(1)

    print("Conversion complete!")
    print("Verifying output files...")
    
    # Final verification of both files
    print(f"HEX file size: {os.path.getsize(output_hex)} bytes")
    print(f"Verilog file size: {os.path.getsize(output_v)} bytes")
    
    if os.path.getsize(output_hex) > 0 and os.path.getsize(output_v) > 0:
        print("✓ Both files generated successfully!")
    else:
        print("⚠ Warning: One or more output files may be empty!")
        sys.exit(1)

if __name__ == "__main__":
    if len(sys.argv) != 4:
        print("Usage: python3 convert_wav_to_hex.py <input_wav> <output_hex> <output_v>")
        sys.exit(1)

    # Get arguments from command line
    input_wav = sys.argv[1]
    output_hex = sys.argv[2]
    output_v = sys.argv[3]

    # Settings
    SAMPLE_RATE = 16000    #quality
    MAX_DURATION = 1      # 1 second of audio

    try:
        convert_wav_to_hex(input_wav, output_hex, output_v, SAMPLE_RATE, MAX_DURATION)
    except Exception as e:
        print(f"Error during conversion: {str(e)}")
        sys.exit(1)

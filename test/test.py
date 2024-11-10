import os
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, Timer, ClockCycles
from cocotb.regression import TestFactory

async def run_test(dut):
    """Test the audio player"""
    
    # Create a 3.125MHz clock
    clock = Clock(dut.clk, 2500, units="ns")
    cocotb.start_soon(clock.start())

    # Reset values
    dut.rst_n.value = 0
    dut.ena.value = 0
    dut.ui_in.value = 0
    dut.uio_in.value = 0

    # Wait 10 clock cycles
    await ClockCycles(dut.clk, 10)

    # Take design out of reset
    dut.rst_n.value = 1
    await ClockCycles(dut.clk, 1)
    
    # Enable the design
    dut.ena.value = 1
    await ClockCycles(dut.clk, 1)

    # Start playback
    dut.ui_in.value = 1
    
    # Record initial value
    await ClockCycles(dut.clk, 100)
    initial_value = int(dut.uo_out.value)
    
    # Wait and check for changes
    await ClockCycles(dut.clk, 100)
    final_value = int(dut.uo_out.value)
    
    assert final_value != initial_value, f"Audio output not changing. Initial: {initial_value}, Final: {final_value}"

@cocotb.test()
async def test_audio_player(dut):
    """Wrapper for the main test"""
    await run_test(dut)

# test/test.py
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, Timer, ClockCycles

@cocotb.test()
async def test_audio_player(dut):
    """Simple audio player test"""
    dut._log.info("Starting test...")

    # Create clock (3.125 MHz = 2500ns period)
    clock = Clock(dut.clk, 2500, units="ns")
    cocotb.start_soon(clock.start())

    # Reset
    dut._log.info("Resetting DUT")
    dut.rst_n.value = 0
    dut.ena.value = 0
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    await ClockCycles(dut.clk, 10)
    
    # Release reset
    dut.rst_n.value = 1
    await ClockCycles(dut.clk, 1)
    
    # Enable and start playback
    dut.ena.value = 1
    dut.ui_in.value = 1
    
    # Let it run for a short time
    await ClockCycles(dut.clk, 100)
    
    # Check for audio output activity
    initial_value = int(dut.uo_out.value)
    await ClockCycles(dut.clk, 10)
    final_value = int(dut.uo_out.value)
    
    assert final_value != initial_value, "Audio output should change over time"
    dut._log.info("Test completed successfully")

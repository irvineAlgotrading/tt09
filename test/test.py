import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles, Timer

@cocotb.test()
async def test_audio_player(dut):
    dut._log.info("Start")

    # Create clock (3.125 MHz = 2500ns period)
    clock = Clock(dut.clk, 2500, units="ns")
    cocotb.start_soon(clock.start())  # Added this line

    # Reset
    dut._log.info("Applying reset")
    dut.rst_n.value = 0
    dut.ena.value = 0
    dut.ui_in.value = 0
    dut.uio_in.value = 0  # Added this line
    await ClockCycles(dut.clk, 10)
    
    # Release reset and enable
    dut._log.info("Releasing reset")
    dut.rst_n.value = 1
    await ClockCycles(dut.clk, 1)
    dut.ena.value = 1
    
    # Start playback
    dut._log.info("Starting playback")
    dut.ui_in.value = 1
    
    # Wait for some audio output
    await ClockCycles(dut.clk, 1000)
    
    # Check that we get some audio output variation
    dut._log.info("Checking audio output")
    initial_value = int(dut.uo_out.value)
    await ClockCycles(dut.clk, 100)
    final_value = int(dut.uo_out.value)
    
    assert final_value != initial_value, "Audio output should change over time"
    dut._log.info("Test completed successfully")

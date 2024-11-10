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

    # Initialize inputs
    dut._log.info("Initializing inputs")
    dut.rst_n.value = 0
    dut.ena.value = 0
    dut.ui_in.value = 0
    dut.uio_in.value = 0

    # Wait 10 clock cycles
    await ClockCycles(dut.clk, 10)

    # Release reset and enable with play
    dut._log.info("Releasing reset")
    dut.rst_n.value = 1
    dut.ena.value = 1
    dut.ui_in.value = 1
    
    # Wait for audio output
    await ClockCycles(dut.clk, 20)
    
    # Capture initial value
    initial_value = int(dut.uo_out.value)
    dut._log.info(f"Initial value: {initial_value}")
    
    # Wait for change
    for _ in range(50):
        await ClockCycles(dut.clk, 1)
        current_value = int(dut.uo_out.value)
        if current_value != initial_value:
            dut._log.info(f"Value changed to: {current_value}")
            return
    
    # If we get here, no change was detected
    assert False, "No audio output change detected"

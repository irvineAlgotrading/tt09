`default_nettype none
`timescale 1ns/1ps

module tb_audio_player;

    reg clk;
    reg rst_n;
    reg ena;
    reg [7:0] ui_in;
    reg [7:0] uio_in;
    wire [7:0] uo_out;
    wire [7:0] uio_out;
    wire [7:0] uio_oe;
    real audio_value;

    // Clock: 3.125MHz (2500ns period)
    initial begin
        clk = 0;
        forever #1250 clk = ~clk;
    end

    // Audio value conversion
    always @(posedge clk) begin
        audio_value = uo_out[0] ? 3.3 : 0.0;
    end

    // DUT
    tt_um_audio_player dut (
        .ui_in(ui_in),
        .uo_out(uo_out),
        .uio_in(uio_in),
        .uio_out(uio_out),
        .uio_oe(uio_oe),
        .ena(ena),
        .clk(clk),
        .rst_n(rst_n)
    );

    // Simulation control
    initial begin
        $timeformat(-9, 3, "ns", 12);

        // Initialize
        ui_in = 0;
        uio_in = 0;
        ena = 0;
        rst_n = 1;

        // Setup waveform dump
        $dumpfile("tb.vcd");
        $dumpvars(0, tb_audio_player);  // Changed from tb to tb_audio_player

        // Initial delay
        #1000;

        // Reset pulse
        rst_n = 0;
        #1000;
        rst_n = 1;
        #1000;

        // Enable playback
        ena = 1;

        // Run for 100ms
        #100_000_000;

        $display("Simulation complete at %t", $time);
        $finish;
    end

    // Progress monitoring
    initial begin
        forever begin
            #1_000_000; // Every 1ms
            $display("Time: %t ms, Audio Value: %f V",
                    $time/1_000_000,
                    audio_value);
        end
    end

endmodule

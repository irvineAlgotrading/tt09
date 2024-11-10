`default_nettype none
`timescale 1ns/1ps

module tb_audio_player;
    // DUT signals
    reg clk;
    reg rst_n;
    reg ena;
    reg [7:0] ui_in;
    reg [7:0] uio_in;
    wire [7:0] uo_out;
    wire [7:0] uio_out;
    wire [7:0] uio_oe;

    // Instantiate the module
    tt_um_audio_player dut (
        .clk(clk),
        .rst_n(rst_n),
        .ena(ena),
        .ui_in(ui_in),
        .uio_in(uio_in),
        .uo_out(uo_out),
        .uio_out(uio_out),
        .uio_oe(uio_oe)
    );

    // Clock generator (3.125MHz)
    initial begin
        clk = 0;
        forever #1250 clk = ~clk;
    end

    // Test stimulus
    initial begin
        // Initialize
        ui_in = 0;
        uio_in = 0;
        ena = 0;
        rst_n = 0;

        // Dump waves
        $dumpfile("tb.vcd");
        $dumpvars(0, tb_audio_player);

        // Reset sequence
        #2500 rst_n = 1;
        #2500 ena = 1;

        // Start playback
        #2500 ui_in = 8'h01;

        // Run for a while
        #100000;

        $finish;
    end
endmodule

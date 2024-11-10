`default_nettype none
`timescale 1ns/1ps

module tb_audio_player;
    // Basic setup
    reg clk;
    reg rst_n;
    reg ena;
    reg [7:0] ui_in;
    reg [7:0] uio_in;
    wire [7:0] uo_out;
    wire [7:0] uio_out;
    wire [7:0] uio_oe;

    // Clock generation
    initial begin
        clk = 0;
        forever #1250 clk = ~clk;  // 2500ns period
    end

    // Instantiate the DUT
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

    // Dump waves
    initial begin
        $dumpfile("tb.vcd");
        $dumpvars(0, tb_audio_player);
    end

endmodule

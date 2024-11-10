`default_nettype none

module tt_um_audio_player (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);
    // Internal wires
    wire [13:0] current_addr;
    wire [15:0] audio_sample;
    wire [7:0] pwm_value;
    wire [7:0] sample_scaled;
    wire play_pause = ui_in[0];  // Use ui_in[0] as play/pause control

    // Instantiate the audio player
    player #(
        .CLOCK_RATE(400_000),   // 400kHz clock
        .SAMPLE_RATE(16_000)    // 16kHz sample rate
    ) audio_player_inst (
        .clk(clk),
        .rst_n(rst_n),
        .enable(ena && play_pause),  // Enable when both ena and play_pause are high
        .audio_out(uo_out[0]),     // Audio output on first bit
        .current_addr(current_addr),
        .audio_sample(audio_sample),
        .pwm_value(pwm_value),
        .sample_scaled(sample_scaled)
    );

    // Connect other outputs
    assign uo_out[7:1] = 7'b0;     // Upper bits unused
    assign uio_out = 8'b0;         // Not using bidirectional pins
    assign uio_oe = 8'b0;          // All bidirectional pins are inputs
endmodule

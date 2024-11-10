`default_nettype none

module tt_um_audio_player (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Changed from reg to wire
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

    // Internal wires
    wire [15:0] current_addr;
    wire [15:0] audio_sample;
    wire [7:0] pwm_value;
    wire [7:0] sample_scaled;
    wire audio_out;  // Added this for PWM output

    // Instantiate the audio player
    player audio_player_inst (
        .clk(clk),
        .rst_n(rst_n),
        .ena(ena),
        .audio_out(audio_out),  // Connect the audio_out
        .current_addr(current_addr),
        .audio_sample(audio_sample),
        .pwm_value(pwm_value),
        .sample_scaled(sample_scaled)
    );

    // Connect outputs
    assign uio_out = 8'b0;        // Not using bidirectional pins for output
    assign uio_oe = 8'b0;         // All bidirectional pins are inputs
    assign uo_out = {7'b0, audio_out};  // Audio output on LSB

endmodule

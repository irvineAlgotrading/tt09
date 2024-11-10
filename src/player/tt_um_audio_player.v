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
    wire [13:0] current_addr;  // Changed from [15:0] to [13:0]
    wire [15:0] audio_sample;
    wire [7:0] pwm_value;
    wire [7:0] sample_scaled;
    wire audio_out;

    // Instantiate the audio player
    player audio_player_inst (
        .clk(clk),
        .rst_n(rst_n),
        .enable(ena),
        .audio_out(audio_out),
        .current_addr(current_addr),
        .audio_sample(audio_sample),
        .pwm_value(pwm_value),
        .sample_scaled(sample_scaled)
    );

    // Connect outputs
    assign uio_out = 8'b0;
    assign uio_oe = 8'b0;
    assign uo_out = {7'b0, audio_out};

endmodule

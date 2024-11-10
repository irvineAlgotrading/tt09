`default_nettype none

module tt_um_audio_player (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output reg  [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

    // Internal wires
    wire [15:0] current_addr;
    wire [15:0] audio_sample;
    wire [7:0] pwm_value;
    wire [7:0] sample_scaled;

    // Instantiate the audio player
    player audio_player_inst (
        .clk(clk),
        .rst_n(rst_n),
        .enable(ena),          // changed from ena to enable to match module
        .audio_out(uo_out[0]), // connect audio output to first output bit
        .current_addr(current_addr),
        .audio_sample(audio_sample),
        .pwm_value(pwm_value),
        .sample_scaled(sample_scaled)
    );

    // Connect outputs
    assign uio_out = 8'b0;        // Not using bidirectional pins for output
    assign uio_oe = 8'b0;         // All bidirectional pins are inputs

    // Register the PWM output
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            uo_out <= 8'b0;
        else if (ena)
            uo_out <= pwm_value;   // Output the PWM value
        else
            uo_out <= 8'b0;
    end

endmodule

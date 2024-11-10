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

    // Signal declarations
    wire audio_out;
    wire [15:0] current_addr;
    wire [15:0] audio_sample;
    wire [7:0] pwm_value;
    wire [7:0] sample_scaled;

    // Audio player instance
    audio_player #(
        .CLOCK_RATE(3_125_000),  // 3.125 MHz
        .SAMPLE_RATE(16_000)     // 16 kHz
    ) audio_player_inst (
        .clk(clk),
        .rst_n(rst_n),
        .enable(ena),
        .audio_out(audio_out),
        .current_addr(current_addr),
        .audio_sample(audio_sample),
        .pwm_value(pwm_value),
        .sample_scaled(sample_scaled)
    );

    // Output registers
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            uo_out <= 8'b0;
        end else begin
            uo_out[0] <= audio_out;    // PWM audio output
            uo_out[7:1] <= 7'b0;       // Unused outputs
        end
    end

    // Bidirectional pins configuration
    assign uio_out = 8'b0;    // Not using bidirectional pins
    assign uio_oe = 8'b0;     // All pins as inputs

endmodule

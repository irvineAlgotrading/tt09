`default_nettype none

module player #(
    parameter CLOCK_RATE = 3_125_000,  // 3.125 MHz
    parameter SAMPLE_RATE = 16_000     // 16 kHz
) (
    input  wire        clk,
    input  wire        rst_n,
    input  wire        enable,
    output reg         audio_out,
    output reg  [15:0] current_addr,
    output wire [15:0] audio_sample,
    output wire [7:0]  pwm_value,
    output wire [7:0]  sample_scaled
);

    // Divider calculation
    localparam DIVIDER = CLOCK_RATE / SAMPLE_RATE;  // Should be 195

    // Sample rate generation
    reg [11:0] sample_counter = 0;
    reg sample_tick = 0;

    // Sample counter
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            sample_counter <= 0;
            sample_tick <= 0;
        end else if (enable) begin
            if (sample_counter >= DIVIDER - 1) begin
                sample_counter <= 0;
                sample_tick <= 1;
            end else begin
                sample_counter <= sample_counter + 1;
                sample_tick <= 0;
            end
        end
    end

    // Address counter
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            current_addr <= 0;
        end else if (enable && sample_tick) begin
            if (current_addr >= 48000 - 1)  // 3 seconds at 16kHz
                current_addr <= 0;
            else
                current_addr <= current_addr + 1;
        end
    end

    // Audio lookup
    audio_lookup_table lookup (
        .address(current_addr),
        .data_out(audio_sample)
    );

    // PWM generation
    reg [3:0] pwm_counter = 0;
    wire [3:0] pwm_threshold;

    // Take top 4 bits of audio sample
    assign pwm_threshold = audio_sample[15:12] + 4'd8;  // Add offset to center

    // PWM counter and output
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            pwm_counter <= 0;
            audio_out <= 0;
        end else if (enable) begin
            pwm_counter <= pwm_counter + 1;
            audio_out <= (pwm_counter < pwm_threshold);
        end else begin
            pwm_counter <= 0;
            audio_out <= 0;
        end
    end

    // Debug outputs
    assign pwm_value = {pwm_counter, 4'b0};
    assign sample_scaled = {pwm_threshold, 4'b0};

    // Initial values
    initial begin
        current_addr = 0;
        audio_out = 0;
        sample_counter = 0;
        sample_tick = 0;
        pwm_counter = 0;
    end

endmodule

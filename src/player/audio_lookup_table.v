`default_nettype none

module audio_lookup_table (
    input wire [13:0] address,
    output reg [15:0] data_out
);
    reg [15:0] rom [0:16383];  // 16K samples

    initial begin
        integer i;
        // Initialize all memory to 0
        for (i = 0; i < 16384; i = i + 1) begin
            rom[i] = 16'h0000;
        end
        // Load pattern from file
        $readmemh("audio_data.hex", rom);
    end

    always @(*) begin
        data_out = rom[address];
    end

endmodule

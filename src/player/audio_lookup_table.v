`default_nettype none

module audio_lookup_table (
    input wire [13:0] address,
    output reg [15:0] data_out
);
    reg [15:0] rom [0:16383];  // 16K samples

    initial begin
`ifdef SIMULATION
        $readmemh("../src/player/audio_data.hex", rom);
`else
        $readmemh("audio_data.hex", rom);
`endif
    end

    always @(*) begin
        if ({2'b00, address} < 16384) begin
            data_out = rom[address];
        end else begin
            data_out = 16'd0;
        end
    end

endmodule

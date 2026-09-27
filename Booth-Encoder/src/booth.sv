module booth_encoder #(
    parameter int WIDTH = 64
) (
    input  logic signed [WIDTH-1:0] multiplier,
    output logic signed [(3*(WIDTH/2))-1:0] booth_digits
);

    localparam int NUM_DIGITS = WIDTH / 2;

    function automatic logic signed [2:0] encode_booth(
        input logic [2:0] bits
    );
        case (bits)
            3'b000: encode_booth =  3'sd0;
            3'b001: encode_booth =  3'sd1;
            3'b010: encode_booth =  3'sd1;
            3'b011: encode_booth =  3'sd2;
            3'b100: encode_booth = -3'sd2;
            3'b101: encode_booth = -3'sd1;
            3'b110: encode_booth = -3'sd1;
            3'b111: encode_booth =  3'sd0;
            default: encode_booth = 3'sd0;
        endcase
    endfunction

    genvar i;

    generate
        for (i = 0; i < NUM_DIGITS; i++) begin : GEN_BOOTH
            if (i == 0) begin
                assign booth_digits[3*i +: 3] = encode_booth({multiplier[1], multiplier[0], 1'b0});
            end
            else begin
                assign booth_digits[3*i +: 3] = encode_booth({multiplier[2*i+1], multiplier[2*i], multiplier[2*i-1]});
            end
        end
    endgenerate

endmodule
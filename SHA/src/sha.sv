`default_nettype none
`include "ksa.sv"
// ksa.sv - https://github.com/KARAN-D05/High-Performance-Adder-Architectures/blob/main/KSA/src/ksa.sv

module sha #(
    parameter WIDTH = 32
) (
    input logic [WIDTH-1:0] multiplier,
    input logic [(2*WIDTH)-1:0] multiplicand,
    input logic clk,
    input logic rst,
    input logic start,
    output logic [(2*WIDTH)-1:0] product
);

  logic write;
  logic [WIDTH-1:0] multiplier_reg;
  logic [(2*WIDTH-1):0] multiplicand_reg;

  assign write = multiplier_reg[0];

  logic [5:0] count;

  logic [(2*WIDTH)-1:0] ksa_sum;
  logic ksa_cout;

  ksa #(
    .WIDTH(2*WIDTH)
  ) ksa_adder (
    .a(product),
    .b(multiplicand_reg),
    .c_in(1'b0),
    .sum(ksa_sum),
    .c_out(ksa_cout)
  );
  
  always_ff @(posedge clk) begin
    if (rst) begin
        product <= {(2*WIDTH){1'b0}};
        multiplier_reg <= {(WIDTH){1'b0}};
        multiplicand_reg <= {(2*WIDTH){1'b0}};
        count <= {6{1'b0}};
    end else if (start) begin
        product <= {(2*WIDTH){1'b0}};
        multiplier_reg <= multiplier;
        multiplicand_reg <= multiplicand;
        count <= {6{1'b0}};
    end else if (count < 6'd32) begin
        multiplier_reg <= multiplier_reg >> 1;
        multiplicand_reg <= multiplicand_reg << 1;
        product <= write ? ksa_sum : product;
        count <= count + 1'b1;
    end
  end

endmodule

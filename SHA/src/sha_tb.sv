`timescale 1ns/1ns
`include "sha.sv"

module testbench;

  parameter WIDTH = 32;

  logic [WIDTH-1:0] multiplier;
  logic [(2*WIDTH)-1:0] multiplicand;
  logic clk;
  logic rst;
  logic start;
  logic [(2*WIDTH)-1:0] product;

  sha #(
    .WIDTH(WIDTH)
  ) dut (
    .multiplier(multiplier),
    .multiplicand(multiplicand),
    .clk(clk),
    .rst(rst),
    .start(start),
    .product(product)
  );

  initial clk = 0;
  always #5 clk = ~clk;

  initial begin

    $monitor("time = %0t | multiplier = %h | multiplicand = %h | rst = %h | start = %h | product = %h ", $time, multiplier, multiplicand, rst, start, product);

    $dumpfile("Sim.vcd");
    $dumpvars(0, testbench);
    
    @(negedge clk);
    rst = 1'b1;
    start = 1'b0;
    multiplicand = 64'h0000000000000000;
    multiplier = 32'h00000000;

    @(negedge clk);
    #1;
    rst = 1'b0;
    multiplicand = 64'h0000000012345678;
    multiplier = 32'hFEDCBA98;
    start = 1'b1;

    @(negedge clk);
    #1;
    start = 1'b0;

    repeat (32) @(posedge clk);
    #1;

    $display("Multiplier = %d | Multiplicand = %0d | Product = %d | Expected = %d | Pass = %d ", multiplier, multiplicand, product, multiplier * multiplicand, multiplier * multiplicand == product);
    $display("Simulation Complete!");
    $finish;

  end

endmodule
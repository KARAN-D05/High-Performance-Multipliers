`timescale 1ns/1ns

module testbench;

  logic [31:0] multiplier;
  logic [31:0] multiplicand;
  logic [63:0] product;

  dtm dut (
    .multiplier(multiplier),
    .multiplicand(multiplicand),
    .product(product)
  );

  initial begin

    $monitor("time = %0t | multiplier = %h | multiplicand = %h | product = %h", $time, multiplier, multiplicand, product);

    $dumpfile("Sim.vcd");
    $dumpvars(0, testbench);

    multiplier   = 32'h00000000;
    multiplicand = 32'h00000000;

    #10;
    multiplier   = 32'h00000004;
    multiplicand = 32'h00000004;

    #10;
    multiplier   = 32'h0000000A;
    multiplicand = 32'h00000007;

    #10;
    multiplier   = 32'h0000000F;
    multiplicand = 32'h0000000F;

    #10;
    multiplier   = 32'h00000008;
    multiplicand = 32'h00000002;

    #10;
    multiplier   = 32'h00000000;
    multiplicand = 32'hFFFFFFFF;

    #10;
    multiplier   = 32'hFFFFFFFF;
    multiplicand = 32'h00000000;

    #10;
    multiplier   = 32'hFFFFFFFF;
    multiplicand = 32'h00000001;

    #10;
    multiplier   = 32'h80000000;
    multiplicand = 32'h00000002;

    #10;
    multiplier   = 32'hFFFFFFFF;
    multiplicand = 32'hFFFFFFFF;

    #10;
    multiplier   = 32'hAAAAAAAA;
    multiplicand = 32'h00000003;

    #10;
    multiplier   = 32'hFEDCBA98;
    multiplicand = 32'h12345678;

    #1;

    $display("Simulation Complete!");
    $finish;

  end

endmodule

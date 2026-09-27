`timescale 1ns/1ns
`include "booth.sv"

module testbench;

  parameter WIDTH = 64;
  parameter NUM_DIGITS = WIDTH / 2;

  logic signed [WIDTH-1:0] multiplier;
  logic signed [2:0] booth_digit [NUM_DIGITS];

  booth_encoder #(
    .WIDTH(WIDTH)
  ) dut (
    .multiplier(multiplier)
  );

  initial begin

    $dumpfile("Sim.vcd");
    $dumpvars(0, testbench);

    multiplier = 64'hFEDCBA9876543210;
    #1;

    $display("Multiplier = %h", multiplier);

    for (int i = 0; i < NUM_DIGITS; i++) begin
      booth_digit[i] = dut.booth_digits[3*i +: 3];
      $display("digit[%0d] = %0d (%b)", i, booth_digit[i], booth_digit[i]);
    end

    $display("Simulation Complete!");
    $finish;

  end

endmodule
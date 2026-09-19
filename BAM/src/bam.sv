`default_nettype none

module bam #(
    parameter WIDTH = 32
) (
    input logic [WIDTH-1:0] multiplier,
    input logic [WIDTH-1:0] multiplicand,
    output logic [(2*WIDTH)-1:0] product
);

  logic [WIDTH-1:0] partial_products [WIDTH-1:0];
  integer i, j;

  always_comb begin
    for (i = 0; i < WIDTH; i++) begin
      for (j = 0; j < WIDTH; j++) begin
        partial_products[i][j] = multiplier[i] & multiplicand[j];
      end
    end
  end

  logic [WIDTH-2:0] carry [1:2*WIDTH-2];
  logic [WIDTH-2:0] inter [1:2*WIDTH-2];

  assign product[0] = partial_products[0][0];

  ha ha_1 (
    .a(partial_products[1][0]),
    .b(partial_products[0][1]),
    .sum(product[1]),
    .c_out(carry[1][0])
  );

  fa fa_2_0 (
    .a(partial_products[2][0]),
    .b(partial_products[1][1]),
    .c_in(carry[1][0]),
    .sum(inter[2][0]),
    .c_out(carry[2][0])
  );

  ha ha_2_1 (
    .a(partial_products[0][2]),
    .b(inter[2][0]),
    .sum(product[2]),
    .c_out(carry[2][1])
  );

  fa fa_3_0 (
    .a(partial_products[3][0]),
    .b(partial_products[2][1]),
    .c_in(carry[2][0]),
    .sum(inter[3][0]),
    .c_out(carry[3][0])
  );
  fa fa_3_1 (
    .a(partial_products[1][2]),
    .b(inter[3][0]),
    .c_in(carry[2][1]),
    .sum(inter[3][1]),
    .c_out(carry[3][1])
  );
  ha ha_3_2 (
    .a(partial_products[0][3]),
    .b(inter[3][1]),
    .sum(product[3]),
    .c_out(carry[3][2])
  );

  fa fa_4_0 (
    .a(partial_products[4][0]),
    .b(partial_products[3][1]),
    .c_in(carry[3][0]),
    .sum(inter[4][0]),
    .c_out(carry[4][0])
  );
  fa fa_4_1 (
    .a(partial_products[2][2]),
    .b(inter[4][0]),
    .c_in(carry[3][1]),
    .sum(inter[4][1]),
    .c_out(carry[4][1])
  );
  fa fa_4_2 (
    .a(partial_products[1][3]),
    .b(inter[4][1]),
    .c_in(carry[3][2]),
    .sum(inter[4][2]),
    .c_out(carry[4][2])
  );
  ha ha_4_3 (
    .a(partial_products[0][4]),
    .b(inter[4][2]),
    .sum(product[4]),
    .c_out(carry[4][3])
  );

  fa fa_5_0 (
    .a(partial_products[5][0]),
    .b(partial_products[4][1]),
    .c_in(carry[4][0]),
    .sum(inter[5][0]),
    .c_out(carry[5][0])
  );
  fa fa_5_1 (
    .a(partial_products[3][2]),
    .b(inter[5][0]),
    .c_in(carry[4][1]),
    .sum(inter[5][1]),
    .c_out(carry[5][1])
  );
  fa fa_5_2 (
    .a(partial_products[2][3]),
    .b(inter[5][1]),
    .c_in(carry[4][2]),
    .sum(inter[5][2]),
    .c_out(carry[5][2])
  );
  fa fa_5_3 (
    .a(partial_products[1][4]),
    .b(inter[5][2]),
    .c_in(carry[4][3]),
    .sum(inter[5][3]),
    .c_out(carry[5][3])
  );
  ha ha_5_4 (
    .a(partial_products[0][5]),
    .b(inter[5][3]),
    .sum(product[5]),
    .c_out(carry[5][4])
  );

  fa fa_6_0 (
    .a(partial_products[6][0]),
    .b(partial_products[5][1]),
    .c_in(carry[5][0]),
    .sum(inter[6][0]),
    .c_out(carry[6][0])
  );
  fa fa_6_1 (
    .a(partial_products[4][2]),
    .b(inter[6][0]),
    .c_in(carry[5][1]),
    .sum(inter[6][1]),
    .c_out(carry[6][1])
  );
  fa fa_6_2 (
    .a(partial_products[3][3]),
    .b(inter[6][1]),
    .c_in(carry[5][2]),
    .sum(inter[6][2]),
    .c_out(carry[6][2])
  );
  fa fa_6_3 (
    .a(partial_products[2][4]),
    .b(inter[6][2]),
    .c_in(carry[5][3]),
    .sum(inter[6][3]),
    .c_out(carry[6][3])
  );
  fa fa_6_4 (
    .a(partial_products[1][5]),
    .b(inter[6][3]),
    .c_in(carry[5][4]),
    .sum(inter[6][4]),
    .c_out(carry[6][4])
  );
  ha ha_6_5 (
    .a(partial_products[0][6]),
    .b(inter[6][4]),
    .sum(product[6]),
    .c_out(carry[6][5])
  );

  fa fa_7_0 (
    .a(partial_products[7][0]),
    .b(partial_products[6][1]),
    .c_in(carry[6][0]),
    .sum(inter[7][0]),
    .c_out(carry[7][0])
  );
  fa fa_7_1 (
    .a(partial_products[5][2]),
    .b(inter[7][0]),
    .c_in(carry[6][1]),
    .sum(inter[7][1]),
    .c_out(carry[7][1])
  );
  fa fa_7_2 (
    .a(partial_products[4][3]),
    .b(inter[7][1]),
    .c_in(carry[6][2]),
    .sum(inter[7][2]),
    .c_out(carry[7][2])
  );
  fa fa_7_3 (
    .a(partial_products[3][4]),
    .b(inter[7][2]),
    .c_in(carry[6][3]),
    .sum(inter[7][3]),
    .c_out(carry[7][3])
  );
  fa fa_7_4 (
    .a(partial_products[2][5]),
    .b(inter[7][3]),
    .c_in(carry[6][4]),
    .sum(inter[7][4]),
    .c_out(carry[7][4])
  );
  fa fa_7_5 (
    .a(partial_products[1][6]),
    .b(inter[7][4]),
    .c_in(carry[6][5]),
    .sum(inter[7][5]),
    .c_out(carry[7][5])
  );
  ha ha_7_6 (
    .a(partial_products[0][7]),
    .b(inter[7][5]),
    .sum(product[7]),
    .c_out(carry[7][6])
  );

  fa fa_8_0 (
    .a(partial_products[8][0]),
    .b(partial_products[7][1]),
    .c_in(carry[7][0]),
    .sum(inter[8][0]),
    .c_out(carry[8][0])
  );
  fa fa_8_1 (
    .a(partial_products[6][2]),
    .b(inter[8][0]),
    .c_in(carry[7][1]),
    .sum(inter[8][1]),
    .c_out(carry[8][1])
  );
  fa fa_8_2 (
    .a(partial_products[5][3]),
    .b(inter[8][1]),
    .c_in(carry[7][2]),
    .sum(inter[8][2]),
    .c_out(carry[8][2])
  );
  fa fa_8_3 (
    .a(partial_products[4][4]),
    .b(inter[8][2]),
    .c_in(carry[7][3]),
    .sum(inter[8][3]),
    .c_out(carry[8][3])
  );
  fa fa_8_4 (
    .a(partial_products[3][5]),
    .b(inter[8][3]),
    .c_in(carry[7][4]),
    .sum(inter[8][4]),
    .c_out(carry[8][4])
  );
  fa fa_8_5 (
    .a(partial_products[2][6]),
    .b(inter[8][4]),
    .c_in(carry[7][5]),
    .sum(inter[8][5]),
    .c_out(carry[8][5])
  );
  fa fa_8_6 (
    .a(partial_products[1][7]),
    .b(inter[8][5]),
    .c_in(carry[7][6]),
    .sum(inter[8][6]),
    .c_out(carry[8][6])
  );
  ha ha_8_7 (
    .a(partial_products[0][8]),
    .b(inter[8][6]),
    .sum(product[8]),
    .c_out(carry[8][7])
  );

  fa fa_9_0 (
    .a(partial_products[9][0]),
    .b(partial_products[8][1]),
    .c_in(carry[8][0]),
    .sum(inter[9][0]),
    .c_out(carry[9][0])
  );
  fa fa_9_1 (
    .a(partial_products[7][2]),
    .b(inter[9][0]),
    .c_in(carry[8][1]),
    .sum(inter[9][1]),
    .c_out(carry[9][1])
  );
  fa fa_9_2 (
    .a(partial_products[6][3]),
    .b(inter[9][1]),
    .c_in(carry[8][2]),
    .sum(inter[9][2]),
    .c_out(carry[9][2])
  );
  fa fa_9_3 (
    .a(partial_products[5][4]),
    .b(inter[9][2]),
    .c_in(carry[8][3]),
    .sum(inter[9][3]),
    .c_out(carry[9][3])
  );
  fa fa_9_4 (
    .a(partial_products[4][5]),
    .b(inter[9][3]),
    .c_in(carry[8][4]),
    .sum(inter[9][4]),
    .c_out(carry[9][4])
  );
  fa fa_9_5 (
    .a(partial_products[3][6]),
    .b(inter[9][4]),
    .c_in(carry[8][5]),
    .sum(inter[9][5]),
    .c_out(carry[9][5])
  );
  fa fa_9_6 (
    .a(partial_products[2][7]),
    .b(inter[9][5]),
    .c_in(carry[8][6]),
    .sum(inter[9][6]),
    .c_out(carry[9][6])
  );
  fa fa_9_7 (
    .a(partial_products[1][8]),
    .b(inter[9][6]),
    .c_in(carry[8][7]),
    .sum(inter[9][7]),
    .c_out(carry[9][7])
  );
  ha ha_9_8 (
    .a(partial_products[0][9]),
    .b(inter[9][7]),
    .sum(product[9]),
    .c_out(carry[9][8])
  );

  fa fa_10_0 (
    .a(partial_products[10][0]),
    .b(partial_products[9][1]),
    .c_in(carry[9][0]),
    .sum(inter[10][0]),
    .c_out(carry[10][0])
  );
  fa fa_10_1 (
    .a(partial_products[8][2]),
    .b(inter[10][0]),
    .c_in(carry[9][1]),
    .sum(inter[10][1]),
    .c_out(carry[10][1])
  );
  fa fa_10_2 (
    .a(partial_products[7][3]),
    .b(inter[10][1]),
    .c_in(carry[9][2]),
    .sum(inter[10][2]),
    .c_out(carry[10][2])
  );
  fa fa_10_3 (
    .a(partial_products[6][4]),
    .b(inter[10][2]),
    .c_in(carry[9][3]),
    .sum(inter[10][3]),
    .c_out(carry[10][3])
  );
  fa fa_10_4 (
    .a(partial_products[5][5]),
    .b(inter[10][3]),
    .c_in(carry[9][4]),
    .sum(inter[10][4]),
    .c_out(carry[10][4])
  );
  fa fa_10_5 (
    .a(partial_products[4][6]),
    .b(inter[10][4]),
    .c_in(carry[9][5]),
    .sum(inter[10][5]),
    .c_out(carry[10][5])
  );
  fa fa_10_6 (
    .a(partial_products[3][7]),
    .b(inter[10][5]),
    .c_in(carry[9][6]),
    .sum(inter[10][6]),
    .c_out(carry[10][6])
  );
  fa fa_10_7 (
    .a(partial_products[2][8]),
    .b(inter[10][6]),
    .c_in(carry[9][7]),
    .sum(inter[10][7]),
    .c_out(carry[10][7])
  );
  fa fa_10_8 (
    .a(partial_products[1][9]),
    .b(inter[10][7]),
    .c_in(carry[9][8]),
    .sum(inter[10][8]),
    .c_out(carry[10][8])
  );
  ha ha_10_9 (
    .a(partial_products[0][10]),
    .b(inter[10][8]),
    .sum(product[10]),
    .c_out(carry[10][9])
  );

  fa fa_11_0 (
    .a(partial_products[11][0]),
    .b(partial_products[10][1]),
    .c_in(carry[10][0]),
    .sum(inter[11][0]),
    .c_out(carry[11][0])
  );
  fa fa_11_1 (
    .a(partial_products[9][2]),
    .b(inter[11][0]),
    .c_in(carry[10][1]),
    .sum(inter[11][1]),
    .c_out(carry[11][1])
  );
  fa fa_11_2 (
    .a(partial_products[8][3]),
    .b(inter[11][1]),
    .c_in(carry[10][2]),
    .sum(inter[11][2]),
    .c_out(carry[11][2])
  );
  fa fa_11_3 (
    .a(partial_products[7][4]),
    .b(inter[11][2]),
    .c_in(carry[10][3]),
    .sum(inter[11][3]),
    .c_out(carry[11][3])
  );
  fa fa_11_4 (
    .a(partial_products[6][5]),
    .b(inter[11][3]),
    .c_in(carry[10][4]),
    .sum(inter[11][4]),
    .c_out(carry[11][4])
  );
  fa fa_11_5 (
    .a(partial_products[5][6]),
    .b(inter[11][4]),
    .c_in(carry[10][5]),
    .sum(inter[11][5]),
    .c_out(carry[11][5])
  );
  fa fa_11_6 (
    .a(partial_products[4][7]),
    .b(inter[11][5]),
    .c_in(carry[10][6]),
    .sum(inter[11][6]),
    .c_out(carry[11][6])
  );
  fa fa_11_7 (
    .a(partial_products[3][8]),
    .b(inter[11][6]),
    .c_in(carry[10][7]),
    .sum(inter[11][7]),
    .c_out(carry[11][7])
  );
  fa fa_11_8 (
    .a(partial_products[2][9]),
    .b(inter[11][7]),
    .c_in(carry[10][8]),
    .sum(inter[11][8]),
    .c_out(carry[11][8])
  );
  fa fa_11_9 (
    .a(partial_products[1][10]),
    .b(inter[11][8]),
    .c_in(carry[10][9]),
    .sum(inter[11][9]),
    .c_out(carry[11][9])
  );
  ha ha_11_10 (
    .a(partial_products[0][11]),
    .b(inter[11][9]),
    .sum(product[11]),
    .c_out(carry[11][10])
  );

  fa fa_12_0 (
    .a(partial_products[12][0]),
    .b(partial_products[11][1]),
    .c_in(carry[11][0]),
    .sum(inter[12][0]),
    .c_out(carry[12][0])
  );
  fa fa_12_1 (
    .a(partial_products[10][2]),
    .b(inter[12][0]),
    .c_in(carry[11][1]),
    .sum(inter[12][1]),
    .c_out(carry[12][1])
  );
  fa fa_12_2 (
    .a(partial_products[9][3]),
    .b(inter[12][1]),
    .c_in(carry[11][2]),
    .sum(inter[12][2]),
    .c_out(carry[12][2])
  );
  fa fa_12_3 (
    .a(partial_products[8][4]),
    .b(inter[12][2]),
    .c_in(carry[11][3]),
    .sum(inter[12][3]),
    .c_out(carry[12][3])
  );
  fa fa_12_4 (
    .a(partial_products[7][5]),
    .b(inter[12][3]),
    .c_in(carry[11][4]),
    .sum(inter[12][4]),
    .c_out(carry[12][4])
  );
  fa fa_12_5 (
    .a(partial_products[6][6]),
    .b(inter[12][4]),
    .c_in(carry[11][5]),
    .sum(inter[12][5]),
    .c_out(carry[12][5])
  );
  fa fa_12_6 (
    .a(partial_products[5][7]),
    .b(inter[12][5]),
    .c_in(carry[11][6]),
    .sum(inter[12][6]),
    .c_out(carry[12][6])
  );
  fa fa_12_7 (
    .a(partial_products[4][8]),
    .b(inter[12][6]),
    .c_in(carry[11][7]),
    .sum(inter[12][7]),
    .c_out(carry[12][7])
  );
  fa fa_12_8 (
    .a(partial_products[3][9]),
    .b(inter[12][7]),
    .c_in(carry[11][8]),
    .sum(inter[12][8]),
    .c_out(carry[12][8])
  );
  fa fa_12_9 (
    .a(partial_products[2][10]),
    .b(inter[12][8]),
    .c_in(carry[11][9]),
    .sum(inter[12][9]),
    .c_out(carry[12][9])
  );
  fa fa_12_10 (
    .a(partial_products[1][11]),
    .b(inter[12][9]),
    .c_in(carry[11][10]),
    .sum(inter[12][10]),
    .c_out(carry[12][10])
  );
  ha ha_12_11 (
    .a(partial_products[0][12]),
    .b(inter[12][10]),
    .sum(product[12]),
    .c_out(carry[12][11])
  );

  fa fa_13_0 (
    .a(partial_products[13][0]),
    .b(partial_products[12][1]),
    .c_in(carry[12][0]),
    .sum(inter[13][0]),
    .c_out(carry[13][0])
  );
  fa fa_13_1 (
    .a(partial_products[11][2]),
    .b(inter[13][0]),
    .c_in(carry[12][1]),
    .sum(inter[13][1]),
    .c_out(carry[13][1])
  );
  fa fa_13_2 (
    .a(partial_products[10][3]),
    .b(inter[13][1]),
    .c_in(carry[12][2]),
    .sum(inter[13][2]),
    .c_out(carry[13][2])
  );
  fa fa_13_3 (
    .a(partial_products[9][4]),
    .b(inter[13][2]),
    .c_in(carry[12][3]),
    .sum(inter[13][3]),
    .c_out(carry[13][3])
  );
  fa fa_13_4 (
    .a(partial_products[8][5]),
    .b(inter[13][3]),
    .c_in(carry[12][4]),
    .sum(inter[13][4]),
    .c_out(carry[13][4])
  );
  fa fa_13_5 (
    .a(partial_products[7][6]),
    .b(inter[13][4]),
    .c_in(carry[12][5]),
    .sum(inter[13][5]),
    .c_out(carry[13][5])
  );
  fa fa_13_6 (
    .a(partial_products[6][7]),
    .b(inter[13][5]),
    .c_in(carry[12][6]),
    .sum(inter[13][6]),
    .c_out(carry[13][6])
  );
  fa fa_13_7 (
    .a(partial_products[5][8]),
    .b(inter[13][6]),
    .c_in(carry[12][7]),
    .sum(inter[13][7]),
    .c_out(carry[13][7])
  );
  fa fa_13_8 (
    .a(partial_products[4][9]),
    .b(inter[13][7]),
    .c_in(carry[12][8]),
    .sum(inter[13][8]),
    .c_out(carry[13][8])
  );
  fa fa_13_9 (
    .a(partial_products[3][10]),
    .b(inter[13][8]),
    .c_in(carry[12][9]),
    .sum(inter[13][9]),
    .c_out(carry[13][9])
  );
  fa fa_13_10 (
    .a(partial_products[2][11]),
    .b(inter[13][9]),
    .c_in(carry[12][10]),
    .sum(inter[13][10]),
    .c_out(carry[13][10])
  );
  fa fa_13_11 (
    .a(partial_products[1][12]),
    .b(inter[13][10]),
    .c_in(carry[12][11]),
    .sum(inter[13][11]),
    .c_out(carry[13][11])
  );
  ha ha_13_12 (
    .a(partial_products[0][13]),
    .b(inter[13][11]),
    .sum(product[13]),
    .c_out(carry[13][12])
  );

  fa fa_14_0 (
    .a(partial_products[14][0]),
    .b(partial_products[13][1]),
    .c_in(carry[13][0]),
    .sum(inter[14][0]),
    .c_out(carry[14][0])
  );
  fa fa_14_1 (
    .a(partial_products[12][2]),
    .b(inter[14][0]),
    .c_in(carry[13][1]),
    .sum(inter[14][1]),
    .c_out(carry[14][1])
  );
  fa fa_14_2 (
    .a(partial_products[11][3]),
    .b(inter[14][1]),
    .c_in(carry[13][2]),
    .sum(inter[14][2]),
    .c_out(carry[14][2])
  );
  fa fa_14_3 (
    .a(partial_products[10][4]),
    .b(inter[14][2]),
    .c_in(carry[13][3]),
    .sum(inter[14][3]),
    .c_out(carry[14][3])
  );
  fa fa_14_4 (
    .a(partial_products[9][5]),
    .b(inter[14][3]),
    .c_in(carry[13][4]),
    .sum(inter[14][4]),
    .c_out(carry[14][4])
  );
  fa fa_14_5 (
    .a(partial_products[8][6]),
    .b(inter[14][4]),
    .c_in(carry[13][5]),
    .sum(inter[14][5]),
    .c_out(carry[14][5])
  );
  fa fa_14_6 (
    .a(partial_products[7][7]),
    .b(inter[14][5]),
    .c_in(carry[13][6]),
    .sum(inter[14][6]),
    .c_out(carry[14][6])
  );
  fa fa_14_7 (
    .a(partial_products[6][8]),
    .b(inter[14][6]),
    .c_in(carry[13][7]),
    .sum(inter[14][7]),
    .c_out(carry[14][7])
  );
  fa fa_14_8 (
    .a(partial_products[5][9]),
    .b(inter[14][7]),
    .c_in(carry[13][8]),
    .sum(inter[14][8]),
    .c_out(carry[14][8])
  );
  fa fa_14_9 (
    .a(partial_products[4][10]),
    .b(inter[14][8]),
    .c_in(carry[13][9]),
    .sum(inter[14][9]),
    .c_out(carry[14][9])
  );
  fa fa_14_10 (
    .a(partial_products[3][11]),
    .b(inter[14][9]),
    .c_in(carry[13][10]),
    .sum(inter[14][10]),
    .c_out(carry[14][10])
  );
  fa fa_14_11 (
    .a(partial_products[2][12]),
    .b(inter[14][10]),
    .c_in(carry[13][11]),
    .sum(inter[14][11]),
    .c_out(carry[14][11])
  );
  fa fa_14_12 (
    .a(partial_products[1][13]),
    .b(inter[14][11]),
    .c_in(carry[13][12]),
    .sum(inter[14][12]),
    .c_out(carry[14][12])
  );
  ha ha_14_13 (
    .a(partial_products[0][14]),
    .b(inter[14][12]),
    .sum(product[14]),
    .c_out(carry[14][13])
  );

  fa fa_15_0 (
    .a(partial_products[15][0]),
    .b(partial_products[14][1]),
    .c_in(carry[14][0]),
    .sum(inter[15][0]),
    .c_out(carry[15][0])
  );
  fa fa_15_1 (
    .a(partial_products[13][2]),
    .b(inter[15][0]),
    .c_in(carry[14][1]),
    .sum(inter[15][1]),
    .c_out(carry[15][1])
  );
  fa fa_15_2 (
    .a(partial_products[12][3]),
    .b(inter[15][1]),
    .c_in(carry[14][2]),
    .sum(inter[15][2]),
    .c_out(carry[15][2])
  );
  fa fa_15_3 (
    .a(partial_products[11][4]),
    .b(inter[15][2]),
    .c_in(carry[14][3]),
    .sum(inter[15][3]),
    .c_out(carry[15][3])
  );
  fa fa_15_4 (
    .a(partial_products[10][5]),
    .b(inter[15][3]),
    .c_in(carry[14][4]),
    .sum(inter[15][4]),
    .c_out(carry[15][4])
  );
  fa fa_15_5 (
    .a(partial_products[9][6]),
    .b(inter[15][4]),
    .c_in(carry[14][5]),
    .sum(inter[15][5]),
    .c_out(carry[15][5])
  );
  fa fa_15_6 (
    .a(partial_products[8][7]),
    .b(inter[15][5]),
    .c_in(carry[14][6]),
    .sum(inter[15][6]),
    .c_out(carry[15][6])
  );
  fa fa_15_7 (
    .a(partial_products[7][8]),
    .b(inter[15][6]),
    .c_in(carry[14][7]),
    .sum(inter[15][7]),
    .c_out(carry[15][7])
  );
  fa fa_15_8 (
    .a(partial_products[6][9]),
    .b(inter[15][7]),
    .c_in(carry[14][8]),
    .sum(inter[15][8]),
    .c_out(carry[15][8])
  );
  fa fa_15_9 (
    .a(partial_products[5][10]),
    .b(inter[15][8]),
    .c_in(carry[14][9]),
    .sum(inter[15][9]),
    .c_out(carry[15][9])
  );
  fa fa_15_10 (
    .a(partial_products[4][11]),
    .b(inter[15][9]),
    .c_in(carry[14][10]),
    .sum(inter[15][10]),
    .c_out(carry[15][10])
  );
  fa fa_15_11 (
    .a(partial_products[3][12]),
    .b(inter[15][10]),
    .c_in(carry[14][11]),
    .sum(inter[15][11]),
    .c_out(carry[15][11])
  );
  fa fa_15_12 (
    .a(partial_products[2][13]),
    .b(inter[15][11]),
    .c_in(carry[14][12]),
    .sum(inter[15][12]),
    .c_out(carry[15][12])
  );
  fa fa_15_13 (
    .a(partial_products[1][14]),
    .b(inter[15][12]),
    .c_in(carry[14][13]),
    .sum(inter[15][13]),
    .c_out(carry[15][13])
  );
  ha ha_15_14 (
    .a(partial_products[0][15]),
    .b(inter[15][13]),
    .sum(product[15]),
    .c_out(carry[15][14])
  );

  fa fa_16_0 (
    .a(partial_products[16][0]),
    .b(partial_products[15][1]),
    .c_in(carry[15][0]),
    .sum(inter[16][0]),
    .c_out(carry[16][0])
  );
  fa fa_16_1 (
    .a(partial_products[14][2]),
    .b(inter[16][0]),
    .c_in(carry[15][1]),
    .sum(inter[16][1]),
    .c_out(carry[16][1])
  );
  fa fa_16_2 (
    .a(partial_products[13][3]),
    .b(inter[16][1]),
    .c_in(carry[15][2]),
    .sum(inter[16][2]),
    .c_out(carry[16][2])
  );
  fa fa_16_3 (
    .a(partial_products[12][4]),
    .b(inter[16][2]),
    .c_in(carry[15][3]),
    .sum(inter[16][3]),
    .c_out(carry[16][3])
  );
  fa fa_16_4 (
    .a(partial_products[11][5]),
    .b(inter[16][3]),
    .c_in(carry[15][4]),
    .sum(inter[16][4]),
    .c_out(carry[16][4])
  );
  fa fa_16_5 (
    .a(partial_products[10][6]),
    .b(inter[16][4]),
    .c_in(carry[15][5]),
    .sum(inter[16][5]),
    .c_out(carry[16][5])
  );
  fa fa_16_6 (
    .a(partial_products[9][7]),
    .b(inter[16][5]),
    .c_in(carry[15][6]),
    .sum(inter[16][6]),
    .c_out(carry[16][6])
  );
  fa fa_16_7 (
    .a(partial_products[8][8]),
    .b(inter[16][6]),
    .c_in(carry[15][7]),
    .sum(inter[16][7]),
    .c_out(carry[16][7])
  );
  fa fa_16_8 (
    .a(partial_products[7][9]),
    .b(inter[16][7]),
    .c_in(carry[15][8]),
    .sum(inter[16][8]),
    .c_out(carry[16][8])
  );
  fa fa_16_9 (
    .a(partial_products[6][10]),
    .b(inter[16][8]),
    .c_in(carry[15][9]),
    .sum(inter[16][9]),
    .c_out(carry[16][9])
  );
  fa fa_16_10 (
    .a(partial_products[5][11]),
    .b(inter[16][9]),
    .c_in(carry[15][10]),
    .sum(inter[16][10]),
    .c_out(carry[16][10])
  );
  fa fa_16_11 (
    .a(partial_products[4][12]),
    .b(inter[16][10]),
    .c_in(carry[15][11]),
    .sum(inter[16][11]),
    .c_out(carry[16][11])
  );
  fa fa_16_12 (
    .a(partial_products[3][13]),
    .b(inter[16][11]),
    .c_in(carry[15][12]),
    .sum(inter[16][12]),
    .c_out(carry[16][12])
  );
  fa fa_16_13 (
    .a(partial_products[2][14]),
    .b(inter[16][12]),
    .c_in(carry[15][13]),
    .sum(inter[16][13]),
    .c_out(carry[16][13])
  );
  fa fa_16_14 (
    .a(partial_products[1][15]),
    .b(inter[16][13]),
    .c_in(carry[15][14]),
    .sum(inter[16][14]),
    .c_out(carry[16][14])
  );
  ha ha_16_15 (
    .a(partial_products[0][16]),
    .b(inter[16][14]),
    .sum(product[16]),
    .c_out(carry[16][15])
  );

  fa fa_17_0 (
    .a(partial_products[17][0]),
    .b(partial_products[16][1]),
    .c_in(carry[16][0]),
    .sum(inter[17][0]),
    .c_out(carry[17][0])
  );
  fa fa_17_1 (
    .a(partial_products[15][2]),
    .b(inter[17][0]),
    .c_in(carry[16][1]),
    .sum(inter[17][1]),
    .c_out(carry[17][1])
  );
  fa fa_17_2 (
    .a(partial_products[14][3]),
    .b(inter[17][1]),
    .c_in(carry[16][2]),
    .sum(inter[17][2]),
    .c_out(carry[17][2])
  );
  fa fa_17_3 (
    .a(partial_products[13][4]),
    .b(inter[17][2]),
    .c_in(carry[16][3]),
    .sum(inter[17][3]),
    .c_out(carry[17][3])
  );
  fa fa_17_4 (
    .a(partial_products[12][5]),
    .b(inter[17][3]),
    .c_in(carry[16][4]),
    .sum(inter[17][4]),
    .c_out(carry[17][4])
  );
  fa fa_17_5 (
    .a(partial_products[11][6]),
    .b(inter[17][4]),
    .c_in(carry[16][5]),
    .sum(inter[17][5]),
    .c_out(carry[17][5])
  );
  fa fa_17_6 (
    .a(partial_products[10][7]),
    .b(inter[17][5]),
    .c_in(carry[16][6]),
    .sum(inter[17][6]),
    .c_out(carry[17][6])
  );
  fa fa_17_7 (
    .a(partial_products[9][8]),
    .b(inter[17][6]),
    .c_in(carry[16][7]),
    .sum(inter[17][7]),
    .c_out(carry[17][7])
  );
  fa fa_17_8 (
    .a(partial_products[8][9]),
    .b(inter[17][7]),
    .c_in(carry[16][8]),
    .sum(inter[17][8]),
    .c_out(carry[17][8])
  );
  fa fa_17_9 (
    .a(partial_products[7][10]),
    .b(inter[17][8]),
    .c_in(carry[16][9]),
    .sum(inter[17][9]),
    .c_out(carry[17][9])
  );
  fa fa_17_10 (
    .a(partial_products[6][11]),
    .b(inter[17][9]),
    .c_in(carry[16][10]),
    .sum(inter[17][10]),
    .c_out(carry[17][10])
  );
  fa fa_17_11 (
    .a(partial_products[5][12]),
    .b(inter[17][10]),
    .c_in(carry[16][11]),
    .sum(inter[17][11]),
    .c_out(carry[17][11])
  );
  fa fa_17_12 (
    .a(partial_products[4][13]),
    .b(inter[17][11]),
    .c_in(carry[16][12]),
    .sum(inter[17][12]),
    .c_out(carry[17][12])
  );
  fa fa_17_13 (
    .a(partial_products[3][14]),
    .b(inter[17][12]),
    .c_in(carry[16][13]),
    .sum(inter[17][13]),
    .c_out(carry[17][13])
  );
  fa fa_17_14 (
    .a(partial_products[2][15]),
    .b(inter[17][13]),
    .c_in(carry[16][14]),
    .sum(inter[17][14]),
    .c_out(carry[17][14])
  );
  fa fa_17_15 (
    .a(partial_products[1][16]),
    .b(inter[17][14]),
    .c_in(carry[16][15]),
    .sum(inter[17][15]),
    .c_out(carry[17][15])
  );
  ha ha_17_16 (
    .a(partial_products[0][17]),
    .b(inter[17][15]),
    .sum(product[17]),
    .c_out(carry[17][16])
  );

  fa fa_18_0 (
    .a(partial_products[18][0]),
    .b(partial_products[17][1]),
    .c_in(carry[17][0]),
    .sum(inter[18][0]),
    .c_out(carry[18][0])
  );
  fa fa_18_1 (
    .a(partial_products[16][2]),
    .b(inter[18][0]),
    .c_in(carry[17][1]),
    .sum(inter[18][1]),
    .c_out(carry[18][1])
  );
  fa fa_18_2 (
    .a(partial_products[15][3]),
    .b(inter[18][1]),
    .c_in(carry[17][2]),
    .sum(inter[18][2]),
    .c_out(carry[18][2])
  );
  fa fa_18_3 (
    .a(partial_products[14][4]),
    .b(inter[18][2]),
    .c_in(carry[17][3]),
    .sum(inter[18][3]),
    .c_out(carry[18][3])
  );
  fa fa_18_4 (
    .a(partial_products[13][5]),
    .b(inter[18][3]),
    .c_in(carry[17][4]),
    .sum(inter[18][4]),
    .c_out(carry[18][4])
  );
  fa fa_18_5 (
    .a(partial_products[12][6]),
    .b(inter[18][4]),
    .c_in(carry[17][5]),
    .sum(inter[18][5]),
    .c_out(carry[18][5])
  );
  fa fa_18_6 (
    .a(partial_products[11][7]),
    .b(inter[18][5]),
    .c_in(carry[17][6]),
    .sum(inter[18][6]),
    .c_out(carry[18][6])
  );
  fa fa_18_7 (
    .a(partial_products[10][8]),
    .b(inter[18][6]),
    .c_in(carry[17][7]),
    .sum(inter[18][7]),
    .c_out(carry[18][7])
  );
  fa fa_18_8 (
    .a(partial_products[9][9]),
    .b(inter[18][7]),
    .c_in(carry[17][8]),
    .sum(inter[18][8]),
    .c_out(carry[18][8])
  );
  fa fa_18_9 (
    .a(partial_products[8][10]),
    .b(inter[18][8]),
    .c_in(carry[17][9]),
    .sum(inter[18][9]),
    .c_out(carry[18][9])
  );
  fa fa_18_10 (
    .a(partial_products[7][11]),
    .b(inter[18][9]),
    .c_in(carry[17][10]),
    .sum(inter[18][10]),
    .c_out(carry[18][10])
  );
  fa fa_18_11 (
    .a(partial_products[6][12]),
    .b(inter[18][10]),
    .c_in(carry[17][11]),
    .sum(inter[18][11]),
    .c_out(carry[18][11])
  );
  fa fa_18_12 (
    .a(partial_products[5][13]),
    .b(inter[18][11]),
    .c_in(carry[17][12]),
    .sum(inter[18][12]),
    .c_out(carry[18][12])
  );
  fa fa_18_13 (
    .a(partial_products[4][14]),
    .b(inter[18][12]),
    .c_in(carry[17][13]),
    .sum(inter[18][13]),
    .c_out(carry[18][13])
  );
  fa fa_18_14 (
    .a(partial_products[3][15]),
    .b(inter[18][13]),
    .c_in(carry[17][14]),
    .sum(inter[18][14]),
    .c_out(carry[18][14])
  );
  fa fa_18_15 (
    .a(partial_products[2][16]),
    .b(inter[18][14]),
    .c_in(carry[17][15]),
    .sum(inter[18][15]),
    .c_out(carry[18][15])
  );
  fa fa_18_16 (
    .a(partial_products[1][17]),
    .b(inter[18][15]),
    .c_in(carry[17][16]),
    .sum(inter[18][16]),
    .c_out(carry[18][16])
  );
  ha ha_18_17 (
    .a(partial_products[0][18]),
    .b(inter[18][16]),
    .sum(product[18]),
    .c_out(carry[18][17])
  );

  fa fa_19_0 (
    .a(partial_products[19][0]),
    .b(partial_products[18][1]),
    .c_in(carry[18][0]),
    .sum(inter[19][0]),
    .c_out(carry[19][0])
  );
  fa fa_19_1 (
    .a(partial_products[17][2]),
    .b(inter[19][0]),
    .c_in(carry[18][1]),
    .sum(inter[19][1]),
    .c_out(carry[19][1])
  );
  fa fa_19_2 (
    .a(partial_products[16][3]),
    .b(inter[19][1]),
    .c_in(carry[18][2]),
    .sum(inter[19][2]),
    .c_out(carry[19][2])
  );
  fa fa_19_3 (
    .a(partial_products[15][4]),
    .b(inter[19][2]),
    .c_in(carry[18][3]),
    .sum(inter[19][3]),
    .c_out(carry[19][3])
  );
  fa fa_19_4 (
    .a(partial_products[14][5]),
    .b(inter[19][3]),
    .c_in(carry[18][4]),
    .sum(inter[19][4]),
    .c_out(carry[19][4])
  );
  fa fa_19_5 (
    .a(partial_products[13][6]),
    .b(inter[19][4]),
    .c_in(carry[18][5]),
    .sum(inter[19][5]),
    .c_out(carry[19][5])
  );
  fa fa_19_6 (
    .a(partial_products[12][7]),
    .b(inter[19][5]),
    .c_in(carry[18][6]),
    .sum(inter[19][6]),
    .c_out(carry[19][6])
  );
  fa fa_19_7 (
    .a(partial_products[11][8]),
    .b(inter[19][6]),
    .c_in(carry[18][7]),
    .sum(inter[19][7]),
    .c_out(carry[19][7])
  );
  fa fa_19_8 (
    .a(partial_products[10][9]),
    .b(inter[19][7]),
    .c_in(carry[18][8]),
    .sum(inter[19][8]),
    .c_out(carry[19][8])
  );
  fa fa_19_9 (
    .a(partial_products[9][10]),
    .b(inter[19][8]),
    .c_in(carry[18][9]),
    .sum(inter[19][9]),
    .c_out(carry[19][9])
  );
  fa fa_19_10 (
    .a(partial_products[8][11]),
    .b(inter[19][9]),
    .c_in(carry[18][10]),
    .sum(inter[19][10]),
    .c_out(carry[19][10])
  );
  fa fa_19_11 (
    .a(partial_products[7][12]),
    .b(inter[19][10]),
    .c_in(carry[18][11]),
    .sum(inter[19][11]),
    .c_out(carry[19][11])
  );
  fa fa_19_12 (
    .a(partial_products[6][13]),
    .b(inter[19][11]),
    .c_in(carry[18][12]),
    .sum(inter[19][12]),
    .c_out(carry[19][12])
  );
  fa fa_19_13 (
    .a(partial_products[5][14]),
    .b(inter[19][12]),
    .c_in(carry[18][13]),
    .sum(inter[19][13]),
    .c_out(carry[19][13])
  );
  fa fa_19_14 (
    .a(partial_products[4][15]),
    .b(inter[19][13]),
    .c_in(carry[18][14]),
    .sum(inter[19][14]),
    .c_out(carry[19][14])
  );
  fa fa_19_15 (
    .a(partial_products[3][16]),
    .b(inter[19][14]),
    .c_in(carry[18][15]),
    .sum(inter[19][15]),
    .c_out(carry[19][15])
  );
  fa fa_19_16 (
    .a(partial_products[2][17]),
    .b(inter[19][15]),
    .c_in(carry[18][16]),
    .sum(inter[19][16]),
    .c_out(carry[19][16])
  );
  fa fa_19_17 (
    .a(partial_products[1][18]),
    .b(inter[19][16]),
    .c_in(carry[18][17]),
    .sum(inter[19][17]),
    .c_out(carry[19][17])
  );
  ha ha_19_18 (
    .a(partial_products[0][19]),
    .b(inter[19][17]),
    .sum(product[19]),
    .c_out(carry[19][18])
  );

  fa fa_20_0 (
    .a(partial_products[20][0]),
    .b(partial_products[19][1]),
    .c_in(carry[19][0]),
    .sum(inter[20][0]),
    .c_out(carry[20][0])
  );
  fa fa_20_1 (
    .a(partial_products[18][2]),
    .b(inter[20][0]),
    .c_in(carry[19][1]),
    .sum(inter[20][1]),
    .c_out(carry[20][1])
  );
  fa fa_20_2 (
    .a(partial_products[17][3]),
    .b(inter[20][1]),
    .c_in(carry[19][2]),
    .sum(inter[20][2]),
    .c_out(carry[20][2])
  );
  fa fa_20_3 (
    .a(partial_products[16][4]),
    .b(inter[20][2]),
    .c_in(carry[19][3]),
    .sum(inter[20][3]),
    .c_out(carry[20][3])
  );
  fa fa_20_4 (
    .a(partial_products[15][5]),
    .b(inter[20][3]),
    .c_in(carry[19][4]),
    .sum(inter[20][4]),
    .c_out(carry[20][4])
  );
  fa fa_20_5 (
    .a(partial_products[14][6]),
    .b(inter[20][4]),
    .c_in(carry[19][5]),
    .sum(inter[20][5]),
    .c_out(carry[20][5])
  );
  fa fa_20_6 (
    .a(partial_products[13][7]),
    .b(inter[20][5]),
    .c_in(carry[19][6]),
    .sum(inter[20][6]),
    .c_out(carry[20][6])
  );
  fa fa_20_7 (
    .a(partial_products[12][8]),
    .b(inter[20][6]),
    .c_in(carry[19][7]),
    .sum(inter[20][7]),
    .c_out(carry[20][7])
  );
  fa fa_20_8 (
    .a(partial_products[11][9]),
    .b(inter[20][7]),
    .c_in(carry[19][8]),
    .sum(inter[20][8]),
    .c_out(carry[20][8])
  );
  fa fa_20_9 (
    .a(partial_products[10][10]),
    .b(inter[20][8]),
    .c_in(carry[19][9]),
    .sum(inter[20][9]),
    .c_out(carry[20][9])
  );
  fa fa_20_10 (
    .a(partial_products[9][11]),
    .b(inter[20][9]),
    .c_in(carry[19][10]),
    .sum(inter[20][10]),
    .c_out(carry[20][10])
  );
  fa fa_20_11 (
    .a(partial_products[8][12]),
    .b(inter[20][10]),
    .c_in(carry[19][11]),
    .sum(inter[20][11]),
    .c_out(carry[20][11])
  );
  fa fa_20_12 (
    .a(partial_products[7][13]),
    .b(inter[20][11]),
    .c_in(carry[19][12]),
    .sum(inter[20][12]),
    .c_out(carry[20][12])
  );
  fa fa_20_13 (
    .a(partial_products[6][14]),
    .b(inter[20][12]),
    .c_in(carry[19][13]),
    .sum(inter[20][13]),
    .c_out(carry[20][13])
  );
  fa fa_20_14 (
    .a(partial_products[5][15]),
    .b(inter[20][13]),
    .c_in(carry[19][14]),
    .sum(inter[20][14]),
    .c_out(carry[20][14])
  );
  fa fa_20_15 (
    .a(partial_products[4][16]),
    .b(inter[20][14]),
    .c_in(carry[19][15]),
    .sum(inter[20][15]),
    .c_out(carry[20][15])
  );
  fa fa_20_16 (
    .a(partial_products[3][17]),
    .b(inter[20][15]),
    .c_in(carry[19][16]),
    .sum(inter[20][16]),
    .c_out(carry[20][16])
  );
  fa fa_20_17 (
    .a(partial_products[2][18]),
    .b(inter[20][16]),
    .c_in(carry[19][17]),
    .sum(inter[20][17]),
    .c_out(carry[20][17])
  );
  fa fa_20_18 (
    .a(partial_products[1][19]),
    .b(inter[20][17]),
    .c_in(carry[19][18]),
    .sum(inter[20][18]),
    .c_out(carry[20][18])
  );
  ha ha_20_19 (
    .a(partial_products[0][20]),
    .b(inter[20][18]),
    .sum(product[20]),
    .c_out(carry[20][19])
  );

  fa fa_21_0 (
    .a(partial_products[21][0]),
    .b(partial_products[20][1]),
    .c_in(carry[20][0]),
    .sum(inter[21][0]),
    .c_out(carry[21][0])
  );
  fa fa_21_1 (
    .a(partial_products[19][2]),
    .b(inter[21][0]),
    .c_in(carry[20][1]),
    .sum(inter[21][1]),
    .c_out(carry[21][1])
  );
  fa fa_21_2 (
    .a(partial_products[18][3]),
    .b(inter[21][1]),
    .c_in(carry[20][2]),
    .sum(inter[21][2]),
    .c_out(carry[21][2])
  );
  fa fa_21_3 (
    .a(partial_products[17][4]),
    .b(inter[21][2]),
    .c_in(carry[20][3]),
    .sum(inter[21][3]),
    .c_out(carry[21][3])
  );
  fa fa_21_4 (
    .a(partial_products[16][5]),
    .b(inter[21][3]),
    .c_in(carry[20][4]),
    .sum(inter[21][4]),
    .c_out(carry[21][4])
  );
  fa fa_21_5 (
    .a(partial_products[15][6]),
    .b(inter[21][4]),
    .c_in(carry[20][5]),
    .sum(inter[21][5]),
    .c_out(carry[21][5])
  );
  fa fa_21_6 (
    .a(partial_products[14][7]),
    .b(inter[21][5]),
    .c_in(carry[20][6]),
    .sum(inter[21][6]),
    .c_out(carry[21][6])
  );
  fa fa_21_7 (
    .a(partial_products[13][8]),
    .b(inter[21][6]),
    .c_in(carry[20][7]),
    .sum(inter[21][7]),
    .c_out(carry[21][7])
  );
  fa fa_21_8 (
    .a(partial_products[12][9]),
    .b(inter[21][7]),
    .c_in(carry[20][8]),
    .sum(inter[21][8]),
    .c_out(carry[21][8])
  );
  fa fa_21_9 (
    .a(partial_products[11][10]),
    .b(inter[21][8]),
    .c_in(carry[20][9]),
    .sum(inter[21][9]),
    .c_out(carry[21][9])
  );
  fa fa_21_10 (
    .a(partial_products[10][11]),
    .b(inter[21][9]),
    .c_in(carry[20][10]),
    .sum(inter[21][10]),
    .c_out(carry[21][10])
  );
  fa fa_21_11 (
    .a(partial_products[9][12]),
    .b(inter[21][10]),
    .c_in(carry[20][11]),
    .sum(inter[21][11]),
    .c_out(carry[21][11])
  );
  fa fa_21_12 (
    .a(partial_products[8][13]),
    .b(inter[21][11]),
    .c_in(carry[20][12]),
    .sum(inter[21][12]),
    .c_out(carry[21][12])
  );
  fa fa_21_13 (
    .a(partial_products[7][14]),
    .b(inter[21][12]),
    .c_in(carry[20][13]),
    .sum(inter[21][13]),
    .c_out(carry[21][13])
  );
  fa fa_21_14 (
    .a(partial_products[6][15]),
    .b(inter[21][13]),
    .c_in(carry[20][14]),
    .sum(inter[21][14]),
    .c_out(carry[21][14])
  );
  fa fa_21_15 (
    .a(partial_products[5][16]),
    .b(inter[21][14]),
    .c_in(carry[20][15]),
    .sum(inter[21][15]),
    .c_out(carry[21][15])
  );
  fa fa_21_16 (
    .a(partial_products[4][17]),
    .b(inter[21][15]),
    .c_in(carry[20][16]),
    .sum(inter[21][16]),
    .c_out(carry[21][16])
  );
  fa fa_21_17 (
    .a(partial_products[3][18]),
    .b(inter[21][16]),
    .c_in(carry[20][17]),
    .sum(inter[21][17]),
    .c_out(carry[21][17])
  );
  fa fa_21_18 (
    .a(partial_products[2][19]),
    .b(inter[21][17]),
    .c_in(carry[20][18]),
    .sum(inter[21][18]),
    .c_out(carry[21][18])
  );
  fa fa_21_19 (
    .a(partial_products[1][20]),
    .b(inter[21][18]),
    .c_in(carry[20][19]),
    .sum(inter[21][19]),
    .c_out(carry[21][19])
  );
  ha ha_21_20 (
    .a(partial_products[0][21]),
    .b(inter[21][19]),
    .sum(product[21]),
    .c_out(carry[21][20])
  );

  fa fa_22_0 (
    .a(partial_products[22][0]),
    .b(partial_products[21][1]),
    .c_in(carry[21][0]),
    .sum(inter[22][0]),
    .c_out(carry[22][0])
  );
  fa fa_22_1 (
    .a(partial_products[20][2]),
    .b(inter[22][0]),
    .c_in(carry[21][1]),
    .sum(inter[22][1]),
    .c_out(carry[22][1])
  );
  fa fa_22_2 (
    .a(partial_products[19][3]),
    .b(inter[22][1]),
    .c_in(carry[21][2]),
    .sum(inter[22][2]),
    .c_out(carry[22][2])
  );
  fa fa_22_3 (
    .a(partial_products[18][4]),
    .b(inter[22][2]),
    .c_in(carry[21][3]),
    .sum(inter[22][3]),
    .c_out(carry[22][3])
  );
  fa fa_22_4 (
    .a(partial_products[17][5]),
    .b(inter[22][3]),
    .c_in(carry[21][4]),
    .sum(inter[22][4]),
    .c_out(carry[22][4])
  );
  fa fa_22_5 (
    .a(partial_products[16][6]),
    .b(inter[22][4]),
    .c_in(carry[21][5]),
    .sum(inter[22][5]),
    .c_out(carry[22][5])
  );
  fa fa_22_6 (
    .a(partial_products[15][7]),
    .b(inter[22][5]),
    .c_in(carry[21][6]),
    .sum(inter[22][6]),
    .c_out(carry[22][6])
  );
  fa fa_22_7 (
    .a(partial_products[14][8]),
    .b(inter[22][6]),
    .c_in(carry[21][7]),
    .sum(inter[22][7]),
    .c_out(carry[22][7])
  );
  fa fa_22_8 (
    .a(partial_products[13][9]),
    .b(inter[22][7]),
    .c_in(carry[21][8]),
    .sum(inter[22][8]),
    .c_out(carry[22][8])
  );
  fa fa_22_9 (
    .a(partial_products[12][10]),
    .b(inter[22][8]),
    .c_in(carry[21][9]),
    .sum(inter[22][9]),
    .c_out(carry[22][9])
  );
  fa fa_22_10 (
    .a(partial_products[11][11]),
    .b(inter[22][9]),
    .c_in(carry[21][10]),
    .sum(inter[22][10]),
    .c_out(carry[22][10])
  );
  fa fa_22_11 (
    .a(partial_products[10][12]),
    .b(inter[22][10]),
    .c_in(carry[21][11]),
    .sum(inter[22][11]),
    .c_out(carry[22][11])
  );
  fa fa_22_12 (
    .a(partial_products[9][13]),
    .b(inter[22][11]),
    .c_in(carry[21][12]),
    .sum(inter[22][12]),
    .c_out(carry[22][12])
  );
  fa fa_22_13 (
    .a(partial_products[8][14]),
    .b(inter[22][12]),
    .c_in(carry[21][13]),
    .sum(inter[22][13]),
    .c_out(carry[22][13])
  );
  fa fa_22_14 (
    .a(partial_products[7][15]),
    .b(inter[22][13]),
    .c_in(carry[21][14]),
    .sum(inter[22][14]),
    .c_out(carry[22][14])
  );
  fa fa_22_15 (
    .a(partial_products[6][16]),
    .b(inter[22][14]),
    .c_in(carry[21][15]),
    .sum(inter[22][15]),
    .c_out(carry[22][15])
  );
  fa fa_22_16 (
    .a(partial_products[5][17]),
    .b(inter[22][15]),
    .c_in(carry[21][16]),
    .sum(inter[22][16]),
    .c_out(carry[22][16])
  );
  fa fa_22_17 (
    .a(partial_products[4][18]),
    .b(inter[22][16]),
    .c_in(carry[21][17]),
    .sum(inter[22][17]),
    .c_out(carry[22][17])
  );
  fa fa_22_18 (
    .a(partial_products[3][19]),
    .b(inter[22][17]),
    .c_in(carry[21][18]),
    .sum(inter[22][18]),
    .c_out(carry[22][18])
  );
  fa fa_22_19 (
    .a(partial_products[2][20]),
    .b(inter[22][18]),
    .c_in(carry[21][19]),
    .sum(inter[22][19]),
    .c_out(carry[22][19])
  );
  fa fa_22_20 (
    .a(partial_products[1][21]),
    .b(inter[22][19]),
    .c_in(carry[21][20]),
    .sum(inter[22][20]),
    .c_out(carry[22][20])
  );
  ha ha_22_21 (
    .a(partial_products[0][22]),
    .b(inter[22][20]),
    .sum(product[22]),
    .c_out(carry[22][21])
  );

  fa fa_23_0 (
    .a(partial_products[23][0]),
    .b(partial_products[22][1]),
    .c_in(carry[22][0]),
    .sum(inter[23][0]),
    .c_out(carry[23][0])
  );
  fa fa_23_1 (
    .a(partial_products[21][2]),
    .b(inter[23][0]),
    .c_in(carry[22][1]),
    .sum(inter[23][1]),
    .c_out(carry[23][1])
  );
  fa fa_23_2 (
    .a(partial_products[20][3]),
    .b(inter[23][1]),
    .c_in(carry[22][2]),
    .sum(inter[23][2]),
    .c_out(carry[23][2])
  );
  fa fa_23_3 (
    .a(partial_products[19][4]),
    .b(inter[23][2]),
    .c_in(carry[22][3]),
    .sum(inter[23][3]),
    .c_out(carry[23][3])
  );
  fa fa_23_4 (
    .a(partial_products[18][5]),
    .b(inter[23][3]),
    .c_in(carry[22][4]),
    .sum(inter[23][4]),
    .c_out(carry[23][4])
  );
  fa fa_23_5 (
    .a(partial_products[17][6]),
    .b(inter[23][4]),
    .c_in(carry[22][5]),
    .sum(inter[23][5]),
    .c_out(carry[23][5])
  );
  fa fa_23_6 (
    .a(partial_products[16][7]),
    .b(inter[23][5]),
    .c_in(carry[22][6]),
    .sum(inter[23][6]),
    .c_out(carry[23][6])
  );
  fa fa_23_7 (
    .a(partial_products[15][8]),
    .b(inter[23][6]),
    .c_in(carry[22][7]),
    .sum(inter[23][7]),
    .c_out(carry[23][7])
  );
  fa fa_23_8 (
    .a(partial_products[14][9]),
    .b(inter[23][7]),
    .c_in(carry[22][8]),
    .sum(inter[23][8]),
    .c_out(carry[23][8])
  );
  fa fa_23_9 (
    .a(partial_products[13][10]),
    .b(inter[23][8]),
    .c_in(carry[22][9]),
    .sum(inter[23][9]),
    .c_out(carry[23][9])
  );
  fa fa_23_10 (
    .a(partial_products[12][11]),
    .b(inter[23][9]),
    .c_in(carry[22][10]),
    .sum(inter[23][10]),
    .c_out(carry[23][10])
  );
  fa fa_23_11 (
    .a(partial_products[11][12]),
    .b(inter[23][10]),
    .c_in(carry[22][11]),
    .sum(inter[23][11]),
    .c_out(carry[23][11])
  );
  fa fa_23_12 (
    .a(partial_products[10][13]),
    .b(inter[23][11]),
    .c_in(carry[22][12]),
    .sum(inter[23][12]),
    .c_out(carry[23][12])
  );
  fa fa_23_13 (
    .a(partial_products[9][14]),
    .b(inter[23][12]),
    .c_in(carry[22][13]),
    .sum(inter[23][13]),
    .c_out(carry[23][13])
  );
  fa fa_23_14 (
    .a(partial_products[8][15]),
    .b(inter[23][13]),
    .c_in(carry[22][14]),
    .sum(inter[23][14]),
    .c_out(carry[23][14])
  );
  fa fa_23_15 (
    .a(partial_products[7][16]),
    .b(inter[23][14]),
    .c_in(carry[22][15]),
    .sum(inter[23][15]),
    .c_out(carry[23][15])
  );
  fa fa_23_16 (
    .a(partial_products[6][17]),
    .b(inter[23][15]),
    .c_in(carry[22][16]),
    .sum(inter[23][16]),
    .c_out(carry[23][16])
  );
  fa fa_23_17 (
    .a(partial_products[5][18]),
    .b(inter[23][16]),
    .c_in(carry[22][17]),
    .sum(inter[23][17]),
    .c_out(carry[23][17])
  );
  fa fa_23_18 (
    .a(partial_products[4][19]),
    .b(inter[23][17]),
    .c_in(carry[22][18]),
    .sum(inter[23][18]),
    .c_out(carry[23][18])
  );
  fa fa_23_19 (
    .a(partial_products[3][20]),
    .b(inter[23][18]),
    .c_in(carry[22][19]),
    .sum(inter[23][19]),
    .c_out(carry[23][19])
  );
  fa fa_23_20 (
    .a(partial_products[2][21]),
    .b(inter[23][19]),
    .c_in(carry[22][20]),
    .sum(inter[23][20]),
    .c_out(carry[23][20])
  );
  fa fa_23_21 (
    .a(partial_products[1][22]),
    .b(inter[23][20]),
    .c_in(carry[22][21]),
    .sum(inter[23][21]),
    .c_out(carry[23][21])
  );
  ha ha_23_22 (
    .a(partial_products[0][23]),
    .b(inter[23][21]),
    .sum(product[23]),
    .c_out(carry[23][22])
  );

  fa fa_24_0 (
    .a(partial_products[24][0]),
    .b(partial_products[23][1]),
    .c_in(carry[23][0]),
    .sum(inter[24][0]),
    .c_out(carry[24][0])
  );
  fa fa_24_1 (
    .a(partial_products[22][2]),
    .b(inter[24][0]),
    .c_in(carry[23][1]),
    .sum(inter[24][1]),
    .c_out(carry[24][1])
  );
  fa fa_24_2 (
    .a(partial_products[21][3]),
    .b(inter[24][1]),
    .c_in(carry[23][2]),
    .sum(inter[24][2]),
    .c_out(carry[24][2])
  );
  fa fa_24_3 (
    .a(partial_products[20][4]),
    .b(inter[24][2]),
    .c_in(carry[23][3]),
    .sum(inter[24][3]),
    .c_out(carry[24][3])
  );
  fa fa_24_4 (
    .a(partial_products[19][5]),
    .b(inter[24][3]),
    .c_in(carry[23][4]),
    .sum(inter[24][4]),
    .c_out(carry[24][4])
  );
  fa fa_24_5 (
    .a(partial_products[18][6]),
    .b(inter[24][4]),
    .c_in(carry[23][5]),
    .sum(inter[24][5]),
    .c_out(carry[24][5])
  );
  fa fa_24_6 (
    .a(partial_products[17][7]),
    .b(inter[24][5]),
    .c_in(carry[23][6]),
    .sum(inter[24][6]),
    .c_out(carry[24][6])
  );
  fa fa_24_7 (
    .a(partial_products[16][8]),
    .b(inter[24][6]),
    .c_in(carry[23][7]),
    .sum(inter[24][7]),
    .c_out(carry[24][7])
  );
  fa fa_24_8 (
    .a(partial_products[15][9]),
    .b(inter[24][7]),
    .c_in(carry[23][8]),
    .sum(inter[24][8]),
    .c_out(carry[24][8])
  );
  fa fa_24_9 (
    .a(partial_products[14][10]),
    .b(inter[24][8]),
    .c_in(carry[23][9]),
    .sum(inter[24][9]),
    .c_out(carry[24][9])
  );
  fa fa_24_10 (
    .a(partial_products[13][11]),
    .b(inter[24][9]),
    .c_in(carry[23][10]),
    .sum(inter[24][10]),
    .c_out(carry[24][10])
  );
  fa fa_24_11 (
    .a(partial_products[12][12]),
    .b(inter[24][10]),
    .c_in(carry[23][11]),
    .sum(inter[24][11]),
    .c_out(carry[24][11])
  );
  fa fa_24_12 (
    .a(partial_products[11][13]),
    .b(inter[24][11]),
    .c_in(carry[23][12]),
    .sum(inter[24][12]),
    .c_out(carry[24][12])
  );
  fa fa_24_13 (
    .a(partial_products[10][14]),
    .b(inter[24][12]),
    .c_in(carry[23][13]),
    .sum(inter[24][13]),
    .c_out(carry[24][13])
  );
  fa fa_24_14 (
    .a(partial_products[9][15]),
    .b(inter[24][13]),
    .c_in(carry[23][14]),
    .sum(inter[24][14]),
    .c_out(carry[24][14])
  );
  fa fa_24_15 (
    .a(partial_products[8][16]),
    .b(inter[24][14]),
    .c_in(carry[23][15]),
    .sum(inter[24][15]),
    .c_out(carry[24][15])
  );
  fa fa_24_16 (
    .a(partial_products[7][17]),
    .b(inter[24][15]),
    .c_in(carry[23][16]),
    .sum(inter[24][16]),
    .c_out(carry[24][16])
  );
  fa fa_24_17 (
    .a(partial_products[6][18]),
    .b(inter[24][16]),
    .c_in(carry[23][17]),
    .sum(inter[24][17]),
    .c_out(carry[24][17])
  );
  fa fa_24_18 (
    .a(partial_products[5][19]),
    .b(inter[24][17]),
    .c_in(carry[23][18]),
    .sum(inter[24][18]),
    .c_out(carry[24][18])
  );
  fa fa_24_19 (
    .a(partial_products[4][20]),
    .b(inter[24][18]),
    .c_in(carry[23][19]),
    .sum(inter[24][19]),
    .c_out(carry[24][19])
  );
  fa fa_24_20 (
    .a(partial_products[3][21]),
    .b(inter[24][19]),
    .c_in(carry[23][20]),
    .sum(inter[24][20]),
    .c_out(carry[24][20])
  );
  fa fa_24_21 (
    .a(partial_products[2][22]),
    .b(inter[24][20]),
    .c_in(carry[23][21]),
    .sum(inter[24][21]),
    .c_out(carry[24][21])
  );
  fa fa_24_22 (
    .a(partial_products[1][23]),
    .b(inter[24][21]),
    .c_in(carry[23][22]),
    .sum(inter[24][22]),
    .c_out(carry[24][22])
  );
  ha ha_24_23 (
    .a(partial_products[0][24]),
    .b(inter[24][22]),
    .sum(product[24]),
    .c_out(carry[24][23])
  );

  fa fa_25_0 (
    .a(partial_products[25][0]),
    .b(partial_products[24][1]),
    .c_in(carry[24][0]),
    .sum(inter[25][0]),
    .c_out(carry[25][0])
  );
  fa fa_25_1 (
    .a(partial_products[23][2]),
    .b(inter[25][0]),
    .c_in(carry[24][1]),
    .sum(inter[25][1]),
    .c_out(carry[25][1])
  );
  fa fa_25_2 (
    .a(partial_products[22][3]),
    .b(inter[25][1]),
    .c_in(carry[24][2]),
    .sum(inter[25][2]),
    .c_out(carry[25][2])
  );
  fa fa_25_3 (
    .a(partial_products[21][4]),
    .b(inter[25][2]),
    .c_in(carry[24][3]),
    .sum(inter[25][3]),
    .c_out(carry[25][3])
  );
  fa fa_25_4 (
    .a(partial_products[20][5]),
    .b(inter[25][3]),
    .c_in(carry[24][4]),
    .sum(inter[25][4]),
    .c_out(carry[25][4])
  );
  fa fa_25_5 (
    .a(partial_products[19][6]),
    .b(inter[25][4]),
    .c_in(carry[24][5]),
    .sum(inter[25][5]),
    .c_out(carry[25][5])
  );
  fa fa_25_6 (
    .a(partial_products[18][7]),
    .b(inter[25][5]),
    .c_in(carry[24][6]),
    .sum(inter[25][6]),
    .c_out(carry[25][6])
  );
  fa fa_25_7 (
    .a(partial_products[17][8]),
    .b(inter[25][6]),
    .c_in(carry[24][7]),
    .sum(inter[25][7]),
    .c_out(carry[25][7])
  );
  fa fa_25_8 (
    .a(partial_products[16][9]),
    .b(inter[25][7]),
    .c_in(carry[24][8]),
    .sum(inter[25][8]),
    .c_out(carry[25][8])
  );
  fa fa_25_9 (
    .a(partial_products[15][10]),
    .b(inter[25][8]),
    .c_in(carry[24][9]),
    .sum(inter[25][9]),
    .c_out(carry[25][9])
  );
  fa fa_25_10 (
    .a(partial_products[14][11]),
    .b(inter[25][9]),
    .c_in(carry[24][10]),
    .sum(inter[25][10]),
    .c_out(carry[25][10])
  );
  fa fa_25_11 (
    .a(partial_products[13][12]),
    .b(inter[25][10]),
    .c_in(carry[24][11]),
    .sum(inter[25][11]),
    .c_out(carry[25][11])
  );
  fa fa_25_12 (
    .a(partial_products[12][13]),
    .b(inter[25][11]),
    .c_in(carry[24][12]),
    .sum(inter[25][12]),
    .c_out(carry[25][12])
  );
  fa fa_25_13 (
    .a(partial_products[11][14]),
    .b(inter[25][12]),
    .c_in(carry[24][13]),
    .sum(inter[25][13]),
    .c_out(carry[25][13])
  );
  fa fa_25_14 (
    .a(partial_products[10][15]),
    .b(inter[25][13]),
    .c_in(carry[24][14]),
    .sum(inter[25][14]),
    .c_out(carry[25][14])
  );
  fa fa_25_15 (
    .a(partial_products[9][16]),
    .b(inter[25][14]),
    .c_in(carry[24][15]),
    .sum(inter[25][15]),
    .c_out(carry[25][15])
  );
  fa fa_25_16 (
    .a(partial_products[8][17]),
    .b(inter[25][15]),
    .c_in(carry[24][16]),
    .sum(inter[25][16]),
    .c_out(carry[25][16])
  );
  fa fa_25_17 (
    .a(partial_products[7][18]),
    .b(inter[25][16]),
    .c_in(carry[24][17]),
    .sum(inter[25][17]),
    .c_out(carry[25][17])
  );
  fa fa_25_18 (
    .a(partial_products[6][19]),
    .b(inter[25][17]),
    .c_in(carry[24][18]),
    .sum(inter[25][18]),
    .c_out(carry[25][18])
  );
  fa fa_25_19 (
    .a(partial_products[5][20]),
    .b(inter[25][18]),
    .c_in(carry[24][19]),
    .sum(inter[25][19]),
    .c_out(carry[25][19])
  );
  fa fa_25_20 (
    .a(partial_products[4][21]),
    .b(inter[25][19]),
    .c_in(carry[24][20]),
    .sum(inter[25][20]),
    .c_out(carry[25][20])
  );
  fa fa_25_21 (
    .a(partial_products[3][22]),
    .b(inter[25][20]),
    .c_in(carry[24][21]),
    .sum(inter[25][21]),
    .c_out(carry[25][21])
  );
  fa fa_25_22 (
    .a(partial_products[2][23]),
    .b(inter[25][21]),
    .c_in(carry[24][22]),
    .sum(inter[25][22]),
    .c_out(carry[25][22])
  );
  fa fa_25_23 (
    .a(partial_products[1][24]),
    .b(inter[25][22]),
    .c_in(carry[24][23]),
    .sum(inter[25][23]),
    .c_out(carry[25][23])
  );
  ha ha_25_24 (
    .a(partial_products[0][25]),
    .b(inter[25][23]),
    .sum(product[25]),
    .c_out(carry[25][24])
  );

  fa fa_26_0 (
    .a(partial_products[26][0]),
    .b(partial_products[25][1]),
    .c_in(carry[25][0]),
    .sum(inter[26][0]),
    .c_out(carry[26][0])
  );
  fa fa_26_1 (
    .a(partial_products[24][2]),
    .b(inter[26][0]),
    .c_in(carry[25][1]),
    .sum(inter[26][1]),
    .c_out(carry[26][1])
  );
  fa fa_26_2 (
    .a(partial_products[23][3]),
    .b(inter[26][1]),
    .c_in(carry[25][2]),
    .sum(inter[26][2]),
    .c_out(carry[26][2])
  );
  fa fa_26_3 (
    .a(partial_products[22][4]),
    .b(inter[26][2]),
    .c_in(carry[25][3]),
    .sum(inter[26][3]),
    .c_out(carry[26][3])
  );
  fa fa_26_4 (
    .a(partial_products[21][5]),
    .b(inter[26][3]),
    .c_in(carry[25][4]),
    .sum(inter[26][4]),
    .c_out(carry[26][4])
  );
  fa fa_26_5 (
    .a(partial_products[20][6]),
    .b(inter[26][4]),
    .c_in(carry[25][5]),
    .sum(inter[26][5]),
    .c_out(carry[26][5])
  );
  fa fa_26_6 (
    .a(partial_products[19][7]),
    .b(inter[26][5]),
    .c_in(carry[25][6]),
    .sum(inter[26][6]),
    .c_out(carry[26][6])
  );
  fa fa_26_7 (
    .a(partial_products[18][8]),
    .b(inter[26][6]),
    .c_in(carry[25][7]),
    .sum(inter[26][7]),
    .c_out(carry[26][7])
  );
  fa fa_26_8 (
    .a(partial_products[17][9]),
    .b(inter[26][7]),
    .c_in(carry[25][8]),
    .sum(inter[26][8]),
    .c_out(carry[26][8])
  );
  fa fa_26_9 (
    .a(partial_products[16][10]),
    .b(inter[26][8]),
    .c_in(carry[25][9]),
    .sum(inter[26][9]),
    .c_out(carry[26][9])
  );
  fa fa_26_10 (
    .a(partial_products[15][11]),
    .b(inter[26][9]),
    .c_in(carry[25][10]),
    .sum(inter[26][10]),
    .c_out(carry[26][10])
  );
  fa fa_26_11 (
    .a(partial_products[14][12]),
    .b(inter[26][10]),
    .c_in(carry[25][11]),
    .sum(inter[26][11]),
    .c_out(carry[26][11])
  );
  fa fa_26_12 (
    .a(partial_products[13][13]),
    .b(inter[26][11]),
    .c_in(carry[25][12]),
    .sum(inter[26][12]),
    .c_out(carry[26][12])
  );
  fa fa_26_13 (
    .a(partial_products[12][14]),
    .b(inter[26][12]),
    .c_in(carry[25][13]),
    .sum(inter[26][13]),
    .c_out(carry[26][13])
  );
  fa fa_26_14 (
    .a(partial_products[11][15]),
    .b(inter[26][13]),
    .c_in(carry[25][14]),
    .sum(inter[26][14]),
    .c_out(carry[26][14])
  );
  fa fa_26_15 (
    .a(partial_products[10][16]),
    .b(inter[26][14]),
    .c_in(carry[25][15]),
    .sum(inter[26][15]),
    .c_out(carry[26][15])
  );
  fa fa_26_16 (
    .a(partial_products[9][17]),
    .b(inter[26][15]),
    .c_in(carry[25][16]),
    .sum(inter[26][16]),
    .c_out(carry[26][16])
  );
  fa fa_26_17 (
    .a(partial_products[8][18]),
    .b(inter[26][16]),
    .c_in(carry[25][17]),
    .sum(inter[26][17]),
    .c_out(carry[26][17])
  );
  fa fa_26_18 (
    .a(partial_products[7][19]),
    .b(inter[26][17]),
    .c_in(carry[25][18]),
    .sum(inter[26][18]),
    .c_out(carry[26][18])
  );
  fa fa_26_19 (
    .a(partial_products[6][20]),
    .b(inter[26][18]),
    .c_in(carry[25][19]),
    .sum(inter[26][19]),
    .c_out(carry[26][19])
  );
  fa fa_26_20 (
    .a(partial_products[5][21]),
    .b(inter[26][19]),
    .c_in(carry[25][20]),
    .sum(inter[26][20]),
    .c_out(carry[26][20])
  );
  fa fa_26_21 (
    .a(partial_products[4][22]),
    .b(inter[26][20]),
    .c_in(carry[25][21]),
    .sum(inter[26][21]),
    .c_out(carry[26][21])
  );
  fa fa_26_22 (
    .a(partial_products[3][23]),
    .b(inter[26][21]),
    .c_in(carry[25][22]),
    .sum(inter[26][22]),
    .c_out(carry[26][22])
  );
  fa fa_26_23 (
    .a(partial_products[2][24]),
    .b(inter[26][22]),
    .c_in(carry[25][23]),
    .sum(inter[26][23]),
    .c_out(carry[26][23])
  );
  fa fa_26_24 (
    .a(partial_products[1][25]),
    .b(inter[26][23]),
    .c_in(carry[25][24]),
    .sum(inter[26][24]),
    .c_out(carry[26][24])
  );
  ha ha_26_25 (
    .a(partial_products[0][26]),
    .b(inter[26][24]),
    .sum(product[26]),
    .c_out(carry[26][25])
  );

  fa fa_27_0 (
    .a(partial_products[27][0]),
    .b(partial_products[26][1]),
    .c_in(carry[26][0]),
    .sum(inter[27][0]),
    .c_out(carry[27][0])
  );
  fa fa_27_1 (
    .a(partial_products[25][2]),
    .b(inter[27][0]),
    .c_in(carry[26][1]),
    .sum(inter[27][1]),
    .c_out(carry[27][1])
  );
  fa fa_27_2 (
    .a(partial_products[24][3]),
    .b(inter[27][1]),
    .c_in(carry[26][2]),
    .sum(inter[27][2]),
    .c_out(carry[27][2])
  );
  fa fa_27_3 (
    .a(partial_products[23][4]),
    .b(inter[27][2]),
    .c_in(carry[26][3]),
    .sum(inter[27][3]),
    .c_out(carry[27][3])
  );
  fa fa_27_4 (
    .a(partial_products[22][5]),
    .b(inter[27][3]),
    .c_in(carry[26][4]),
    .sum(inter[27][4]),
    .c_out(carry[27][4])
  );
  fa fa_27_5 (
    .a(partial_products[21][6]),
    .b(inter[27][4]),
    .c_in(carry[26][5]),
    .sum(inter[27][5]),
    .c_out(carry[27][5])
  );
  fa fa_27_6 (
    .a(partial_products[20][7]),
    .b(inter[27][5]),
    .c_in(carry[26][6]),
    .sum(inter[27][6]),
    .c_out(carry[27][6])
  );
  fa fa_27_7 (
    .a(partial_products[19][8]),
    .b(inter[27][6]),
    .c_in(carry[26][7]),
    .sum(inter[27][7]),
    .c_out(carry[27][7])
  );
  fa fa_27_8 (
    .a(partial_products[18][9]),
    .b(inter[27][7]),
    .c_in(carry[26][8]),
    .sum(inter[27][8]),
    .c_out(carry[27][8])
  );
  fa fa_27_9 (
    .a(partial_products[17][10]),
    .b(inter[27][8]),
    .c_in(carry[26][9]),
    .sum(inter[27][9]),
    .c_out(carry[27][9])
  );
  fa fa_27_10 (
    .a(partial_products[16][11]),
    .b(inter[27][9]),
    .c_in(carry[26][10]),
    .sum(inter[27][10]),
    .c_out(carry[27][10])
  );
  fa fa_27_11 (
    .a(partial_products[15][12]),
    .b(inter[27][10]),
    .c_in(carry[26][11]),
    .sum(inter[27][11]),
    .c_out(carry[27][11])
  );
  fa fa_27_12 (
    .a(partial_products[14][13]),
    .b(inter[27][11]),
    .c_in(carry[26][12]),
    .sum(inter[27][12]),
    .c_out(carry[27][12])
  );
  fa fa_27_13 (
    .a(partial_products[13][14]),
    .b(inter[27][12]),
    .c_in(carry[26][13]),
    .sum(inter[27][13]),
    .c_out(carry[27][13])
  );
  fa fa_27_14 (
    .a(partial_products[12][15]),
    .b(inter[27][13]),
    .c_in(carry[26][14]),
    .sum(inter[27][14]),
    .c_out(carry[27][14])
  );
  fa fa_27_15 (
    .a(partial_products[11][16]),
    .b(inter[27][14]),
    .c_in(carry[26][15]),
    .sum(inter[27][15]),
    .c_out(carry[27][15])
  );
  fa fa_27_16 (
    .a(partial_products[10][17]),
    .b(inter[27][15]),
    .c_in(carry[26][16]),
    .sum(inter[27][16]),
    .c_out(carry[27][16])
  );
  fa fa_27_17 (
    .a(partial_products[9][18]),
    .b(inter[27][16]),
    .c_in(carry[26][17]),
    .sum(inter[27][17]),
    .c_out(carry[27][17])
  );
  fa fa_27_18 (
    .a(partial_products[8][19]),
    .b(inter[27][17]),
    .c_in(carry[26][18]),
    .sum(inter[27][18]),
    .c_out(carry[27][18])
  );
  fa fa_27_19 (
    .a(partial_products[7][20]),
    .b(inter[27][18]),
    .c_in(carry[26][19]),
    .sum(inter[27][19]),
    .c_out(carry[27][19])
  );
  fa fa_27_20 (
    .a(partial_products[6][21]),
    .b(inter[27][19]),
    .c_in(carry[26][20]),
    .sum(inter[27][20]),
    .c_out(carry[27][20])
  );
  fa fa_27_21 (
    .a(partial_products[5][22]),
    .b(inter[27][20]),
    .c_in(carry[26][21]),
    .sum(inter[27][21]),
    .c_out(carry[27][21])
  );
  fa fa_27_22 (
    .a(partial_products[4][23]),
    .b(inter[27][21]),
    .c_in(carry[26][22]),
    .sum(inter[27][22]),
    .c_out(carry[27][22])
  );
  fa fa_27_23 (
    .a(partial_products[3][24]),
    .b(inter[27][22]),
    .c_in(carry[26][23]),
    .sum(inter[27][23]),
    .c_out(carry[27][23])
  );
  fa fa_27_24 (
    .a(partial_products[2][25]),
    .b(inter[27][23]),
    .c_in(carry[26][24]),
    .sum(inter[27][24]),
    .c_out(carry[27][24])
  );
  fa fa_27_25 (
    .a(partial_products[1][26]),
    .b(inter[27][24]),
    .c_in(carry[26][25]),
    .sum(inter[27][25]),
    .c_out(carry[27][25])
  );
  ha ha_27_26 (
    .a(partial_products[0][27]),
    .b(inter[27][25]),
    .sum(product[27]),
    .c_out(carry[27][26])
  );

  fa fa_28_0 (
    .a(partial_products[28][0]),
    .b(partial_products[27][1]),
    .c_in(carry[27][0]),
    .sum(inter[28][0]),
    .c_out(carry[28][0])
  );
  fa fa_28_1 (
    .a(partial_products[26][2]),
    .b(inter[28][0]),
    .c_in(carry[27][1]),
    .sum(inter[28][1]),
    .c_out(carry[28][1])
  );
  fa fa_28_2 (
    .a(partial_products[25][3]),
    .b(inter[28][1]),
    .c_in(carry[27][2]),
    .sum(inter[28][2]),
    .c_out(carry[28][2])
  );
  fa fa_28_3 (
    .a(partial_products[24][4]),
    .b(inter[28][2]),
    .c_in(carry[27][3]),
    .sum(inter[28][3]),
    .c_out(carry[28][3])
  );
  fa fa_28_4 (
    .a(partial_products[23][5]),
    .b(inter[28][3]),
    .c_in(carry[27][4]),
    .sum(inter[28][4]),
    .c_out(carry[28][4])
  );
  fa fa_28_5 (
    .a(partial_products[22][6]),
    .b(inter[28][4]),
    .c_in(carry[27][5]),
    .sum(inter[28][5]),
    .c_out(carry[28][5])
  );
  fa fa_28_6 (
    .a(partial_products[21][7]),
    .b(inter[28][5]),
    .c_in(carry[27][6]),
    .sum(inter[28][6]),
    .c_out(carry[28][6])
  );
  fa fa_28_7 (
    .a(partial_products[20][8]),
    .b(inter[28][6]),
    .c_in(carry[27][7]),
    .sum(inter[28][7]),
    .c_out(carry[28][7])
  );
  fa fa_28_8 (
    .a(partial_products[19][9]),
    .b(inter[28][7]),
    .c_in(carry[27][8]),
    .sum(inter[28][8]),
    .c_out(carry[28][8])
  );
  fa fa_28_9 (
    .a(partial_products[18][10]),
    .b(inter[28][8]),
    .c_in(carry[27][9]),
    .sum(inter[28][9]),
    .c_out(carry[28][9])
  );
  fa fa_28_10 (
    .a(partial_products[17][11]),
    .b(inter[28][9]),
    .c_in(carry[27][10]),
    .sum(inter[28][10]),
    .c_out(carry[28][10])
  );
  fa fa_28_11 (
    .a(partial_products[16][12]),
    .b(inter[28][10]),
    .c_in(carry[27][11]),
    .sum(inter[28][11]),
    .c_out(carry[28][11])
  );
  fa fa_28_12 (
    .a(partial_products[15][13]),
    .b(inter[28][11]),
    .c_in(carry[27][12]),
    .sum(inter[28][12]),
    .c_out(carry[28][12])
  );
  fa fa_28_13 (
    .a(partial_products[14][14]),
    .b(inter[28][12]),
    .c_in(carry[27][13]),
    .sum(inter[28][13]),
    .c_out(carry[28][13])
  );
  fa fa_28_14 (
    .a(partial_products[13][15]),
    .b(inter[28][13]),
    .c_in(carry[27][14]),
    .sum(inter[28][14]),
    .c_out(carry[28][14])
  );
  fa fa_28_15 (
    .a(partial_products[12][16]),
    .b(inter[28][14]),
    .c_in(carry[27][15]),
    .sum(inter[28][15]),
    .c_out(carry[28][15])
  );
  fa fa_28_16 (
    .a(partial_products[11][17]),
    .b(inter[28][15]),
    .c_in(carry[27][16]),
    .sum(inter[28][16]),
    .c_out(carry[28][16])
  );
  fa fa_28_17 (
    .a(partial_products[10][18]),
    .b(inter[28][16]),
    .c_in(carry[27][17]),
    .sum(inter[28][17]),
    .c_out(carry[28][17])
  );
  fa fa_28_18 (
    .a(partial_products[9][19]),
    .b(inter[28][17]),
    .c_in(carry[27][18]),
    .sum(inter[28][18]),
    .c_out(carry[28][18])
  );
  fa fa_28_19 (
    .a(partial_products[8][20]),
    .b(inter[28][18]),
    .c_in(carry[27][19]),
    .sum(inter[28][19]),
    .c_out(carry[28][19])
  );
  fa fa_28_20 (
    .a(partial_products[7][21]),
    .b(inter[28][19]),
    .c_in(carry[27][20]),
    .sum(inter[28][20]),
    .c_out(carry[28][20])
  );
  fa fa_28_21 (
    .a(partial_products[6][22]),
    .b(inter[28][20]),
    .c_in(carry[27][21]),
    .sum(inter[28][21]),
    .c_out(carry[28][21])
  );
  fa fa_28_22 (
    .a(partial_products[5][23]),
    .b(inter[28][21]),
    .c_in(carry[27][22]),
    .sum(inter[28][22]),
    .c_out(carry[28][22])
  );
  fa fa_28_23 (
    .a(partial_products[4][24]),
    .b(inter[28][22]),
    .c_in(carry[27][23]),
    .sum(inter[28][23]),
    .c_out(carry[28][23])
  );
  fa fa_28_24 (
    .a(partial_products[3][25]),
    .b(inter[28][23]),
    .c_in(carry[27][24]),
    .sum(inter[28][24]),
    .c_out(carry[28][24])
  );
  fa fa_28_25 (
    .a(partial_products[2][26]),
    .b(inter[28][24]),
    .c_in(carry[27][25]),
    .sum(inter[28][25]),
    .c_out(carry[28][25])
  );
  fa fa_28_26 (
    .a(partial_products[1][27]),
    .b(inter[28][25]),
    .c_in(carry[27][26]),
    .sum(inter[28][26]),
    .c_out(carry[28][26])
  );
  ha ha_28_27 (
    .a(partial_products[0][28]),
    .b(inter[28][26]),
    .sum(product[28]),
    .c_out(carry[28][27])
  );

  fa fa_29_0 (
    .a(partial_products[29][0]),
    .b(partial_products[28][1]),
    .c_in(carry[28][0]),
    .sum(inter[29][0]),
    .c_out(carry[29][0])
  );
  fa fa_29_1 (
    .a(partial_products[27][2]),
    .b(inter[29][0]),
    .c_in(carry[28][1]),
    .sum(inter[29][1]),
    .c_out(carry[29][1])
  );
  fa fa_29_2 (
    .a(partial_products[26][3]),
    .b(inter[29][1]),
    .c_in(carry[28][2]),
    .sum(inter[29][2]),
    .c_out(carry[29][2])
  );
  fa fa_29_3 (
    .a(partial_products[25][4]),
    .b(inter[29][2]),
    .c_in(carry[28][3]),
    .sum(inter[29][3]),
    .c_out(carry[29][3])
  );
  fa fa_29_4 (
    .a(partial_products[24][5]),
    .b(inter[29][3]),
    .c_in(carry[28][4]),
    .sum(inter[29][4]),
    .c_out(carry[29][4])
  );
  fa fa_29_5 (
    .a(partial_products[23][6]),
    .b(inter[29][4]),
    .c_in(carry[28][5]),
    .sum(inter[29][5]),
    .c_out(carry[29][5])
  );
  fa fa_29_6 (
    .a(partial_products[22][7]),
    .b(inter[29][5]),
    .c_in(carry[28][6]),
    .sum(inter[29][6]),
    .c_out(carry[29][6])
  );
  fa fa_29_7 (
    .a(partial_products[21][8]),
    .b(inter[29][6]),
    .c_in(carry[28][7]),
    .sum(inter[29][7]),
    .c_out(carry[29][7])
  );
  fa fa_29_8 (
    .a(partial_products[20][9]),
    .b(inter[29][7]),
    .c_in(carry[28][8]),
    .sum(inter[29][8]),
    .c_out(carry[29][8])
  );
  fa fa_29_9 (
    .a(partial_products[19][10]),
    .b(inter[29][8]),
    .c_in(carry[28][9]),
    .sum(inter[29][9]),
    .c_out(carry[29][9])
  );
  fa fa_29_10 (
    .a(partial_products[18][11]),
    .b(inter[29][9]),
    .c_in(carry[28][10]),
    .sum(inter[29][10]),
    .c_out(carry[29][10])
  );
  fa fa_29_11 (
    .a(partial_products[17][12]),
    .b(inter[29][10]),
    .c_in(carry[28][11]),
    .sum(inter[29][11]),
    .c_out(carry[29][11])
  );
  fa fa_29_12 (
    .a(partial_products[16][13]),
    .b(inter[29][11]),
    .c_in(carry[28][12]),
    .sum(inter[29][12]),
    .c_out(carry[29][12])
  );
  fa fa_29_13 (
    .a(partial_products[15][14]),
    .b(inter[29][12]),
    .c_in(carry[28][13]),
    .sum(inter[29][13]),
    .c_out(carry[29][13])
  );
  fa fa_29_14 (
    .a(partial_products[14][15]),
    .b(inter[29][13]),
    .c_in(carry[28][14]),
    .sum(inter[29][14]),
    .c_out(carry[29][14])
  );
  fa fa_29_15 (
    .a(partial_products[13][16]),
    .b(inter[29][14]),
    .c_in(carry[28][15]),
    .sum(inter[29][15]),
    .c_out(carry[29][15])
  );
  fa fa_29_16 (
    .a(partial_products[12][17]),
    .b(inter[29][15]),
    .c_in(carry[28][16]),
    .sum(inter[29][16]),
    .c_out(carry[29][16])
  );
  fa fa_29_17 (
    .a(partial_products[11][18]),
    .b(inter[29][16]),
    .c_in(carry[28][17]),
    .sum(inter[29][17]),
    .c_out(carry[29][17])
  );
  fa fa_29_18 (
    .a(partial_products[10][19]),
    .b(inter[29][17]),
    .c_in(carry[28][18]),
    .sum(inter[29][18]),
    .c_out(carry[29][18])
  );
  fa fa_29_19 (
    .a(partial_products[9][20]),
    .b(inter[29][18]),
    .c_in(carry[28][19]),
    .sum(inter[29][19]),
    .c_out(carry[29][19])
  );
  fa fa_29_20 (
    .a(partial_products[8][21]),
    .b(inter[29][19]),
    .c_in(carry[28][20]),
    .sum(inter[29][20]),
    .c_out(carry[29][20])
  );
  fa fa_29_21 (
    .a(partial_products[7][22]),
    .b(inter[29][20]),
    .c_in(carry[28][21]),
    .sum(inter[29][21]),
    .c_out(carry[29][21])
  );
  fa fa_29_22 (
    .a(partial_products[6][23]),
    .b(inter[29][21]),
    .c_in(carry[28][22]),
    .sum(inter[29][22]),
    .c_out(carry[29][22])
  );
  fa fa_29_23 (
    .a(partial_products[5][24]),
    .b(inter[29][22]),
    .c_in(carry[28][23]),
    .sum(inter[29][23]),
    .c_out(carry[29][23])
  );
  fa fa_29_24 (
    .a(partial_products[4][25]),
    .b(inter[29][23]),
    .c_in(carry[28][24]),
    .sum(inter[29][24]),
    .c_out(carry[29][24])
  );
  fa fa_29_25 (
    .a(partial_products[3][26]),
    .b(inter[29][24]),
    .c_in(carry[28][25]),
    .sum(inter[29][25]),
    .c_out(carry[29][25])
  );
  fa fa_29_26 (
    .a(partial_products[2][27]),
    .b(inter[29][25]),
    .c_in(carry[28][26]),
    .sum(inter[29][26]),
    .c_out(carry[29][26])
  );
  fa fa_29_27 (
    .a(partial_products[1][28]),
    .b(inter[29][26]),
    .c_in(carry[28][27]),
    .sum(inter[29][27]),
    .c_out(carry[29][27])
  );
  ha ha_29_28 (
    .a(partial_products[0][29]),
    .b(inter[29][27]),
    .sum(product[29]),
    .c_out(carry[29][28])
  );

  fa fa_30_0 (
    .a(partial_products[30][0]),
    .b(partial_products[29][1]),
    .c_in(carry[29][0]),
    .sum(inter[30][0]),
    .c_out(carry[30][0])
  );
  fa fa_30_1 (
    .a(partial_products[28][2]),
    .b(inter[30][0]),
    .c_in(carry[29][1]),
    .sum(inter[30][1]),
    .c_out(carry[30][1])
  );
  fa fa_30_2 (
    .a(partial_products[27][3]),
    .b(inter[30][1]),
    .c_in(carry[29][2]),
    .sum(inter[30][2]),
    .c_out(carry[30][2])
  );
  fa fa_30_3 (
    .a(partial_products[26][4]),
    .b(inter[30][2]),
    .c_in(carry[29][3]),
    .sum(inter[30][3]),
    .c_out(carry[30][3])
  );
  fa fa_30_4 (
    .a(partial_products[25][5]),
    .b(inter[30][3]),
    .c_in(carry[29][4]),
    .sum(inter[30][4]),
    .c_out(carry[30][4])
  );
  fa fa_30_5 (
    .a(partial_products[24][6]),
    .b(inter[30][4]),
    .c_in(carry[29][5]),
    .sum(inter[30][5]),
    .c_out(carry[30][5])
  );
  fa fa_30_6 (
    .a(partial_products[23][7]),
    .b(inter[30][5]),
    .c_in(carry[29][6]),
    .sum(inter[30][6]),
    .c_out(carry[30][6])
  );
  fa fa_30_7 (
    .a(partial_products[22][8]),
    .b(inter[30][6]),
    .c_in(carry[29][7]),
    .sum(inter[30][7]),
    .c_out(carry[30][7])
  );
  fa fa_30_8 (
    .a(partial_products[21][9]),
    .b(inter[30][7]),
    .c_in(carry[29][8]),
    .sum(inter[30][8]),
    .c_out(carry[30][8])
  );
  fa fa_30_9 (
    .a(partial_products[20][10]),
    .b(inter[30][8]),
    .c_in(carry[29][9]),
    .sum(inter[30][9]),
    .c_out(carry[30][9])
  );
  fa fa_30_10 (
    .a(partial_products[19][11]),
    .b(inter[30][9]),
    .c_in(carry[29][10]),
    .sum(inter[30][10]),
    .c_out(carry[30][10])
  );
  fa fa_30_11 (
    .a(partial_products[18][12]),
    .b(inter[30][10]),
    .c_in(carry[29][11]),
    .sum(inter[30][11]),
    .c_out(carry[30][11])
  );
  fa fa_30_12 (
    .a(partial_products[17][13]),
    .b(inter[30][11]),
    .c_in(carry[29][12]),
    .sum(inter[30][12]),
    .c_out(carry[30][12])
  );
  fa fa_30_13 (
    .a(partial_products[16][14]),
    .b(inter[30][12]),
    .c_in(carry[29][13]),
    .sum(inter[30][13]),
    .c_out(carry[30][13])
  );
  fa fa_30_14 (
    .a(partial_products[15][15]),
    .b(inter[30][13]),
    .c_in(carry[29][14]),
    .sum(inter[30][14]),
    .c_out(carry[30][14])
  );
  fa fa_30_15 (
    .a(partial_products[14][16]),
    .b(inter[30][14]),
    .c_in(carry[29][15]),
    .sum(inter[30][15]),
    .c_out(carry[30][15])
  );
  fa fa_30_16 (
    .a(partial_products[13][17]),
    .b(inter[30][15]),
    .c_in(carry[29][16]),
    .sum(inter[30][16]),
    .c_out(carry[30][16])
  );
  fa fa_30_17 (
    .a(partial_products[12][18]),
    .b(inter[30][16]),
    .c_in(carry[29][17]),
    .sum(inter[30][17]),
    .c_out(carry[30][17])
  );
  fa fa_30_18 (
    .a(partial_products[11][19]),
    .b(inter[30][17]),
    .c_in(carry[29][18]),
    .sum(inter[30][18]),
    .c_out(carry[30][18])
  );
  fa fa_30_19 (
    .a(partial_products[10][20]),
    .b(inter[30][18]),
    .c_in(carry[29][19]),
    .sum(inter[30][19]),
    .c_out(carry[30][19])
  );
  fa fa_30_20 (
    .a(partial_products[9][21]),
    .b(inter[30][19]),
    .c_in(carry[29][20]),
    .sum(inter[30][20]),
    .c_out(carry[30][20])
  );
  fa fa_30_21 (
    .a(partial_products[8][22]),
    .b(inter[30][20]),
    .c_in(carry[29][21]),
    .sum(inter[30][21]),
    .c_out(carry[30][21])
  );
  fa fa_30_22 (
    .a(partial_products[7][23]),
    .b(inter[30][21]),
    .c_in(carry[29][22]),
    .sum(inter[30][22]),
    .c_out(carry[30][22])
  );
  fa fa_30_23 (
    .a(partial_products[6][24]),
    .b(inter[30][22]),
    .c_in(carry[29][23]),
    .sum(inter[30][23]),
    .c_out(carry[30][23])
  );
  fa fa_30_24 (
    .a(partial_products[5][25]),
    .b(inter[30][23]),
    .c_in(carry[29][24]),
    .sum(inter[30][24]),
    .c_out(carry[30][24])
  );
  fa fa_30_25 (
    .a(partial_products[4][26]),
    .b(inter[30][24]),
    .c_in(carry[29][25]),
    .sum(inter[30][25]),
    .c_out(carry[30][25])
  );
  fa fa_30_26 (
    .a(partial_products[3][27]),
    .b(inter[30][25]),
    .c_in(carry[29][26]),
    .sum(inter[30][26]),
    .c_out(carry[30][26])
  );
  fa fa_30_27 (
    .a(partial_products[2][28]),
    .b(inter[30][26]),
    .c_in(carry[29][27]),
    .sum(inter[30][27]),
    .c_out(carry[30][27])
  );
  fa fa_30_28 (
    .a(partial_products[1][29]),
    .b(inter[30][27]),
    .c_in(carry[29][28]),
    .sum(inter[30][28]),
    .c_out(carry[30][28])
  );
  ha ha_30_29 (
    .a(partial_products[0][30]),
    .b(inter[30][28]),
    .sum(product[30]),
    .c_out(carry[30][29])
  );

  fa fa_31_0 (
    .a(partial_products[31][0]),
    .b(partial_products[30][1]),
    .c_in(carry[30][0]),
    .sum(inter[31][0]),
    .c_out(carry[31][0])
  );
  fa fa_31_1 (
    .a(partial_products[29][2]),
    .b(inter[31][0]),
    .c_in(carry[30][1]),
    .sum(inter[31][1]),
    .c_out(carry[31][1])
  );
  fa fa_31_2 (
    .a(partial_products[28][3]),
    .b(inter[31][1]),
    .c_in(carry[30][2]),
    .sum(inter[31][2]),
    .c_out(carry[31][2])
  );
  fa fa_31_3 (
    .a(partial_products[27][4]),
    .b(inter[31][2]),
    .c_in(carry[30][3]),
    .sum(inter[31][3]),
    .c_out(carry[31][3])
  );
  fa fa_31_4 (
    .a(partial_products[26][5]),
    .b(inter[31][3]),
    .c_in(carry[30][4]),
    .sum(inter[31][4]),
    .c_out(carry[31][4])
  );
  fa fa_31_5 (
    .a(partial_products[25][6]),
    .b(inter[31][4]),
    .c_in(carry[30][5]),
    .sum(inter[31][5]),
    .c_out(carry[31][5])
  );
  fa fa_31_6 (
    .a(partial_products[24][7]),
    .b(inter[31][5]),
    .c_in(carry[30][6]),
    .sum(inter[31][6]),
    .c_out(carry[31][6])
  );
  fa fa_31_7 (
    .a(partial_products[23][8]),
    .b(inter[31][6]),
    .c_in(carry[30][7]),
    .sum(inter[31][7]),
    .c_out(carry[31][7])
  );
  fa fa_31_8 (
    .a(partial_products[22][9]),
    .b(inter[31][7]),
    .c_in(carry[30][8]),
    .sum(inter[31][8]),
    .c_out(carry[31][8])
  );
  fa fa_31_9 (
    .a(partial_products[21][10]),
    .b(inter[31][8]),
    .c_in(carry[30][9]),
    .sum(inter[31][9]),
    .c_out(carry[31][9])
  );
  fa fa_31_10 (
    .a(partial_products[20][11]),
    .b(inter[31][9]),
    .c_in(carry[30][10]),
    .sum(inter[31][10]),
    .c_out(carry[31][10])
  );
  fa fa_31_11 (
    .a(partial_products[19][12]),
    .b(inter[31][10]),
    .c_in(carry[30][11]),
    .sum(inter[31][11]),
    .c_out(carry[31][11])
  );
  fa fa_31_12 (
    .a(partial_products[18][13]),
    .b(inter[31][11]),
    .c_in(carry[30][12]),
    .sum(inter[31][12]),
    .c_out(carry[31][12])
  );
  fa fa_31_13 (
    .a(partial_products[17][14]),
    .b(inter[31][12]),
    .c_in(carry[30][13]),
    .sum(inter[31][13]),
    .c_out(carry[31][13])
  );
  fa fa_31_14 (
    .a(partial_products[16][15]),
    .b(inter[31][13]),
    .c_in(carry[30][14]),
    .sum(inter[31][14]),
    .c_out(carry[31][14])
  );
  fa fa_31_15 (
    .a(partial_products[15][16]),
    .b(inter[31][14]),
    .c_in(carry[30][15]),
    .sum(inter[31][15]),
    .c_out(carry[31][15])
  );
  fa fa_31_16 (
    .a(partial_products[14][17]),
    .b(inter[31][15]),
    .c_in(carry[30][16]),
    .sum(inter[31][16]),
    .c_out(carry[31][16])
  );
  fa fa_31_17 (
    .a(partial_products[13][18]),
    .b(inter[31][16]),
    .c_in(carry[30][17]),
    .sum(inter[31][17]),
    .c_out(carry[31][17])
  );
  fa fa_31_18 (
    .a(partial_products[12][19]),
    .b(inter[31][17]),
    .c_in(carry[30][18]),
    .sum(inter[31][18]),
    .c_out(carry[31][18])
  );
  fa fa_31_19 (
    .a(partial_products[11][20]),
    .b(inter[31][18]),
    .c_in(carry[30][19]),
    .sum(inter[31][19]),
    .c_out(carry[31][19])
  );
  fa fa_31_20 (
    .a(partial_products[10][21]),
    .b(inter[31][19]),
    .c_in(carry[30][20]),
    .sum(inter[31][20]),
    .c_out(carry[31][20])
  );
  fa fa_31_21 (
    .a(partial_products[9][22]),
    .b(inter[31][20]),
    .c_in(carry[30][21]),
    .sum(inter[31][21]),
    .c_out(carry[31][21])
  );
  fa fa_31_22 (
    .a(partial_products[8][23]),
    .b(inter[31][21]),
    .c_in(carry[30][22]),
    .sum(inter[31][22]),
    .c_out(carry[31][22])
  );
  fa fa_31_23 (
    .a(partial_products[7][24]),
    .b(inter[31][22]),
    .c_in(carry[30][23]),
    .sum(inter[31][23]),
    .c_out(carry[31][23])
  );
  fa fa_31_24 (
    .a(partial_products[6][25]),
    .b(inter[31][23]),
    .c_in(carry[30][24]),
    .sum(inter[31][24]),
    .c_out(carry[31][24])
  );
  fa fa_31_25 (
    .a(partial_products[5][26]),
    .b(inter[31][24]),
    .c_in(carry[30][25]),
    .sum(inter[31][25]),
    .c_out(carry[31][25])
  );
  fa fa_31_26 (
    .a(partial_products[4][27]),
    .b(inter[31][25]),
    .c_in(carry[30][26]),
    .sum(inter[31][26]),
    .c_out(carry[31][26])
  );
  fa fa_31_27 (
    .a(partial_products[3][28]),
    .b(inter[31][26]),
    .c_in(carry[30][27]),
    .sum(inter[31][27]),
    .c_out(carry[31][27])
  );
  fa fa_31_28 (
    .a(partial_products[2][29]),
    .b(inter[31][27]),
    .c_in(carry[30][28]),
    .sum(inter[31][28]),
    .c_out(carry[31][28])
  );
  fa fa_31_29 (
    .a(partial_products[1][30]),
    .b(inter[31][28]),
    .c_in(carry[30][29]),
    .sum(inter[31][29]),
    .c_out(carry[31][29])
  );
  ha ha_31_30 (
    .a(partial_products[0][31]),
    .b(inter[31][29]),
    .sum(product[31]),
    .c_out(carry[31][30])
  );

  ha ha_32_0 (
    .a(partial_products[1][31]),
    .b(carry[31][0]),
    .sum(inter[32][0]),
    .c_out(carry[32][0])
  );
  fa fa_32_1 (
    .a(partial_products[2][30]),
    .b(inter[32][0]),
    .c_in(carry[31][1]),
    .sum(inter[32][1]),
    .c_out(carry[32][1])
  );
  fa fa_32_2 (
    .a(partial_products[3][29]),
    .b(inter[32][1]),
    .c_in(carry[31][2]),
    .sum(inter[32][2]),
    .c_out(carry[32][2])
  );
  fa fa_32_3 (
    .a(partial_products[4][28]),
    .b(inter[32][2]),
    .c_in(carry[31][3]),
    .sum(inter[32][3]),
    .c_out(carry[32][3])
  );
  fa fa_32_4 (
    .a(partial_products[5][27]),
    .b(inter[32][3]),
    .c_in(carry[31][4]),
    .sum(inter[32][4]),
    .c_out(carry[32][4])
  );
  fa fa_32_5 (
    .a(partial_products[6][26]),
    .b(inter[32][4]),
    .c_in(carry[31][5]),
    .sum(inter[32][5]),
    .c_out(carry[32][5])
  );
  fa fa_32_6 (
    .a(partial_products[7][25]),
    .b(inter[32][5]),
    .c_in(carry[31][6]),
    .sum(inter[32][6]),
    .c_out(carry[32][6])
  );
  fa fa_32_7 (
    .a(partial_products[8][24]),
    .b(inter[32][6]),
    .c_in(carry[31][7]),
    .sum(inter[32][7]),
    .c_out(carry[32][7])
  );
  fa fa_32_8 (
    .a(partial_products[9][23]),
    .b(inter[32][7]),
    .c_in(carry[31][8]),
    .sum(inter[32][8]),
    .c_out(carry[32][8])
  );
  fa fa_32_9 (
    .a(partial_products[10][22]),
    .b(inter[32][8]),
    .c_in(carry[31][9]),
    .sum(inter[32][9]),
    .c_out(carry[32][9])
  );
  fa fa_32_10 (
    .a(partial_products[11][21]),
    .b(inter[32][9]),
    .c_in(carry[31][10]),
    .sum(inter[32][10]),
    .c_out(carry[32][10])
  );
  fa fa_32_11 (
    .a(partial_products[12][20]),
    .b(inter[32][10]),
    .c_in(carry[31][11]),
    .sum(inter[32][11]),
    .c_out(carry[32][11])
  );
  fa fa_32_12 (
    .a(partial_products[13][19]),
    .b(inter[32][11]),
    .c_in(carry[31][12]),
    .sum(inter[32][12]),
    .c_out(carry[32][12])
  );
  fa fa_32_13 (
    .a(partial_products[14][18]),
    .b(inter[32][12]),
    .c_in(carry[31][13]),
    .sum(inter[32][13]),
    .c_out(carry[32][13])
  );
  fa fa_32_14 (
    .a(partial_products[15][17]),
    .b(inter[32][13]),
    .c_in(carry[31][14]),
    .sum(inter[32][14]),
    .c_out(carry[32][14])
  );
  fa fa_32_15 (
    .a(partial_products[16][16]),
    .b(inter[32][14]),
    .c_in(carry[31][15]),
    .sum(inter[32][15]),
    .c_out(carry[32][15])
  );
  fa fa_32_16 (
    .a(partial_products[17][15]),
    .b(inter[32][15]),
    .c_in(carry[31][16]),
    .sum(inter[32][16]),
    .c_out(carry[32][16])
  );
  fa fa_32_17 (
    .a(partial_products[18][14]),
    .b(inter[32][16]),
    .c_in(carry[31][17]),
    .sum(inter[32][17]),
    .c_out(carry[32][17])
  );
  fa fa_32_18 (
    .a(partial_products[19][13]),
    .b(inter[32][17]),
    .c_in(carry[31][18]),
    .sum(inter[32][18]),
    .c_out(carry[32][18])
  );
  fa fa_32_19 (
    .a(partial_products[20][12]),
    .b(inter[32][18]),
    .c_in(carry[31][19]),
    .sum(inter[32][19]),
    .c_out(carry[32][19])
  );
  fa fa_32_20 (
    .a(partial_products[21][11]),
    .b(inter[32][19]),
    .c_in(carry[31][20]),
    .sum(inter[32][20]),
    .c_out(carry[32][20])
  );
  fa fa_32_21 (
    .a(partial_products[22][10]),
    .b(inter[32][20]),
    .c_in(carry[31][21]),
    .sum(inter[32][21]),
    .c_out(carry[32][21])
  );
  fa fa_32_22 (
    .a(partial_products[23][9]),
    .b(inter[32][21]),
    .c_in(carry[31][22]),
    .sum(inter[32][22]),
    .c_out(carry[32][22])
  );
  fa fa_32_23 (
    .a(partial_products[24][8]),
    .b(inter[32][22]),
    .c_in(carry[31][23]),
    .sum(inter[32][23]),
    .c_out(carry[32][23])
  );
  fa fa_32_24 (
    .a(partial_products[25][7]),
    .b(inter[32][23]),
    .c_in(carry[31][24]),
    .sum(inter[32][24]),
    .c_out(carry[32][24])
  );
  fa fa_32_25 (
    .a(partial_products[26][6]),
    .b(inter[32][24]),
    .c_in(carry[31][25]),
    .sum(inter[32][25]),
    .c_out(carry[32][25])
  );
  fa fa_32_26 (
    .a(partial_products[27][5]),
    .b(inter[32][25]),
    .c_in(carry[31][26]),
    .sum(inter[32][26]),
    .c_out(carry[32][26])
  );
  fa fa_32_27 (
    .a(partial_products[28][4]),
    .b(inter[32][26]),
    .c_in(carry[31][27]),
    .sum(inter[32][27]),
    .c_out(carry[32][27])
  );
  fa fa_32_28 (
    .a(partial_products[29][3]),
    .b(inter[32][27]),
    .c_in(carry[31][28]),
    .sum(inter[32][28]),
    .c_out(carry[32][28])
  );
  fa fa_32_29 (
    .a(partial_products[30][2]),
    .b(inter[32][28]),
    .c_in(carry[31][29]),
    .sum(inter[32][29]),
    .c_out(carry[32][29])
  );
  fa fa_32_30 (
    .a(partial_products[31][1]),
    .b(inter[32][29]),
    .c_in(carry[31][30]),
    .sum(product[32]),
    .c_out(carry[32][30])
  );

  fa fa_33_0 (
    .a(carry[32][0]),
    .b(partial_products[2][31]),
    .c_in(carry[32][1]),
    .sum(inter[33][0]),
    .c_out(carry[33][0])
  );
  fa fa_33_1 (
    .a(inter[33][0]),
    .b(partial_products[3][30]),
    .c_in(carry[32][2]),
    .sum(inter[33][1]),
    .c_out(carry[33][1])
  );
  fa fa_33_2 (
    .a(inter[33][1]),
    .b(partial_products[4][29]),
    .c_in(carry[32][3]),
    .sum(inter[33][2]),
    .c_out(carry[33][2])
  );
  fa fa_33_3 (
    .a(inter[33][2]),
    .b(partial_products[5][28]),
    .c_in(carry[32][4]),
    .sum(inter[33][3]),
    .c_out(carry[33][3])
  );
  fa fa_33_4 (
    .a(inter[33][3]),
    .b(partial_products[6][27]),
    .c_in(carry[32][5]),
    .sum(inter[33][4]),
    .c_out(carry[33][4])
  );
  fa fa_33_5 (
    .a(inter[33][4]),
    .b(partial_products[7][26]),
    .c_in(carry[32][6]),
    .sum(inter[33][5]),
    .c_out(carry[33][5])
  );
  fa fa_33_6 (
    .a(inter[33][5]),
    .b(partial_products[8][25]),
    .c_in(carry[32][7]),
    .sum(inter[33][6]),
    .c_out(carry[33][6])
  );
  fa fa_33_7 (
    .a(inter[33][6]),
    .b(partial_products[9][24]),
    .c_in(carry[32][8]),
    .sum(inter[33][7]),
    .c_out(carry[33][7])
  );
  fa fa_33_8 (
    .a(inter[33][7]),
    .b(partial_products[10][23]),
    .c_in(carry[32][9]),
    .sum(inter[33][8]),
    .c_out(carry[33][8])
  );
  fa fa_33_9 (
    .a(inter[33][8]),
    .b(partial_products[11][22]),
    .c_in(carry[32][10]),
    .sum(inter[33][9]),
    .c_out(carry[33][9])
  );
  fa fa_33_10 (
    .a(inter[33][9]),
    .b(partial_products[12][21]),
    .c_in(carry[32][11]),
    .sum(inter[33][10]),
    .c_out(carry[33][10])
  );
  fa fa_33_11 (
    .a(inter[33][10]),
    .b(partial_products[13][20]),
    .c_in(carry[32][12]),
    .sum(inter[33][11]),
    .c_out(carry[33][11])
  );
  fa fa_33_12 (
    .a(inter[33][11]),
    .b(partial_products[14][19]),
    .c_in(carry[32][13]),
    .sum(inter[33][12]),
    .c_out(carry[33][12])
  );
  fa fa_33_13 (
    .a(inter[33][12]),
    .b(partial_products[15][18]),
    .c_in(carry[32][14]),
    .sum(inter[33][13]),
    .c_out(carry[33][13])
  );
  fa fa_33_14 (
    .a(inter[33][13]),
    .b(partial_products[16][17]),
    .c_in(carry[32][15]),
    .sum(inter[33][14]),
    .c_out(carry[33][14])
  );
  fa fa_33_15 (
    .a(inter[33][14]),
    .b(partial_products[17][16]),
    .c_in(carry[32][16]),
    .sum(inter[33][15]),
    .c_out(carry[33][15])
  );
  fa fa_33_16 (
    .a(inter[33][15]),
    .b(partial_products[18][15]),
    .c_in(carry[32][17]),
    .sum(inter[33][16]),
    .c_out(carry[33][16])
  );
  fa fa_33_17 (
    .a(inter[33][16]),
    .b(partial_products[19][14]),
    .c_in(carry[32][18]),
    .sum(inter[33][17]),
    .c_out(carry[33][17])
  );
  fa fa_33_18 (
    .a(inter[33][17]),
    .b(partial_products[20][13]),
    .c_in(carry[32][19]),
    .sum(inter[33][18]),
    .c_out(carry[33][18])
  );
  fa fa_33_19 (
    .a(inter[33][18]),
    .b(partial_products[21][12]),
    .c_in(carry[32][20]),
    .sum(inter[33][19]),
    .c_out(carry[33][19])
  );
  fa fa_33_20 (
    .a(inter[33][19]),
    .b(partial_products[22][11]),
    .c_in(carry[32][21]),
    .sum(inter[33][20]),
    .c_out(carry[33][20])
  );
  fa fa_33_21 (
    .a(inter[33][20]),
    .b(partial_products[23][10]),
    .c_in(carry[32][22]),
    .sum(inter[33][21]),
    .c_out(carry[33][21])
  );
  fa fa_33_22 (
    .a(inter[33][21]),
    .b(partial_products[24][9]),
    .c_in(carry[32][23]),
    .sum(inter[33][22]),
    .c_out(carry[33][22])
  );
  fa fa_33_23 (
    .a(inter[33][22]),
    .b(partial_products[25][8]),
    .c_in(carry[32][24]),
    .sum(inter[33][23]),
    .c_out(carry[33][23])
  );
  fa fa_33_24 (
    .a(inter[33][23]),
    .b(partial_products[26][7]),
    .c_in(carry[32][25]),
    .sum(inter[33][24]),
    .c_out(carry[33][24])
  );
  fa fa_33_25 (
    .a(inter[33][24]),
    .b(partial_products[27][6]),
    .c_in(carry[32][26]),
    .sum(inter[33][25]),
    .c_out(carry[33][25])
  );
  fa fa_33_26 (
    .a(inter[33][25]),
    .b(partial_products[28][5]),
    .c_in(carry[32][27]),
    .sum(inter[33][26]),
    .c_out(carry[33][26])
  );
  fa fa_33_27 (
    .a(inter[33][26]),
    .b(partial_products[29][4]),
    .c_in(carry[32][28]),
    .sum(inter[33][27]),
    .c_out(carry[33][27])
  );
  fa fa_33_28 (
    .a(inter[33][27]),
    .b(partial_products[30][3]),
    .c_in(carry[32][29]),
    .sum(inter[33][28]),
    .c_out(carry[33][28])
  );
  fa fa_33_29 (
    .a(inter[33][28]),
    .b(partial_products[31][2]),
    .c_in(carry[32][30]),
    .sum(product[33]),
    .c_out(carry[33][29])
  );

  fa fa_34_0 (
    .a(carry[33][0]),
    .b(partial_products[3][31]),
    .c_in(carry[33][1]),
    .sum(inter[34][0]),
    .c_out(carry[34][0])
  );
  fa fa_34_1 (
    .a(inter[34][0]),
    .b(partial_products[4][30]),
    .c_in(carry[33][2]),
    .sum(inter[34][1]),
    .c_out(carry[34][1])
  );
  fa fa_34_2 (
    .a(inter[34][1]),
    .b(partial_products[5][29]),
    .c_in(carry[33][3]),
    .sum(inter[34][2]),
    .c_out(carry[34][2])
  );
  fa fa_34_3 (
    .a(inter[34][2]),
    .b(partial_products[6][28]),
    .c_in(carry[33][4]),
    .sum(inter[34][3]),
    .c_out(carry[34][3])
  );
  fa fa_34_4 (
    .a(inter[34][3]),
    .b(partial_products[7][27]),
    .c_in(carry[33][5]),
    .sum(inter[34][4]),
    .c_out(carry[34][4])
  );
  fa fa_34_5 (
    .a(inter[34][4]),
    .b(partial_products[8][26]),
    .c_in(carry[33][6]),
    .sum(inter[34][5]),
    .c_out(carry[34][5])
  );
  fa fa_34_6 (
    .a(inter[34][5]),
    .b(partial_products[9][25]),
    .c_in(carry[33][7]),
    .sum(inter[34][6]),
    .c_out(carry[34][6])
  );
  fa fa_34_7 (
    .a(inter[34][6]),
    .b(partial_products[10][24]),
    .c_in(carry[33][8]),
    .sum(inter[34][7]),
    .c_out(carry[34][7])
  );
  fa fa_34_8 (
    .a(inter[34][7]),
    .b(partial_products[11][23]),
    .c_in(carry[33][9]),
    .sum(inter[34][8]),
    .c_out(carry[34][8])
  );
  fa fa_34_9 (
    .a(inter[34][8]),
    .b(partial_products[12][22]),
    .c_in(carry[33][10]),
    .sum(inter[34][9]),
    .c_out(carry[34][9])
  );
  fa fa_34_10 (
    .a(inter[34][9]),
    .b(partial_products[13][21]),
    .c_in(carry[33][11]),
    .sum(inter[34][10]),
    .c_out(carry[34][10])
  );
  fa fa_34_11 (
    .a(inter[34][10]),
    .b(partial_products[14][20]),
    .c_in(carry[33][12]),
    .sum(inter[34][11]),
    .c_out(carry[34][11])
  );
  fa fa_34_12 (
    .a(inter[34][11]),
    .b(partial_products[15][19]),
    .c_in(carry[33][13]),
    .sum(inter[34][12]),
    .c_out(carry[34][12])
  );
  fa fa_34_13 (
    .a(inter[34][12]),
    .b(partial_products[16][18]),
    .c_in(carry[33][14]),
    .sum(inter[34][13]),
    .c_out(carry[34][13])
  );
  fa fa_34_14 (
    .a(inter[34][13]),
    .b(partial_products[17][17]),
    .c_in(carry[33][15]),
    .sum(inter[34][14]),
    .c_out(carry[34][14])
  );
  fa fa_34_15 (
    .a(inter[34][14]),
    .b(partial_products[18][16]),
    .c_in(carry[33][16]),
    .sum(inter[34][15]),
    .c_out(carry[34][15])
  );
  fa fa_34_16 (
    .a(inter[34][15]),
    .b(partial_products[19][15]),
    .c_in(carry[33][17]),
    .sum(inter[34][16]),
    .c_out(carry[34][16])
  );
  fa fa_34_17 (
    .a(inter[34][16]),
    .b(partial_products[20][14]),
    .c_in(carry[33][18]),
    .sum(inter[34][17]),
    .c_out(carry[34][17])
  );
  fa fa_34_18 (
    .a(inter[34][17]),
    .b(partial_products[21][13]),
    .c_in(carry[33][19]),
    .sum(inter[34][18]),
    .c_out(carry[34][18])
  );
  fa fa_34_19 (
    .a(inter[34][18]),
    .b(partial_products[22][12]),
    .c_in(carry[33][20]),
    .sum(inter[34][19]),
    .c_out(carry[34][19])
  );
  fa fa_34_20 (
    .a(inter[34][19]),
    .b(partial_products[23][11]),
    .c_in(carry[33][21]),
    .sum(inter[34][20]),
    .c_out(carry[34][20])
  );
  fa fa_34_21 (
    .a(inter[34][20]),
    .b(partial_products[24][10]),
    .c_in(carry[33][22]),
    .sum(inter[34][21]),
    .c_out(carry[34][21])
  );
  fa fa_34_22 (
    .a(inter[34][21]),
    .b(partial_products[25][9]),
    .c_in(carry[33][23]),
    .sum(inter[34][22]),
    .c_out(carry[34][22])
  );
  fa fa_34_23 (
    .a(inter[34][22]),
    .b(partial_products[26][8]),
    .c_in(carry[33][24]),
    .sum(inter[34][23]),
    .c_out(carry[34][23])
  );
  fa fa_34_24 (
    .a(inter[34][23]),
    .b(partial_products[27][7]),
    .c_in(carry[33][25]),
    .sum(inter[34][24]),
    .c_out(carry[34][24])
  );
  fa fa_34_25 (
    .a(inter[34][24]),
    .b(partial_products[28][6]),
    .c_in(carry[33][26]),
    .sum(inter[34][25]),
    .c_out(carry[34][25])
  );
  fa fa_34_26 (
    .a(inter[34][25]),
    .b(partial_products[29][5]),
    .c_in(carry[33][27]),
    .sum(inter[34][26]),
    .c_out(carry[34][26])
  );
  fa fa_34_27 (
    .a(inter[34][26]),
    .b(partial_products[30][4]),
    .c_in(carry[33][28]),
    .sum(inter[34][27]),
    .c_out(carry[34][27])
  );
  fa fa_34_28 (
    .a(inter[34][27]),
    .b(partial_products[31][3]),
    .c_in(carry[33][29]),
    .sum(product[34]),
    .c_out(carry[34][28])
  );

  fa fa_35_0 (
    .a(carry[34][0]),
    .b(partial_products[4][31]),
    .c_in(carry[34][1]),
    .sum(inter[35][0]),
    .c_out(carry[35][0])
  );
  fa fa_35_1 (
    .a(inter[35][0]),
    .b(partial_products[5][30]),
    .c_in(carry[34][2]),
    .sum(inter[35][1]),
    .c_out(carry[35][1])
  );
  fa fa_35_2 (
    .a(inter[35][1]),
    .b(partial_products[6][29]),
    .c_in(carry[34][3]),
    .sum(inter[35][2]),
    .c_out(carry[35][2])
  );
  fa fa_35_3 (
    .a(inter[35][2]),
    .b(partial_products[7][28]),
    .c_in(carry[34][4]),
    .sum(inter[35][3]),
    .c_out(carry[35][3])
  );
  fa fa_35_4 (
    .a(inter[35][3]),
    .b(partial_products[8][27]),
    .c_in(carry[34][5]),
    .sum(inter[35][4]),
    .c_out(carry[35][4])
  );
  fa fa_35_5 (
    .a(inter[35][4]),
    .b(partial_products[9][26]),
    .c_in(carry[34][6]),
    .sum(inter[35][5]),
    .c_out(carry[35][5])
  );
  fa fa_35_6 (
    .a(inter[35][5]),
    .b(partial_products[10][25]),
    .c_in(carry[34][7]),
    .sum(inter[35][6]),
    .c_out(carry[35][6])
  );
  fa fa_35_7 (
    .a(inter[35][6]),
    .b(partial_products[11][24]),
    .c_in(carry[34][8]),
    .sum(inter[35][7]),
    .c_out(carry[35][7])
  );
  fa fa_35_8 (
    .a(inter[35][7]),
    .b(partial_products[12][23]),
    .c_in(carry[34][9]),
    .sum(inter[35][8]),
    .c_out(carry[35][8])
  );
  fa fa_35_9 (
    .a(inter[35][8]),
    .b(partial_products[13][22]),
    .c_in(carry[34][10]),
    .sum(inter[35][9]),
    .c_out(carry[35][9])
  );
  fa fa_35_10 (
    .a(inter[35][9]),
    .b(partial_products[14][21]),
    .c_in(carry[34][11]),
    .sum(inter[35][10]),
    .c_out(carry[35][10])
  );
  fa fa_35_11 (
    .a(inter[35][10]),
    .b(partial_products[15][20]),
    .c_in(carry[34][12]),
    .sum(inter[35][11]),
    .c_out(carry[35][11])
  );
  fa fa_35_12 (
    .a(inter[35][11]),
    .b(partial_products[16][19]),
    .c_in(carry[34][13]),
    .sum(inter[35][12]),
    .c_out(carry[35][12])
  );
  fa fa_35_13 (
    .a(inter[35][12]),
    .b(partial_products[17][18]),
    .c_in(carry[34][14]),
    .sum(inter[35][13]),
    .c_out(carry[35][13])
  );
  fa fa_35_14 (
    .a(inter[35][13]),
    .b(partial_products[18][17]),
    .c_in(carry[34][15]),
    .sum(inter[35][14]),
    .c_out(carry[35][14])
  );
  fa fa_35_15 (
    .a(inter[35][14]),
    .b(partial_products[19][16]),
    .c_in(carry[34][16]),
    .sum(inter[35][15]),
    .c_out(carry[35][15])
  );
  fa fa_35_16 (
    .a(inter[35][15]),
    .b(partial_products[20][15]),
    .c_in(carry[34][17]),
    .sum(inter[35][16]),
    .c_out(carry[35][16])
  );
  fa fa_35_17 (
    .a(inter[35][16]),
    .b(partial_products[21][14]),
    .c_in(carry[34][18]),
    .sum(inter[35][17]),
    .c_out(carry[35][17])
  );
  fa fa_35_18 (
    .a(inter[35][17]),
    .b(partial_products[22][13]),
    .c_in(carry[34][19]),
    .sum(inter[35][18]),
    .c_out(carry[35][18])
  );
  fa fa_35_19 (
    .a(inter[35][18]),
    .b(partial_products[23][12]),
    .c_in(carry[34][20]),
    .sum(inter[35][19]),
    .c_out(carry[35][19])
  );
  fa fa_35_20 (
    .a(inter[35][19]),
    .b(partial_products[24][11]),
    .c_in(carry[34][21]),
    .sum(inter[35][20]),
    .c_out(carry[35][20])
  );
  fa fa_35_21 (
    .a(inter[35][20]),
    .b(partial_products[25][10]),
    .c_in(carry[34][22]),
    .sum(inter[35][21]),
    .c_out(carry[35][21])
  );
  fa fa_35_22 (
    .a(inter[35][21]),
    .b(partial_products[26][9]),
    .c_in(carry[34][23]),
    .sum(inter[35][22]),
    .c_out(carry[35][22])
  );
  fa fa_35_23 (
    .a(inter[35][22]),
    .b(partial_products[27][8]),
    .c_in(carry[34][24]),
    .sum(inter[35][23]),
    .c_out(carry[35][23])
  );
  fa fa_35_24 (
    .a(inter[35][23]),
    .b(partial_products[28][7]),
    .c_in(carry[34][25]),
    .sum(inter[35][24]),
    .c_out(carry[35][24])
  );
  fa fa_35_25 (
    .a(inter[35][24]),
    .b(partial_products[29][6]),
    .c_in(carry[34][26]),
    .sum(inter[35][25]),
    .c_out(carry[35][25])
  );
  fa fa_35_26 (
    .a(inter[35][25]),
    .b(partial_products[30][5]),
    .c_in(carry[34][27]),
    .sum(inter[35][26]),
    .c_out(carry[35][26])
  );
  fa fa_35_27 (
    .a(inter[35][26]),
    .b(partial_products[31][4]),
    .c_in(carry[34][28]),
    .sum(product[35]),
    .c_out(carry[35][27])
  );

  fa fa_36_0 (
    .a(carry[35][0]),
    .b(partial_products[5][31]),
    .c_in(carry[35][1]),
    .sum(inter[36][0]),
    .c_out(carry[36][0])
  );
  fa fa_36_1 (
    .a(inter[36][0]),
    .b(partial_products[6][30]),
    .c_in(carry[35][2]),
    .sum(inter[36][1]),
    .c_out(carry[36][1])
  );
  fa fa_36_2 (
    .a(inter[36][1]),
    .b(partial_products[7][29]),
    .c_in(carry[35][3]),
    .sum(inter[36][2]),
    .c_out(carry[36][2])
  );
  fa fa_36_3 (
    .a(inter[36][2]),
    .b(partial_products[8][28]),
    .c_in(carry[35][4]),
    .sum(inter[36][3]),
    .c_out(carry[36][3])
  );
  fa fa_36_4 (
    .a(inter[36][3]),
    .b(partial_products[9][27]),
    .c_in(carry[35][5]),
    .sum(inter[36][4]),
    .c_out(carry[36][4])
  );
  fa fa_36_5 (
    .a(inter[36][4]),
    .b(partial_products[10][26]),
    .c_in(carry[35][6]),
    .sum(inter[36][5]),
    .c_out(carry[36][5])
  );
  fa fa_36_6 (
    .a(inter[36][5]),
    .b(partial_products[11][25]),
    .c_in(carry[35][7]),
    .sum(inter[36][6]),
    .c_out(carry[36][6])
  );
  fa fa_36_7 (
    .a(inter[36][6]),
    .b(partial_products[12][24]),
    .c_in(carry[35][8]),
    .sum(inter[36][7]),
    .c_out(carry[36][7])
  );
  fa fa_36_8 (
    .a(inter[36][7]),
    .b(partial_products[13][23]),
    .c_in(carry[35][9]),
    .sum(inter[36][8]),
    .c_out(carry[36][8])
  );
  fa fa_36_9 (
    .a(inter[36][8]),
    .b(partial_products[14][22]),
    .c_in(carry[35][10]),
    .sum(inter[36][9]),
    .c_out(carry[36][9])
  );
  fa fa_36_10 (
    .a(inter[36][9]),
    .b(partial_products[15][21]),
    .c_in(carry[35][11]),
    .sum(inter[36][10]),
    .c_out(carry[36][10])
  );
  fa fa_36_11 (
    .a(inter[36][10]),
    .b(partial_products[16][20]),
    .c_in(carry[35][12]),
    .sum(inter[36][11]),
    .c_out(carry[36][11])
  );
  fa fa_36_12 (
    .a(inter[36][11]),
    .b(partial_products[17][19]),
    .c_in(carry[35][13]),
    .sum(inter[36][12]),
    .c_out(carry[36][12])
  );
  fa fa_36_13 (
    .a(inter[36][12]),
    .b(partial_products[18][18]),
    .c_in(carry[35][14]),
    .sum(inter[36][13]),
    .c_out(carry[36][13])
  );
  fa fa_36_14 (
    .a(inter[36][13]),
    .b(partial_products[19][17]),
    .c_in(carry[35][15]),
    .sum(inter[36][14]),
    .c_out(carry[36][14])
  );
  fa fa_36_15 (
    .a(inter[36][14]),
    .b(partial_products[20][16]),
    .c_in(carry[35][16]),
    .sum(inter[36][15]),
    .c_out(carry[36][15])
  );
  fa fa_36_16 (
    .a(inter[36][15]),
    .b(partial_products[21][15]),
    .c_in(carry[35][17]),
    .sum(inter[36][16]),
    .c_out(carry[36][16])
  );
  fa fa_36_17 (
    .a(inter[36][16]),
    .b(partial_products[22][14]),
    .c_in(carry[35][18]),
    .sum(inter[36][17]),
    .c_out(carry[36][17])
  );
  fa fa_36_18 (
    .a(inter[36][17]),
    .b(partial_products[23][13]),
    .c_in(carry[35][19]),
    .sum(inter[36][18]),
    .c_out(carry[36][18])
  );
  fa fa_36_19 (
    .a(inter[36][18]),
    .b(partial_products[24][12]),
    .c_in(carry[35][20]),
    .sum(inter[36][19]),
    .c_out(carry[36][19])
  );
  fa fa_36_20 (
    .a(inter[36][19]),
    .b(partial_products[25][11]),
    .c_in(carry[35][21]),
    .sum(inter[36][20]),
    .c_out(carry[36][20])
  );
  fa fa_36_21 (
    .a(inter[36][20]),
    .b(partial_products[26][10]),
    .c_in(carry[35][22]),
    .sum(inter[36][21]),
    .c_out(carry[36][21])
  );
  fa fa_36_22 (
    .a(inter[36][21]),
    .b(partial_products[27][9]),
    .c_in(carry[35][23]),
    .sum(inter[36][22]),
    .c_out(carry[36][22])
  );
  fa fa_36_23 (
    .a(inter[36][22]),
    .b(partial_products[28][8]),
    .c_in(carry[35][24]),
    .sum(inter[36][23]),
    .c_out(carry[36][23])
  );
  fa fa_36_24 (
    .a(inter[36][23]),
    .b(partial_products[29][7]),
    .c_in(carry[35][25]),
    .sum(inter[36][24]),
    .c_out(carry[36][24])
  );
  fa fa_36_25 (
    .a(inter[36][24]),
    .b(partial_products[30][6]),
    .c_in(carry[35][26]),
    .sum(inter[36][25]),
    .c_out(carry[36][25])
  );
  fa fa_36_26 (
    .a(inter[36][25]),
    .b(partial_products[31][5]),
    .c_in(carry[35][27]),
    .sum(product[36]),
    .c_out(carry[36][26])
  );

  fa fa_37_0 (
    .a(carry[36][0]),
    .b(partial_products[6][31]),
    .c_in(carry[36][1]),
    .sum(inter[37][0]),
    .c_out(carry[37][0])
  );
  fa fa_37_1 (
    .a(inter[37][0]),
    .b(partial_products[7][30]),
    .c_in(carry[36][2]),
    .sum(inter[37][1]),
    .c_out(carry[37][1])
  );
  fa fa_37_2 (
    .a(inter[37][1]),
    .b(partial_products[8][29]),
    .c_in(carry[36][3]),
    .sum(inter[37][2]),
    .c_out(carry[37][2])
  );
  fa fa_37_3 (
    .a(inter[37][2]),
    .b(partial_products[9][28]),
    .c_in(carry[36][4]),
    .sum(inter[37][3]),
    .c_out(carry[37][3])
  );
  fa fa_37_4 (
    .a(inter[37][3]),
    .b(partial_products[10][27]),
    .c_in(carry[36][5]),
    .sum(inter[37][4]),
    .c_out(carry[37][4])
  );
  fa fa_37_5 (
    .a(inter[37][4]),
    .b(partial_products[11][26]),
    .c_in(carry[36][6]),
    .sum(inter[37][5]),
    .c_out(carry[37][5])
  );
  fa fa_37_6 (
    .a(inter[37][5]),
    .b(partial_products[12][25]),
    .c_in(carry[36][7]),
    .sum(inter[37][6]),
    .c_out(carry[37][6])
  );
  fa fa_37_7 (
    .a(inter[37][6]),
    .b(partial_products[13][24]),
    .c_in(carry[36][8]),
    .sum(inter[37][7]),
    .c_out(carry[37][7])
  );
  fa fa_37_8 (
    .a(inter[37][7]),
    .b(partial_products[14][23]),
    .c_in(carry[36][9]),
    .sum(inter[37][8]),
    .c_out(carry[37][8])
  );
  fa fa_37_9 (
    .a(inter[37][8]),
    .b(partial_products[15][22]),
    .c_in(carry[36][10]),
    .sum(inter[37][9]),
    .c_out(carry[37][9])
  );
  fa fa_37_10 (
    .a(inter[37][9]),
    .b(partial_products[16][21]),
    .c_in(carry[36][11]),
    .sum(inter[37][10]),
    .c_out(carry[37][10])
  );
  fa fa_37_11 (
    .a(inter[37][10]),
    .b(partial_products[17][20]),
    .c_in(carry[36][12]),
    .sum(inter[37][11]),
    .c_out(carry[37][11])
  );
  fa fa_37_12 (
    .a(inter[37][11]),
    .b(partial_products[18][19]),
    .c_in(carry[36][13]),
    .sum(inter[37][12]),
    .c_out(carry[37][12])
  );
  fa fa_37_13 (
    .a(inter[37][12]),
    .b(partial_products[19][18]),
    .c_in(carry[36][14]),
    .sum(inter[37][13]),
    .c_out(carry[37][13])
  );
  fa fa_37_14 (
    .a(inter[37][13]),
    .b(partial_products[20][17]),
    .c_in(carry[36][15]),
    .sum(inter[37][14]),
    .c_out(carry[37][14])
  );
  fa fa_37_15 (
    .a(inter[37][14]),
    .b(partial_products[21][16]),
    .c_in(carry[36][16]),
    .sum(inter[37][15]),
    .c_out(carry[37][15])
  );
  fa fa_37_16 (
    .a(inter[37][15]),
    .b(partial_products[22][15]),
    .c_in(carry[36][17]),
    .sum(inter[37][16]),
    .c_out(carry[37][16])
  );
  fa fa_37_17 (
    .a(inter[37][16]),
    .b(partial_products[23][14]),
    .c_in(carry[36][18]),
    .sum(inter[37][17]),
    .c_out(carry[37][17])
  );
  fa fa_37_18 (
    .a(inter[37][17]),
    .b(partial_products[24][13]),
    .c_in(carry[36][19]),
    .sum(inter[37][18]),
    .c_out(carry[37][18])
  );
  fa fa_37_19 (
    .a(inter[37][18]),
    .b(partial_products[25][12]),
    .c_in(carry[36][20]),
    .sum(inter[37][19]),
    .c_out(carry[37][19])
  );
  fa fa_37_20 (
    .a(inter[37][19]),
    .b(partial_products[26][11]),
    .c_in(carry[36][21]),
    .sum(inter[37][20]),
    .c_out(carry[37][20])
  );
  fa fa_37_21 (
    .a(inter[37][20]),
    .b(partial_products[27][10]),
    .c_in(carry[36][22]),
    .sum(inter[37][21]),
    .c_out(carry[37][21])
  );
  fa fa_37_22 (
    .a(inter[37][21]),
    .b(partial_products[28][9]),
    .c_in(carry[36][23]),
    .sum(inter[37][22]),
    .c_out(carry[37][22])
  );
  fa fa_37_23 (
    .a(inter[37][22]),
    .b(partial_products[29][8]),
    .c_in(carry[36][24]),
    .sum(inter[37][23]),
    .c_out(carry[37][23])
  );
  fa fa_37_24 (
    .a(inter[37][23]),
    .b(partial_products[30][7]),
    .c_in(carry[36][25]),
    .sum(inter[37][24]),
    .c_out(carry[37][24])
  );
  fa fa_37_25 (
    .a(inter[37][24]),
    .b(partial_products[31][6]),
    .c_in(carry[36][26]),
    .sum(product[37]),
    .c_out(carry[37][25])
  );

  fa fa_38_0 (
    .a(carry[37][0]),
    .b(partial_products[7][31]),
    .c_in(carry[37][1]),
    .sum(inter[38][0]),
    .c_out(carry[38][0])
  );
  fa fa_38_1 (
    .a(inter[38][0]),
    .b(partial_products[8][30]),
    .c_in(carry[37][2]),
    .sum(inter[38][1]),
    .c_out(carry[38][1])
  );
  fa fa_38_2 (
    .a(inter[38][1]),
    .b(partial_products[9][29]),
    .c_in(carry[37][3]),
    .sum(inter[38][2]),
    .c_out(carry[38][2])
  );
  fa fa_38_3 (
    .a(inter[38][2]),
    .b(partial_products[10][28]),
    .c_in(carry[37][4]),
    .sum(inter[38][3]),
    .c_out(carry[38][3])
  );
  fa fa_38_4 (
    .a(inter[38][3]),
    .b(partial_products[11][27]),
    .c_in(carry[37][5]),
    .sum(inter[38][4]),
    .c_out(carry[38][4])
  );
  fa fa_38_5 (
    .a(inter[38][4]),
    .b(partial_products[12][26]),
    .c_in(carry[37][6]),
    .sum(inter[38][5]),
    .c_out(carry[38][5])
  );
  fa fa_38_6 (
    .a(inter[38][5]),
    .b(partial_products[13][25]),
    .c_in(carry[37][7]),
    .sum(inter[38][6]),
    .c_out(carry[38][6])
  );
  fa fa_38_7 (
    .a(inter[38][6]),
    .b(partial_products[14][24]),
    .c_in(carry[37][8]),
    .sum(inter[38][7]),
    .c_out(carry[38][7])
  );
  fa fa_38_8 (
    .a(inter[38][7]),
    .b(partial_products[15][23]),
    .c_in(carry[37][9]),
    .sum(inter[38][8]),
    .c_out(carry[38][8])
  );
  fa fa_38_9 (
    .a(inter[38][8]),
    .b(partial_products[16][22]),
    .c_in(carry[37][10]),
    .sum(inter[38][9]),
    .c_out(carry[38][9])
  );
  fa fa_38_10 (
    .a(inter[38][9]),
    .b(partial_products[17][21]),
    .c_in(carry[37][11]),
    .sum(inter[38][10]),
    .c_out(carry[38][10])
  );
  fa fa_38_11 (
    .a(inter[38][10]),
    .b(partial_products[18][20]),
    .c_in(carry[37][12]),
    .sum(inter[38][11]),
    .c_out(carry[38][11])
  );
  fa fa_38_12 (
    .a(inter[38][11]),
    .b(partial_products[19][19]),
    .c_in(carry[37][13]),
    .sum(inter[38][12]),
    .c_out(carry[38][12])
  );
  fa fa_38_13 (
    .a(inter[38][12]),
    .b(partial_products[20][18]),
    .c_in(carry[37][14]),
    .sum(inter[38][13]),
    .c_out(carry[38][13])
  );
  fa fa_38_14 (
    .a(inter[38][13]),
    .b(partial_products[21][17]),
    .c_in(carry[37][15]),
    .sum(inter[38][14]),
    .c_out(carry[38][14])
  );
  fa fa_38_15 (
    .a(inter[38][14]),
    .b(partial_products[22][16]),
    .c_in(carry[37][16]),
    .sum(inter[38][15]),
    .c_out(carry[38][15])
  );
  fa fa_38_16 (
    .a(inter[38][15]),
    .b(partial_products[23][15]),
    .c_in(carry[37][17]),
    .sum(inter[38][16]),
    .c_out(carry[38][16])
  );
  fa fa_38_17 (
    .a(inter[38][16]),
    .b(partial_products[24][14]),
    .c_in(carry[37][18]),
    .sum(inter[38][17]),
    .c_out(carry[38][17])
  );
  fa fa_38_18 (
    .a(inter[38][17]),
    .b(partial_products[25][13]),
    .c_in(carry[37][19]),
    .sum(inter[38][18]),
    .c_out(carry[38][18])
  );
  fa fa_38_19 (
    .a(inter[38][18]),
    .b(partial_products[26][12]),
    .c_in(carry[37][20]),
    .sum(inter[38][19]),
    .c_out(carry[38][19])
  );
  fa fa_38_20 (
    .a(inter[38][19]),
    .b(partial_products[27][11]),
    .c_in(carry[37][21]),
    .sum(inter[38][20]),
    .c_out(carry[38][20])
  );
  fa fa_38_21 (
    .a(inter[38][20]),
    .b(partial_products[28][10]),
    .c_in(carry[37][22]),
    .sum(inter[38][21]),
    .c_out(carry[38][21])
  );
  fa fa_38_22 (
    .a(inter[38][21]),
    .b(partial_products[29][9]),
    .c_in(carry[37][23]),
    .sum(inter[38][22]),
    .c_out(carry[38][22])
  );
  fa fa_38_23 (
    .a(inter[38][22]),
    .b(partial_products[30][8]),
    .c_in(carry[37][24]),
    .sum(inter[38][23]),
    .c_out(carry[38][23])
  );
  fa fa_38_24 (
    .a(inter[38][23]),
    .b(partial_products[31][7]),
    .c_in(carry[37][25]),
    .sum(product[38]),
    .c_out(carry[38][24])
  );

  fa fa_39_0 (
    .a(carry[38][0]),
    .b(partial_products[8][31]),
    .c_in(carry[38][1]),
    .sum(inter[39][0]),
    .c_out(carry[39][0])
  );
  fa fa_39_1 (
    .a(inter[39][0]),
    .b(partial_products[9][30]),
    .c_in(carry[38][2]),
    .sum(inter[39][1]),
    .c_out(carry[39][1])
  );
  fa fa_39_2 (
    .a(inter[39][1]),
    .b(partial_products[10][29]),
    .c_in(carry[38][3]),
    .sum(inter[39][2]),
    .c_out(carry[39][2])
  );
  fa fa_39_3 (
    .a(inter[39][2]),
    .b(partial_products[11][28]),
    .c_in(carry[38][4]),
    .sum(inter[39][3]),
    .c_out(carry[39][3])
  );
  fa fa_39_4 (
    .a(inter[39][3]),
    .b(partial_products[12][27]),
    .c_in(carry[38][5]),
    .sum(inter[39][4]),
    .c_out(carry[39][4])
  );
  fa fa_39_5 (
    .a(inter[39][4]),
    .b(partial_products[13][26]),
    .c_in(carry[38][6]),
    .sum(inter[39][5]),
    .c_out(carry[39][5])
  );
  fa fa_39_6 (
    .a(inter[39][5]),
    .b(partial_products[14][25]),
    .c_in(carry[38][7]),
    .sum(inter[39][6]),
    .c_out(carry[39][6])
  );
  fa fa_39_7 (
    .a(inter[39][6]),
    .b(partial_products[15][24]),
    .c_in(carry[38][8]),
    .sum(inter[39][7]),
    .c_out(carry[39][7])
  );
  fa fa_39_8 (
    .a(inter[39][7]),
    .b(partial_products[16][23]),
    .c_in(carry[38][9]),
    .sum(inter[39][8]),
    .c_out(carry[39][8])
  );
  fa fa_39_9 (
    .a(inter[39][8]),
    .b(partial_products[17][22]),
    .c_in(carry[38][10]),
    .sum(inter[39][9]),
    .c_out(carry[39][9])
  );
  fa fa_39_10 (
    .a(inter[39][9]),
    .b(partial_products[18][21]),
    .c_in(carry[38][11]),
    .sum(inter[39][10]),
    .c_out(carry[39][10])
  );
  fa fa_39_11 (
    .a(inter[39][10]),
    .b(partial_products[19][20]),
    .c_in(carry[38][12]),
    .sum(inter[39][11]),
    .c_out(carry[39][11])
  );
  fa fa_39_12 (
    .a(inter[39][11]),
    .b(partial_products[20][19]),
    .c_in(carry[38][13]),
    .sum(inter[39][12]),
    .c_out(carry[39][12])
  );
  fa fa_39_13 (
    .a(inter[39][12]),
    .b(partial_products[21][18]),
    .c_in(carry[38][14]),
    .sum(inter[39][13]),
    .c_out(carry[39][13])
  );
  fa fa_39_14 (
    .a(inter[39][13]),
    .b(partial_products[22][17]),
    .c_in(carry[38][15]),
    .sum(inter[39][14]),
    .c_out(carry[39][14])
  );
  fa fa_39_15 (
    .a(inter[39][14]),
    .b(partial_products[23][16]),
    .c_in(carry[38][16]),
    .sum(inter[39][15]),
    .c_out(carry[39][15])
  );
  fa fa_39_16 (
    .a(inter[39][15]),
    .b(partial_products[24][15]),
    .c_in(carry[38][17]),
    .sum(inter[39][16]),
    .c_out(carry[39][16])
  );
  fa fa_39_17 (
    .a(inter[39][16]),
    .b(partial_products[25][14]),
    .c_in(carry[38][18]),
    .sum(inter[39][17]),
    .c_out(carry[39][17])
  );
  fa fa_39_18 (
    .a(inter[39][17]),
    .b(partial_products[26][13]),
    .c_in(carry[38][19]),
    .sum(inter[39][18]),
    .c_out(carry[39][18])
  );
  fa fa_39_19 (
    .a(inter[39][18]),
    .b(partial_products[27][12]),
    .c_in(carry[38][20]),
    .sum(inter[39][19]),
    .c_out(carry[39][19])
  );
  fa fa_39_20 (
    .a(inter[39][19]),
    .b(partial_products[28][11]),
    .c_in(carry[38][21]),
    .sum(inter[39][20]),
    .c_out(carry[39][20])
  );
  fa fa_39_21 (
    .a(inter[39][20]),
    .b(partial_products[29][10]),
    .c_in(carry[38][22]),
    .sum(inter[39][21]),
    .c_out(carry[39][21])
  );
  fa fa_39_22 (
    .a(inter[39][21]),
    .b(partial_products[30][9]),
    .c_in(carry[38][23]),
    .sum(inter[39][22]),
    .c_out(carry[39][22])
  );
  fa fa_39_23 (
    .a(inter[39][22]),
    .b(partial_products[31][8]),
    .c_in(carry[38][24]),
    .sum(product[39]),
    .c_out(carry[39][23])
  );

  fa fa_40_0 (
    .a(carry[39][0]),
    .b(partial_products[9][31]),
    .c_in(carry[39][1]),
    .sum(inter[40][0]),
    .c_out(carry[40][0])
  );
  fa fa_40_1 (
    .a(inter[40][0]),
    .b(partial_products[10][30]),
    .c_in(carry[39][2]),
    .sum(inter[40][1]),
    .c_out(carry[40][1])
  );
  fa fa_40_2 (
    .a(inter[40][1]),
    .b(partial_products[11][29]),
    .c_in(carry[39][3]),
    .sum(inter[40][2]),
    .c_out(carry[40][2])
  );
  fa fa_40_3 (
    .a(inter[40][2]),
    .b(partial_products[12][28]),
    .c_in(carry[39][4]),
    .sum(inter[40][3]),
    .c_out(carry[40][3])
  );
  fa fa_40_4 (
    .a(inter[40][3]),
    .b(partial_products[13][27]),
    .c_in(carry[39][5]),
    .sum(inter[40][4]),
    .c_out(carry[40][4])
  );
  fa fa_40_5 (
    .a(inter[40][4]),
    .b(partial_products[14][26]),
    .c_in(carry[39][6]),
    .sum(inter[40][5]),
    .c_out(carry[40][5])
  );
  fa fa_40_6 (
    .a(inter[40][5]),
    .b(partial_products[15][25]),
    .c_in(carry[39][7]),
    .sum(inter[40][6]),
    .c_out(carry[40][6])
  );
  fa fa_40_7 (
    .a(inter[40][6]),
    .b(partial_products[16][24]),
    .c_in(carry[39][8]),
    .sum(inter[40][7]),
    .c_out(carry[40][7])
  );
  fa fa_40_8 (
    .a(inter[40][7]),
    .b(partial_products[17][23]),
    .c_in(carry[39][9]),
    .sum(inter[40][8]),
    .c_out(carry[40][8])
  );
  fa fa_40_9 (
    .a(inter[40][8]),
    .b(partial_products[18][22]),
    .c_in(carry[39][10]),
    .sum(inter[40][9]),
    .c_out(carry[40][9])
  );
  fa fa_40_10 (
    .a(inter[40][9]),
    .b(partial_products[19][21]),
    .c_in(carry[39][11]),
    .sum(inter[40][10]),
    .c_out(carry[40][10])
  );
  fa fa_40_11 (
    .a(inter[40][10]),
    .b(partial_products[20][20]),
    .c_in(carry[39][12]),
    .sum(inter[40][11]),
    .c_out(carry[40][11])
  );
  fa fa_40_12 (
    .a(inter[40][11]),
    .b(partial_products[21][19]),
    .c_in(carry[39][13]),
    .sum(inter[40][12]),
    .c_out(carry[40][12])
  );
  fa fa_40_13 (
    .a(inter[40][12]),
    .b(partial_products[22][18]),
    .c_in(carry[39][14]),
    .sum(inter[40][13]),
    .c_out(carry[40][13])
  );
  fa fa_40_14 (
    .a(inter[40][13]),
    .b(partial_products[23][17]),
    .c_in(carry[39][15]),
    .sum(inter[40][14]),
    .c_out(carry[40][14])
  );
  fa fa_40_15 (
    .a(inter[40][14]),
    .b(partial_products[24][16]),
    .c_in(carry[39][16]),
    .sum(inter[40][15]),
    .c_out(carry[40][15])
  );
  fa fa_40_16 (
    .a(inter[40][15]),
    .b(partial_products[25][15]),
    .c_in(carry[39][17]),
    .sum(inter[40][16]),
    .c_out(carry[40][16])
  );
  fa fa_40_17 (
    .a(inter[40][16]),
    .b(partial_products[26][14]),
    .c_in(carry[39][18]),
    .sum(inter[40][17]),
    .c_out(carry[40][17])
  );
  fa fa_40_18 (
    .a(inter[40][17]),
    .b(partial_products[27][13]),
    .c_in(carry[39][19]),
    .sum(inter[40][18]),
    .c_out(carry[40][18])
  );
  fa fa_40_19 (
    .a(inter[40][18]),
    .b(partial_products[28][12]),
    .c_in(carry[39][20]),
    .sum(inter[40][19]),
    .c_out(carry[40][19])
  );
  fa fa_40_20 (
    .a(inter[40][19]),
    .b(partial_products[29][11]),
    .c_in(carry[39][21]),
    .sum(inter[40][20]),
    .c_out(carry[40][20])
  );
  fa fa_40_21 (
    .a(inter[40][20]),
    .b(partial_products[30][10]),
    .c_in(carry[39][22]),
    .sum(inter[40][21]),
    .c_out(carry[40][21])
  );
  fa fa_40_22 (
    .a(inter[40][21]),
    .b(partial_products[31][9]),
    .c_in(carry[39][23]),
    .sum(product[40]),
    .c_out(carry[40][22])
  );

  fa fa_41_0 (
    .a(carry[40][0]),
    .b(partial_products[10][31]),
    .c_in(carry[40][1]),
    .sum(inter[41][0]),
    .c_out(carry[41][0])
  );
  fa fa_41_1 (
    .a(inter[41][0]),
    .b(partial_products[11][30]),
    .c_in(carry[40][2]),
    .sum(inter[41][1]),
    .c_out(carry[41][1])
  );
  fa fa_41_2 (
    .a(inter[41][1]),
    .b(partial_products[12][29]),
    .c_in(carry[40][3]),
    .sum(inter[41][2]),
    .c_out(carry[41][2])
  );
  fa fa_41_3 (
    .a(inter[41][2]),
    .b(partial_products[13][28]),
    .c_in(carry[40][4]),
    .sum(inter[41][3]),
    .c_out(carry[41][3])
  );
  fa fa_41_4 (
    .a(inter[41][3]),
    .b(partial_products[14][27]),
    .c_in(carry[40][5]),
    .sum(inter[41][4]),
    .c_out(carry[41][4])
  );
  fa fa_41_5 (
    .a(inter[41][4]),
    .b(partial_products[15][26]),
    .c_in(carry[40][6]),
    .sum(inter[41][5]),
    .c_out(carry[41][5])
  );
  fa fa_41_6 (
    .a(inter[41][5]),
    .b(partial_products[16][25]),
    .c_in(carry[40][7]),
    .sum(inter[41][6]),
    .c_out(carry[41][6])
  );
  fa fa_41_7 (
    .a(inter[41][6]),
    .b(partial_products[17][24]),
    .c_in(carry[40][8]),
    .sum(inter[41][7]),
    .c_out(carry[41][7])
  );
  fa fa_41_8 (
    .a(inter[41][7]),
    .b(partial_products[18][23]),
    .c_in(carry[40][9]),
    .sum(inter[41][8]),
    .c_out(carry[41][8])
  );
  fa fa_41_9 (
    .a(inter[41][8]),
    .b(partial_products[19][22]),
    .c_in(carry[40][10]),
    .sum(inter[41][9]),
    .c_out(carry[41][9])
  );
  fa fa_41_10 (
    .a(inter[41][9]),
    .b(partial_products[20][21]),
    .c_in(carry[40][11]),
    .sum(inter[41][10]),
    .c_out(carry[41][10])
  );
  fa fa_41_11 (
    .a(inter[41][10]),
    .b(partial_products[21][20]),
    .c_in(carry[40][12]),
    .sum(inter[41][11]),
    .c_out(carry[41][11])
  );
  fa fa_41_12 (
    .a(inter[41][11]),
    .b(partial_products[22][19]),
    .c_in(carry[40][13]),
    .sum(inter[41][12]),
    .c_out(carry[41][12])
  );
  fa fa_41_13 (
    .a(inter[41][12]),
    .b(partial_products[23][18]),
    .c_in(carry[40][14]),
    .sum(inter[41][13]),
    .c_out(carry[41][13])
  );
  fa fa_41_14 (
    .a(inter[41][13]),
    .b(partial_products[24][17]),
    .c_in(carry[40][15]),
    .sum(inter[41][14]),
    .c_out(carry[41][14])
  );
  fa fa_41_15 (
    .a(inter[41][14]),
    .b(partial_products[25][16]),
    .c_in(carry[40][16]),
    .sum(inter[41][15]),
    .c_out(carry[41][15])
  );
  fa fa_41_16 (
    .a(inter[41][15]),
    .b(partial_products[26][15]),
    .c_in(carry[40][17]),
    .sum(inter[41][16]),
    .c_out(carry[41][16])
  );
  fa fa_41_17 (
    .a(inter[41][16]),
    .b(partial_products[27][14]),
    .c_in(carry[40][18]),
    .sum(inter[41][17]),
    .c_out(carry[41][17])
  );
  fa fa_41_18 (
    .a(inter[41][17]),
    .b(partial_products[28][13]),
    .c_in(carry[40][19]),
    .sum(inter[41][18]),
    .c_out(carry[41][18])
  );
  fa fa_41_19 (
    .a(inter[41][18]),
    .b(partial_products[29][12]),
    .c_in(carry[40][20]),
    .sum(inter[41][19]),
    .c_out(carry[41][19])
  );
  fa fa_41_20 (
    .a(inter[41][19]),
    .b(partial_products[30][11]),
    .c_in(carry[40][21]),
    .sum(inter[41][20]),
    .c_out(carry[41][20])
  );
  fa fa_41_21 (
    .a(inter[41][20]),
    .b(partial_products[31][10]),
    .c_in(carry[40][22]),
    .sum(product[41]),
    .c_out(carry[41][21])
  );

  fa fa_42_0 (
    .a(carry[41][0]),
    .b(partial_products[11][31]),
    .c_in(carry[41][1]),
    .sum(inter[42][0]),
    .c_out(carry[42][0])
  );
  fa fa_42_1 (
    .a(inter[42][0]),
    .b(partial_products[12][30]),
    .c_in(carry[41][2]),
    .sum(inter[42][1]),
    .c_out(carry[42][1])
  );
  fa fa_42_2 (
    .a(inter[42][1]),
    .b(partial_products[13][29]),
    .c_in(carry[41][3]),
    .sum(inter[42][2]),
    .c_out(carry[42][2])
  );
  fa fa_42_3 (
    .a(inter[42][2]),
    .b(partial_products[14][28]),
    .c_in(carry[41][4]),
    .sum(inter[42][3]),
    .c_out(carry[42][3])
  );
  fa fa_42_4 (
    .a(inter[42][3]),
    .b(partial_products[15][27]),
    .c_in(carry[41][5]),
    .sum(inter[42][4]),
    .c_out(carry[42][4])
  );
  fa fa_42_5 (
    .a(inter[42][4]),
    .b(partial_products[16][26]),
    .c_in(carry[41][6]),
    .sum(inter[42][5]),
    .c_out(carry[42][5])
  );
  fa fa_42_6 (
    .a(inter[42][5]),
    .b(partial_products[17][25]),
    .c_in(carry[41][7]),
    .sum(inter[42][6]),
    .c_out(carry[42][6])
  );
  fa fa_42_7 (
    .a(inter[42][6]),
    .b(partial_products[18][24]),
    .c_in(carry[41][8]),
    .sum(inter[42][7]),
    .c_out(carry[42][7])
  );
  fa fa_42_8 (
    .a(inter[42][7]),
    .b(partial_products[19][23]),
    .c_in(carry[41][9]),
    .sum(inter[42][8]),
    .c_out(carry[42][8])
  );
  fa fa_42_9 (
    .a(inter[42][8]),
    .b(partial_products[20][22]),
    .c_in(carry[41][10]),
    .sum(inter[42][9]),
    .c_out(carry[42][9])
  );
  fa fa_42_10 (
    .a(inter[42][9]),
    .b(partial_products[21][21]),
    .c_in(carry[41][11]),
    .sum(inter[42][10]),
    .c_out(carry[42][10])
  );
  fa fa_42_11 (
    .a(inter[42][10]),
    .b(partial_products[22][20]),
    .c_in(carry[41][12]),
    .sum(inter[42][11]),
    .c_out(carry[42][11])
  );
  fa fa_42_12 (
    .a(inter[42][11]),
    .b(partial_products[23][19]),
    .c_in(carry[41][13]),
    .sum(inter[42][12]),
    .c_out(carry[42][12])
  );
  fa fa_42_13 (
    .a(inter[42][12]),
    .b(partial_products[24][18]),
    .c_in(carry[41][14]),
    .sum(inter[42][13]),
    .c_out(carry[42][13])
  );
  fa fa_42_14 (
    .a(inter[42][13]),
    .b(partial_products[25][17]),
    .c_in(carry[41][15]),
    .sum(inter[42][14]),
    .c_out(carry[42][14])
  );
  fa fa_42_15 (
    .a(inter[42][14]),
    .b(partial_products[26][16]),
    .c_in(carry[41][16]),
    .sum(inter[42][15]),
    .c_out(carry[42][15])
  );
  fa fa_42_16 (
    .a(inter[42][15]),
    .b(partial_products[27][15]),
    .c_in(carry[41][17]),
    .sum(inter[42][16]),
    .c_out(carry[42][16])
  );
  fa fa_42_17 (
    .a(inter[42][16]),
    .b(partial_products[28][14]),
    .c_in(carry[41][18]),
    .sum(inter[42][17]),
    .c_out(carry[42][17])
  );
  fa fa_42_18 (
    .a(inter[42][17]),
    .b(partial_products[29][13]),
    .c_in(carry[41][19]),
    .sum(inter[42][18]),
    .c_out(carry[42][18])
  );
  fa fa_42_19 (
    .a(inter[42][18]),
    .b(partial_products[30][12]),
    .c_in(carry[41][20]),
    .sum(inter[42][19]),
    .c_out(carry[42][19])
  );
  fa fa_42_20 (
    .a(inter[42][19]),
    .b(partial_products[31][11]),
    .c_in(carry[41][21]),
    .sum(product[42]),
    .c_out(carry[42][20])
  );

  fa fa_43_0 (
    .a(carry[42][0]),
    .b(partial_products[12][31]),
    .c_in(carry[42][1]),
    .sum(inter[43][0]),
    .c_out(carry[43][0])
  );
  fa fa_43_1 (
    .a(inter[43][0]),
    .b(partial_products[13][30]),
    .c_in(carry[42][2]),
    .sum(inter[43][1]),
    .c_out(carry[43][1])
  );
  fa fa_43_2 (
    .a(inter[43][1]),
    .b(partial_products[14][29]),
    .c_in(carry[42][3]),
    .sum(inter[43][2]),
    .c_out(carry[43][2])
  );
  fa fa_43_3 (
    .a(inter[43][2]),
    .b(partial_products[15][28]),
    .c_in(carry[42][4]),
    .sum(inter[43][3]),
    .c_out(carry[43][3])
  );
  fa fa_43_4 (
    .a(inter[43][3]),
    .b(partial_products[16][27]),
    .c_in(carry[42][5]),
    .sum(inter[43][4]),
    .c_out(carry[43][4])
  );
  fa fa_43_5 (
    .a(inter[43][4]),
    .b(partial_products[17][26]),
    .c_in(carry[42][6]),
    .sum(inter[43][5]),
    .c_out(carry[43][5])
  );
  fa fa_43_6 (
    .a(inter[43][5]),
    .b(partial_products[18][25]),
    .c_in(carry[42][7]),
    .sum(inter[43][6]),
    .c_out(carry[43][6])
  );
  fa fa_43_7 (
    .a(inter[43][6]),
    .b(partial_products[19][24]),
    .c_in(carry[42][8]),
    .sum(inter[43][7]),
    .c_out(carry[43][7])
  );
  fa fa_43_8 (
    .a(inter[43][7]),
    .b(partial_products[20][23]),
    .c_in(carry[42][9]),
    .sum(inter[43][8]),
    .c_out(carry[43][8])
  );
  fa fa_43_9 (
    .a(inter[43][8]),
    .b(partial_products[21][22]),
    .c_in(carry[42][10]),
    .sum(inter[43][9]),
    .c_out(carry[43][9])
  );
  fa fa_43_10 (
    .a(inter[43][9]),
    .b(partial_products[22][21]),
    .c_in(carry[42][11]),
    .sum(inter[43][10]),
    .c_out(carry[43][10])
  );
  fa fa_43_11 (
    .a(inter[43][10]),
    .b(partial_products[23][20]),
    .c_in(carry[42][12]),
    .sum(inter[43][11]),
    .c_out(carry[43][11])
  );
  fa fa_43_12 (
    .a(inter[43][11]),
    .b(partial_products[24][19]),
    .c_in(carry[42][13]),
    .sum(inter[43][12]),
    .c_out(carry[43][12])
  );
  fa fa_43_13 (
    .a(inter[43][12]),
    .b(partial_products[25][18]),
    .c_in(carry[42][14]),
    .sum(inter[43][13]),
    .c_out(carry[43][13])
  );
  fa fa_43_14 (
    .a(inter[43][13]),
    .b(partial_products[26][17]),
    .c_in(carry[42][15]),
    .sum(inter[43][14]),
    .c_out(carry[43][14])
  );
  fa fa_43_15 (
    .a(inter[43][14]),
    .b(partial_products[27][16]),
    .c_in(carry[42][16]),
    .sum(inter[43][15]),
    .c_out(carry[43][15])
  );
  fa fa_43_16 (
    .a(inter[43][15]),
    .b(partial_products[28][15]),
    .c_in(carry[42][17]),
    .sum(inter[43][16]),
    .c_out(carry[43][16])
  );
  fa fa_43_17 (
    .a(inter[43][16]),
    .b(partial_products[29][14]),
    .c_in(carry[42][18]),
    .sum(inter[43][17]),
    .c_out(carry[43][17])
  );
  fa fa_43_18 (
    .a(inter[43][17]),
    .b(partial_products[30][13]),
    .c_in(carry[42][19]),
    .sum(inter[43][18]),
    .c_out(carry[43][18])
  );
  fa fa_43_19 (
    .a(inter[43][18]),
    .b(partial_products[31][12]),
    .c_in(carry[42][20]),
    .sum(product[43]),
    .c_out(carry[43][19])
  );

  fa fa_44_0 (
    .a(carry[43][0]),
    .b(partial_products[13][31]),
    .c_in(carry[43][1]),
    .sum(inter[44][0]),
    .c_out(carry[44][0])
  );
  fa fa_44_1 (
    .a(inter[44][0]),
    .b(partial_products[14][30]),
    .c_in(carry[43][2]),
    .sum(inter[44][1]),
    .c_out(carry[44][1])
  );
  fa fa_44_2 (
    .a(inter[44][1]),
    .b(partial_products[15][29]),
    .c_in(carry[43][3]),
    .sum(inter[44][2]),
    .c_out(carry[44][2])
  );
  fa fa_44_3 (
    .a(inter[44][2]),
    .b(partial_products[16][28]),
    .c_in(carry[43][4]),
    .sum(inter[44][3]),
    .c_out(carry[44][3])
  );
  fa fa_44_4 (
    .a(inter[44][3]),
    .b(partial_products[17][27]),
    .c_in(carry[43][5]),
    .sum(inter[44][4]),
    .c_out(carry[44][4])
  );
  fa fa_44_5 (
    .a(inter[44][4]),
    .b(partial_products[18][26]),
    .c_in(carry[43][6]),
    .sum(inter[44][5]),
    .c_out(carry[44][5])
  );
  fa fa_44_6 (
    .a(inter[44][5]),
    .b(partial_products[19][25]),
    .c_in(carry[43][7]),
    .sum(inter[44][6]),
    .c_out(carry[44][6])
  );
  fa fa_44_7 (
    .a(inter[44][6]),
    .b(partial_products[20][24]),
    .c_in(carry[43][8]),
    .sum(inter[44][7]),
    .c_out(carry[44][7])
  );
  fa fa_44_8 (
    .a(inter[44][7]),
    .b(partial_products[21][23]),
    .c_in(carry[43][9]),
    .sum(inter[44][8]),
    .c_out(carry[44][8])
  );
  fa fa_44_9 (
    .a(inter[44][8]),
    .b(partial_products[22][22]),
    .c_in(carry[43][10]),
    .sum(inter[44][9]),
    .c_out(carry[44][9])
  );
  fa fa_44_10 (
    .a(inter[44][9]),
    .b(partial_products[23][21]),
    .c_in(carry[43][11]),
    .sum(inter[44][10]),
    .c_out(carry[44][10])
  );
  fa fa_44_11 (
    .a(inter[44][10]),
    .b(partial_products[24][20]),
    .c_in(carry[43][12]),
    .sum(inter[44][11]),
    .c_out(carry[44][11])
  );
  fa fa_44_12 (
    .a(inter[44][11]),
    .b(partial_products[25][19]),
    .c_in(carry[43][13]),
    .sum(inter[44][12]),
    .c_out(carry[44][12])
  );
  fa fa_44_13 (
    .a(inter[44][12]),
    .b(partial_products[26][18]),
    .c_in(carry[43][14]),
    .sum(inter[44][13]),
    .c_out(carry[44][13])
  );
  fa fa_44_14 (
    .a(inter[44][13]),
    .b(partial_products[27][17]),
    .c_in(carry[43][15]),
    .sum(inter[44][14]),
    .c_out(carry[44][14])
  );
  fa fa_44_15 (
    .a(inter[44][14]),
    .b(partial_products[28][16]),
    .c_in(carry[43][16]),
    .sum(inter[44][15]),
    .c_out(carry[44][15])
  );
  fa fa_44_16 (
    .a(inter[44][15]),
    .b(partial_products[29][15]),
    .c_in(carry[43][17]),
    .sum(inter[44][16]),
    .c_out(carry[44][16])
  );
  fa fa_44_17 (
    .a(inter[44][16]),
    .b(partial_products[30][14]),
    .c_in(carry[43][18]),
    .sum(inter[44][17]),
    .c_out(carry[44][17])
  );
  fa fa_44_18 (
    .a(inter[44][17]),
    .b(partial_products[31][13]),
    .c_in(carry[43][19]),
    .sum(product[44]),
    .c_out(carry[44][18])
  );

  fa fa_45_0 (
    .a(carry[44][0]),
    .b(partial_products[14][31]),
    .c_in(carry[44][1]),
    .sum(inter[45][0]),
    .c_out(carry[45][0])
  );
  fa fa_45_1 (
    .a(inter[45][0]),
    .b(partial_products[15][30]),
    .c_in(carry[44][2]),
    .sum(inter[45][1]),
    .c_out(carry[45][1])
  );
  fa fa_45_2 (
    .a(inter[45][1]),
    .b(partial_products[16][29]),
    .c_in(carry[44][3]),
    .sum(inter[45][2]),
    .c_out(carry[45][2])
  );
  fa fa_45_3 (
    .a(inter[45][2]),
    .b(partial_products[17][28]),
    .c_in(carry[44][4]),
    .sum(inter[45][3]),
    .c_out(carry[45][3])
  );
  fa fa_45_4 (
    .a(inter[45][3]),
    .b(partial_products[18][27]),
    .c_in(carry[44][5]),
    .sum(inter[45][4]),
    .c_out(carry[45][4])
  );
  fa fa_45_5 (
    .a(inter[45][4]),
    .b(partial_products[19][26]),
    .c_in(carry[44][6]),
    .sum(inter[45][5]),
    .c_out(carry[45][5])
  );
  fa fa_45_6 (
    .a(inter[45][5]),
    .b(partial_products[20][25]),
    .c_in(carry[44][7]),
    .sum(inter[45][6]),
    .c_out(carry[45][6])
  );
  fa fa_45_7 (
    .a(inter[45][6]),
    .b(partial_products[21][24]),
    .c_in(carry[44][8]),
    .sum(inter[45][7]),
    .c_out(carry[45][7])
  );
  fa fa_45_8 (
    .a(inter[45][7]),
    .b(partial_products[22][23]),
    .c_in(carry[44][9]),
    .sum(inter[45][8]),
    .c_out(carry[45][8])
  );
  fa fa_45_9 (
    .a(inter[45][8]),
    .b(partial_products[23][22]),
    .c_in(carry[44][10]),
    .sum(inter[45][9]),
    .c_out(carry[45][9])
  );
  fa fa_45_10 (
    .a(inter[45][9]),
    .b(partial_products[24][21]),
    .c_in(carry[44][11]),
    .sum(inter[45][10]),
    .c_out(carry[45][10])
  );
  fa fa_45_11 (
    .a(inter[45][10]),
    .b(partial_products[25][20]),
    .c_in(carry[44][12]),
    .sum(inter[45][11]),
    .c_out(carry[45][11])
  );
  fa fa_45_12 (
    .a(inter[45][11]),
    .b(partial_products[26][19]),
    .c_in(carry[44][13]),
    .sum(inter[45][12]),
    .c_out(carry[45][12])
  );
  fa fa_45_13 (
    .a(inter[45][12]),
    .b(partial_products[27][18]),
    .c_in(carry[44][14]),
    .sum(inter[45][13]),
    .c_out(carry[45][13])
  );
  fa fa_45_14 (
    .a(inter[45][13]),
    .b(partial_products[28][17]),
    .c_in(carry[44][15]),
    .sum(inter[45][14]),
    .c_out(carry[45][14])
  );
  fa fa_45_15 (
    .a(inter[45][14]),
    .b(partial_products[29][16]),
    .c_in(carry[44][16]),
    .sum(inter[45][15]),
    .c_out(carry[45][15])
  );
  fa fa_45_16 (
    .a(inter[45][15]),
    .b(partial_products[30][15]),
    .c_in(carry[44][17]),
    .sum(inter[45][16]),
    .c_out(carry[45][16])
  );
  fa fa_45_17 (
    .a(inter[45][16]),
    .b(partial_products[31][14]),
    .c_in(carry[44][18]),
    .sum(product[45]),
    .c_out(carry[45][17])
  );

  fa fa_46_0 (
    .a(carry[45][0]),
    .b(partial_products[15][31]),
    .c_in(carry[45][1]),
    .sum(inter[46][0]),
    .c_out(carry[46][0])
  );
  fa fa_46_1 (
    .a(inter[46][0]),
    .b(partial_products[16][30]),
    .c_in(carry[45][2]),
    .sum(inter[46][1]),
    .c_out(carry[46][1])
  );
  fa fa_46_2 (
    .a(inter[46][1]),
    .b(partial_products[17][29]),
    .c_in(carry[45][3]),
    .sum(inter[46][2]),
    .c_out(carry[46][2])
  );
  fa fa_46_3 (
    .a(inter[46][2]),
    .b(partial_products[18][28]),
    .c_in(carry[45][4]),
    .sum(inter[46][3]),
    .c_out(carry[46][3])
  );
  fa fa_46_4 (
    .a(inter[46][3]),
    .b(partial_products[19][27]),
    .c_in(carry[45][5]),
    .sum(inter[46][4]),
    .c_out(carry[46][4])
  );
  fa fa_46_5 (
    .a(inter[46][4]),
    .b(partial_products[20][26]),
    .c_in(carry[45][6]),
    .sum(inter[46][5]),
    .c_out(carry[46][5])
  );
  fa fa_46_6 (
    .a(inter[46][5]),
    .b(partial_products[21][25]),
    .c_in(carry[45][7]),
    .sum(inter[46][6]),
    .c_out(carry[46][6])
  );
  fa fa_46_7 (
    .a(inter[46][6]),
    .b(partial_products[22][24]),
    .c_in(carry[45][8]),
    .sum(inter[46][7]),
    .c_out(carry[46][7])
  );
  fa fa_46_8 (
    .a(inter[46][7]),
    .b(partial_products[23][23]),
    .c_in(carry[45][9]),
    .sum(inter[46][8]),
    .c_out(carry[46][8])
  );
  fa fa_46_9 (
    .a(inter[46][8]),
    .b(partial_products[24][22]),
    .c_in(carry[45][10]),
    .sum(inter[46][9]),
    .c_out(carry[46][9])
  );
  fa fa_46_10 (
    .a(inter[46][9]),
    .b(partial_products[25][21]),
    .c_in(carry[45][11]),
    .sum(inter[46][10]),
    .c_out(carry[46][10])
  );
  fa fa_46_11 (
    .a(inter[46][10]),
    .b(partial_products[26][20]),
    .c_in(carry[45][12]),
    .sum(inter[46][11]),
    .c_out(carry[46][11])
  );
  fa fa_46_12 (
    .a(inter[46][11]),
    .b(partial_products[27][19]),
    .c_in(carry[45][13]),
    .sum(inter[46][12]),
    .c_out(carry[46][12])
  );
  fa fa_46_13 (
    .a(inter[46][12]),
    .b(partial_products[28][18]),
    .c_in(carry[45][14]),
    .sum(inter[46][13]),
    .c_out(carry[46][13])
  );
  fa fa_46_14 (
    .a(inter[46][13]),
    .b(partial_products[29][17]),
    .c_in(carry[45][15]),
    .sum(inter[46][14]),
    .c_out(carry[46][14])
  );
  fa fa_46_15 (
    .a(inter[46][14]),
    .b(partial_products[30][16]),
    .c_in(carry[45][16]),
    .sum(inter[46][15]),
    .c_out(carry[46][15])
  );
  fa fa_46_16 (
    .a(inter[46][15]),
    .b(partial_products[31][15]),
    .c_in(carry[45][17]),
    .sum(product[46]),
    .c_out(carry[46][16])
  );

  fa fa_47_0 (
    .a(carry[46][0]),
    .b(partial_products[16][31]),
    .c_in(carry[46][1]),
    .sum(inter[47][0]),
    .c_out(carry[47][0])
  );
  fa fa_47_1 (
    .a(inter[47][0]),
    .b(partial_products[17][30]),
    .c_in(carry[46][2]),
    .sum(inter[47][1]),
    .c_out(carry[47][1])
  );
  fa fa_47_2 (
    .a(inter[47][1]),
    .b(partial_products[18][29]),
    .c_in(carry[46][3]),
    .sum(inter[47][2]),
    .c_out(carry[47][2])
  );
  fa fa_47_3 (
    .a(inter[47][2]),
    .b(partial_products[19][28]),
    .c_in(carry[46][4]),
    .sum(inter[47][3]),
    .c_out(carry[47][3])
  );
  fa fa_47_4 (
    .a(inter[47][3]),
    .b(partial_products[20][27]),
    .c_in(carry[46][5]),
    .sum(inter[47][4]),
    .c_out(carry[47][4])
  );
  fa fa_47_5 (
    .a(inter[47][4]),
    .b(partial_products[21][26]),
    .c_in(carry[46][6]),
    .sum(inter[47][5]),
    .c_out(carry[47][5])
  );
  fa fa_47_6 (
    .a(inter[47][5]),
    .b(partial_products[22][25]),
    .c_in(carry[46][7]),
    .sum(inter[47][6]),
    .c_out(carry[47][6])
  );
  fa fa_47_7 (
    .a(inter[47][6]),
    .b(partial_products[23][24]),
    .c_in(carry[46][8]),
    .sum(inter[47][7]),
    .c_out(carry[47][7])
  );
  fa fa_47_8 (
    .a(inter[47][7]),
    .b(partial_products[24][23]),
    .c_in(carry[46][9]),
    .sum(inter[47][8]),
    .c_out(carry[47][8])
  );
  fa fa_47_9 (
    .a(inter[47][8]),
    .b(partial_products[25][22]),
    .c_in(carry[46][10]),
    .sum(inter[47][9]),
    .c_out(carry[47][9])
  );
  fa fa_47_10 (
    .a(inter[47][9]),
    .b(partial_products[26][21]),
    .c_in(carry[46][11]),
    .sum(inter[47][10]),
    .c_out(carry[47][10])
  );
  fa fa_47_11 (
    .a(inter[47][10]),
    .b(partial_products[27][20]),
    .c_in(carry[46][12]),
    .sum(inter[47][11]),
    .c_out(carry[47][11])
  );
  fa fa_47_12 (
    .a(inter[47][11]),
    .b(partial_products[28][19]),
    .c_in(carry[46][13]),
    .sum(inter[47][12]),
    .c_out(carry[47][12])
  );
  fa fa_47_13 (
    .a(inter[47][12]),
    .b(partial_products[29][18]),
    .c_in(carry[46][14]),
    .sum(inter[47][13]),
    .c_out(carry[47][13])
  );
  fa fa_47_14 (
    .a(inter[47][13]),
    .b(partial_products[30][17]),
    .c_in(carry[46][15]),
    .sum(inter[47][14]),
    .c_out(carry[47][14])
  );
  fa fa_47_15 (
    .a(inter[47][14]),
    .b(partial_products[31][16]),
    .c_in(carry[46][16]),
    .sum(product[47]),
    .c_out(carry[47][15])
  );

  fa fa_48_0 (
    .a(carry[47][0]),
    .b(partial_products[17][31]),
    .c_in(carry[47][1]),
    .sum(inter[48][0]),
    .c_out(carry[48][0])
  );
  fa fa_48_1 (
    .a(inter[48][0]),
    .b(partial_products[18][30]),
    .c_in(carry[47][2]),
    .sum(inter[48][1]),
    .c_out(carry[48][1])
  );
  fa fa_48_2 (
    .a(inter[48][1]),
    .b(partial_products[19][29]),
    .c_in(carry[47][3]),
    .sum(inter[48][2]),
    .c_out(carry[48][2])
  );
  fa fa_48_3 (
    .a(inter[48][2]),
    .b(partial_products[20][28]),
    .c_in(carry[47][4]),
    .sum(inter[48][3]),
    .c_out(carry[48][3])
  );
  fa fa_48_4 (
    .a(inter[48][3]),
    .b(partial_products[21][27]),
    .c_in(carry[47][5]),
    .sum(inter[48][4]),
    .c_out(carry[48][4])
  );
  fa fa_48_5 (
    .a(inter[48][4]),
    .b(partial_products[22][26]),
    .c_in(carry[47][6]),
    .sum(inter[48][5]),
    .c_out(carry[48][5])
  );
  fa fa_48_6 (
    .a(inter[48][5]),
    .b(partial_products[23][25]),
    .c_in(carry[47][7]),
    .sum(inter[48][6]),
    .c_out(carry[48][6])
  );
  fa fa_48_7 (
    .a(inter[48][6]),
    .b(partial_products[24][24]),
    .c_in(carry[47][8]),
    .sum(inter[48][7]),
    .c_out(carry[48][7])
  );
  fa fa_48_8 (
    .a(inter[48][7]),
    .b(partial_products[25][23]),
    .c_in(carry[47][9]),
    .sum(inter[48][8]),
    .c_out(carry[48][8])
  );
  fa fa_48_9 (
    .a(inter[48][8]),
    .b(partial_products[26][22]),
    .c_in(carry[47][10]),
    .sum(inter[48][9]),
    .c_out(carry[48][9])
  );
  fa fa_48_10 (
    .a(inter[48][9]),
    .b(partial_products[27][21]),
    .c_in(carry[47][11]),
    .sum(inter[48][10]),
    .c_out(carry[48][10])
  );
  fa fa_48_11 (
    .a(inter[48][10]),
    .b(partial_products[28][20]),
    .c_in(carry[47][12]),
    .sum(inter[48][11]),
    .c_out(carry[48][11])
  );
  fa fa_48_12 (
    .a(inter[48][11]),
    .b(partial_products[29][19]),
    .c_in(carry[47][13]),
    .sum(inter[48][12]),
    .c_out(carry[48][12])
  );
  fa fa_48_13 (
    .a(inter[48][12]),
    .b(partial_products[30][18]),
    .c_in(carry[47][14]),
    .sum(inter[48][13]),
    .c_out(carry[48][13])
  );
  fa fa_48_14 (
    .a(inter[48][13]),
    .b(partial_products[31][17]),
    .c_in(carry[47][15]),
    .sum(product[48]),
    .c_out(carry[48][14])
  );

  fa fa_49_0 (
    .a(carry[48][0]),
    .b(partial_products[18][31]),
    .c_in(carry[48][1]),
    .sum(inter[49][0]),
    .c_out(carry[49][0])
  );
  fa fa_49_1 (
    .a(inter[49][0]),
    .b(partial_products[19][30]),
    .c_in(carry[48][2]),
    .sum(inter[49][1]),
    .c_out(carry[49][1])
  );
  fa fa_49_2 (
    .a(inter[49][1]),
    .b(partial_products[20][29]),
    .c_in(carry[48][3]),
    .sum(inter[49][2]),
    .c_out(carry[49][2])
  );
  fa fa_49_3 (
    .a(inter[49][2]),
    .b(partial_products[21][28]),
    .c_in(carry[48][4]),
    .sum(inter[49][3]),
    .c_out(carry[49][3])
  );
  fa fa_49_4 (
    .a(inter[49][3]),
    .b(partial_products[22][27]),
    .c_in(carry[48][5]),
    .sum(inter[49][4]),
    .c_out(carry[49][4])
  );
  fa fa_49_5 (
    .a(inter[49][4]),
    .b(partial_products[23][26]),
    .c_in(carry[48][6]),
    .sum(inter[49][5]),
    .c_out(carry[49][5])
  );
  fa fa_49_6 (
    .a(inter[49][5]),
    .b(partial_products[24][25]),
    .c_in(carry[48][7]),
    .sum(inter[49][6]),
    .c_out(carry[49][6])
  );
  fa fa_49_7 (
    .a(inter[49][6]),
    .b(partial_products[25][24]),
    .c_in(carry[48][8]),
    .sum(inter[49][7]),
    .c_out(carry[49][7])
  );
  fa fa_49_8 (
    .a(inter[49][7]),
    .b(partial_products[26][23]),
    .c_in(carry[48][9]),
    .sum(inter[49][8]),
    .c_out(carry[49][8])
  );
  fa fa_49_9 (
    .a(inter[49][8]),
    .b(partial_products[27][22]),
    .c_in(carry[48][10]),
    .sum(inter[49][9]),
    .c_out(carry[49][9])
  );
  fa fa_49_10 (
    .a(inter[49][9]),
    .b(partial_products[28][21]),
    .c_in(carry[48][11]),
    .sum(inter[49][10]),
    .c_out(carry[49][10])
  );
  fa fa_49_11 (
    .a(inter[49][10]),
    .b(partial_products[29][20]),
    .c_in(carry[48][12]),
    .sum(inter[49][11]),
    .c_out(carry[49][11])
  );
  fa fa_49_12 (
    .a(inter[49][11]),
    .b(partial_products[30][19]),
    .c_in(carry[48][13]),
    .sum(inter[49][12]),
    .c_out(carry[49][12])
  );
  fa fa_49_13 (
    .a(inter[49][12]),
    .b(partial_products[31][18]),
    .c_in(carry[48][14]),
    .sum(product[49]),
    .c_out(carry[49][13])
  );

  fa fa_50_0 (
    .a(carry[49][0]),
    .b(partial_products[19][31]),
    .c_in(carry[49][1]),
    .sum(inter[50][0]),
    .c_out(carry[50][0])
  );
  fa fa_50_1 (
    .a(inter[50][0]),
    .b(partial_products[20][30]),
    .c_in(carry[49][2]),
    .sum(inter[50][1]),
    .c_out(carry[50][1])
  );
  fa fa_50_2 (
    .a(inter[50][1]),
    .b(partial_products[21][29]),
    .c_in(carry[49][3]),
    .sum(inter[50][2]),
    .c_out(carry[50][2])
  );
  fa fa_50_3 (
    .a(inter[50][2]),
    .b(partial_products[22][28]),
    .c_in(carry[49][4]),
    .sum(inter[50][3]),
    .c_out(carry[50][3])
  );
  fa fa_50_4 (
    .a(inter[50][3]),
    .b(partial_products[23][27]),
    .c_in(carry[49][5]),
    .sum(inter[50][4]),
    .c_out(carry[50][4])
  );
  fa fa_50_5 (
    .a(inter[50][4]),
    .b(partial_products[24][26]),
    .c_in(carry[49][6]),
    .sum(inter[50][5]),
    .c_out(carry[50][5])
  );
  fa fa_50_6 (
    .a(inter[50][5]),
    .b(partial_products[25][25]),
    .c_in(carry[49][7]),
    .sum(inter[50][6]),
    .c_out(carry[50][6])
  );
  fa fa_50_7 (
    .a(inter[50][6]),
    .b(partial_products[26][24]),
    .c_in(carry[49][8]),
    .sum(inter[50][7]),
    .c_out(carry[50][7])
  );
  fa fa_50_8 (
    .a(inter[50][7]),
    .b(partial_products[27][23]),
    .c_in(carry[49][9]),
    .sum(inter[50][8]),
    .c_out(carry[50][8])
  );
  fa fa_50_9 (
    .a(inter[50][8]),
    .b(partial_products[28][22]),
    .c_in(carry[49][10]),
    .sum(inter[50][9]),
    .c_out(carry[50][9])
  );
  fa fa_50_10 (
    .a(inter[50][9]),
    .b(partial_products[29][21]),
    .c_in(carry[49][11]),
    .sum(inter[50][10]),
    .c_out(carry[50][10])
  );
  fa fa_50_11 (
    .a(inter[50][10]),
    .b(partial_products[30][20]),
    .c_in(carry[49][12]),
    .sum(inter[50][11]),
    .c_out(carry[50][11])
  );
  fa fa_50_12 (
    .a(inter[50][11]),
    .b(partial_products[31][19]),
    .c_in(carry[49][13]),
    .sum(product[50]),
    .c_out(carry[50][12])
  );

  fa fa_51_0 (
    .a(carry[50][0]),
    .b(partial_products[20][31]),
    .c_in(carry[50][1]),
    .sum(inter[51][0]),
    .c_out(carry[51][0])
  );
  fa fa_51_1 (
    .a(inter[51][0]),
    .b(partial_products[21][30]),
    .c_in(carry[50][2]),
    .sum(inter[51][1]),
    .c_out(carry[51][1])
  );
  fa fa_51_2 (
    .a(inter[51][1]),
    .b(partial_products[22][29]),
    .c_in(carry[50][3]),
    .sum(inter[51][2]),
    .c_out(carry[51][2])
  );
  fa fa_51_3 (
    .a(inter[51][2]),
    .b(partial_products[23][28]),
    .c_in(carry[50][4]),
    .sum(inter[51][3]),
    .c_out(carry[51][3])
  );
  fa fa_51_4 (
    .a(inter[51][3]),
    .b(partial_products[24][27]),
    .c_in(carry[50][5]),
    .sum(inter[51][4]),
    .c_out(carry[51][4])
  );
  fa fa_51_5 (
    .a(inter[51][4]),
    .b(partial_products[25][26]),
    .c_in(carry[50][6]),
    .sum(inter[51][5]),
    .c_out(carry[51][5])
  );
  fa fa_51_6 (
    .a(inter[51][5]),
    .b(partial_products[26][25]),
    .c_in(carry[50][7]),
    .sum(inter[51][6]),
    .c_out(carry[51][6])
  );
  fa fa_51_7 (
    .a(inter[51][6]),
    .b(partial_products[27][24]),
    .c_in(carry[50][8]),
    .sum(inter[51][7]),
    .c_out(carry[51][7])
  );
  fa fa_51_8 (
    .a(inter[51][7]),
    .b(partial_products[28][23]),
    .c_in(carry[50][9]),
    .sum(inter[51][8]),
    .c_out(carry[51][8])
  );
  fa fa_51_9 (
    .a(inter[51][8]),
    .b(partial_products[29][22]),
    .c_in(carry[50][10]),
    .sum(inter[51][9]),
    .c_out(carry[51][9])
  );
  fa fa_51_10 (
    .a(inter[51][9]),
    .b(partial_products[30][21]),
    .c_in(carry[50][11]),
    .sum(inter[51][10]),
    .c_out(carry[51][10])
  );
  fa fa_51_11 (
    .a(inter[51][10]),
    .b(partial_products[31][20]),
    .c_in(carry[50][12]),
    .sum(product[51]),
    .c_out(carry[51][11])
  );

  fa fa_52_0 (
    .a(carry[51][0]),
    .b(partial_products[21][31]),
    .c_in(carry[51][1]),
    .sum(inter[52][0]),
    .c_out(carry[52][0])
  );
  fa fa_52_1 (
    .a(inter[52][0]),
    .b(partial_products[22][30]),
    .c_in(carry[51][2]),
    .sum(inter[52][1]),
    .c_out(carry[52][1])
  );
  fa fa_52_2 (
    .a(inter[52][1]),
    .b(partial_products[23][29]),
    .c_in(carry[51][3]),
    .sum(inter[52][2]),
    .c_out(carry[52][2])
  );
  fa fa_52_3 (
    .a(inter[52][2]),
    .b(partial_products[24][28]),
    .c_in(carry[51][4]),
    .sum(inter[52][3]),
    .c_out(carry[52][3])
  );
  fa fa_52_4 (
    .a(inter[52][3]),
    .b(partial_products[25][27]),
    .c_in(carry[51][5]),
    .sum(inter[52][4]),
    .c_out(carry[52][4])
  );
  fa fa_52_5 (
    .a(inter[52][4]),
    .b(partial_products[26][26]),
    .c_in(carry[51][6]),
    .sum(inter[52][5]),
    .c_out(carry[52][5])
  );
  fa fa_52_6 (
    .a(inter[52][5]),
    .b(partial_products[27][25]),
    .c_in(carry[51][7]),
    .sum(inter[52][6]),
    .c_out(carry[52][6])
  );
  fa fa_52_7 (
    .a(inter[52][6]),
    .b(partial_products[28][24]),
    .c_in(carry[51][8]),
    .sum(inter[52][7]),
    .c_out(carry[52][7])
  );
  fa fa_52_8 (
    .a(inter[52][7]),
    .b(partial_products[29][23]),
    .c_in(carry[51][9]),
    .sum(inter[52][8]),
    .c_out(carry[52][8])
  );
  fa fa_52_9 (
    .a(inter[52][8]),
    .b(partial_products[30][22]),
    .c_in(carry[51][10]),
    .sum(inter[52][9]),
    .c_out(carry[52][9])
  );
  fa fa_52_10 (
    .a(inter[52][9]),
    .b(partial_products[31][21]),
    .c_in(carry[51][11]),
    .sum(product[52]),
    .c_out(carry[52][10])
  );

  fa fa_53_0 (
    .a(carry[52][0]),
    .b(partial_products[22][31]),
    .c_in(carry[52][1]),
    .sum(inter[53][0]),
    .c_out(carry[53][0])
  );
  fa fa_53_1 (
    .a(inter[53][0]),
    .b(partial_products[23][30]),
    .c_in(carry[52][2]),
    .sum(inter[53][1]),
    .c_out(carry[53][1])
  );
  fa fa_53_2 (
    .a(inter[53][1]),
    .b(partial_products[24][29]),
    .c_in(carry[52][3]),
    .sum(inter[53][2]),
    .c_out(carry[53][2])
  );
  fa fa_53_3 (
    .a(inter[53][2]),
    .b(partial_products[25][28]),
    .c_in(carry[52][4]),
    .sum(inter[53][3]),
    .c_out(carry[53][3])
  );
  fa fa_53_4 (
    .a(inter[53][3]),
    .b(partial_products[26][27]),
    .c_in(carry[52][5]),
    .sum(inter[53][4]),
    .c_out(carry[53][4])
  );
  fa fa_53_5 (
    .a(inter[53][4]),
    .b(partial_products[27][26]),
    .c_in(carry[52][6]),
    .sum(inter[53][5]),
    .c_out(carry[53][5])
  );
  fa fa_53_6 (
    .a(inter[53][5]),
    .b(partial_products[28][25]),
    .c_in(carry[52][7]),
    .sum(inter[53][6]),
    .c_out(carry[53][6])
  );
  fa fa_53_7 (
    .a(inter[53][6]),
    .b(partial_products[29][24]),
    .c_in(carry[52][8]),
    .sum(inter[53][7]),
    .c_out(carry[53][7])
  );
  fa fa_53_8 (
    .a(inter[53][7]),
    .b(partial_products[30][23]),
    .c_in(carry[52][9]),
    .sum(inter[53][8]),
    .c_out(carry[53][8])
  );
  fa fa_53_9 (
    .a(inter[53][8]),
    .b(partial_products[31][22]),
    .c_in(carry[52][10]),
    .sum(product[53]),
    .c_out(carry[53][9])
  );

  fa fa_54_0 (
    .a(carry[53][0]),
    .b(partial_products[23][31]),
    .c_in(carry[53][1]),
    .sum(inter[54][0]),
    .c_out(carry[54][0])
  );
  fa fa_54_1 (
    .a(inter[54][0]),
    .b(partial_products[24][30]),
    .c_in(carry[53][2]),
    .sum(inter[54][1]),
    .c_out(carry[54][1])
  );
  fa fa_54_2 (
    .a(inter[54][1]),
    .b(partial_products[25][29]),
    .c_in(carry[53][3]),
    .sum(inter[54][2]),
    .c_out(carry[54][2])
  );
  fa fa_54_3 (
    .a(inter[54][2]),
    .b(partial_products[26][28]),
    .c_in(carry[53][4]),
    .sum(inter[54][3]),
    .c_out(carry[54][3])
  );
  fa fa_54_4 (
    .a(inter[54][3]),
    .b(partial_products[27][27]),
    .c_in(carry[53][5]),
    .sum(inter[54][4]),
    .c_out(carry[54][4])
  );
  fa fa_54_5 (
    .a(inter[54][4]),
    .b(partial_products[28][26]),
    .c_in(carry[53][6]),
    .sum(inter[54][5]),
    .c_out(carry[54][5])
  );
  fa fa_54_6 (
    .a(inter[54][5]),
    .b(partial_products[29][25]),
    .c_in(carry[53][7]),
    .sum(inter[54][6]),
    .c_out(carry[54][6])
  );
  fa fa_54_7 (
    .a(inter[54][6]),
    .b(partial_products[30][24]),
    .c_in(carry[53][8]),
    .sum(inter[54][7]),
    .c_out(carry[54][7])
  );
  fa fa_54_8 (
    .a(inter[54][7]),
    .b(partial_products[31][23]),
    .c_in(carry[53][9]),
    .sum(product[54]),
    .c_out(carry[54][8])
  );

  fa fa_55_0 (
    .a(carry[54][0]),
    .b(partial_products[24][31]),
    .c_in(carry[54][1]),
    .sum(inter[55][0]),
    .c_out(carry[55][0])
  );
  fa fa_55_1 (
    .a(inter[55][0]),
    .b(partial_products[25][30]),
    .c_in(carry[54][2]),
    .sum(inter[55][1]),
    .c_out(carry[55][1])
  );
  fa fa_55_2 (
    .a(inter[55][1]),
    .b(partial_products[26][29]),
    .c_in(carry[54][3]),
    .sum(inter[55][2]),
    .c_out(carry[55][2])
  );
  fa fa_55_3 (
    .a(inter[55][2]),
    .b(partial_products[27][28]),
    .c_in(carry[54][4]),
    .sum(inter[55][3]),
    .c_out(carry[55][3])
  );
  fa fa_55_4 (
    .a(inter[55][3]),
    .b(partial_products[28][27]),
    .c_in(carry[54][5]),
    .sum(inter[55][4]),
    .c_out(carry[55][4])
  );
  fa fa_55_5 (
    .a(inter[55][4]),
    .b(partial_products[29][26]),
    .c_in(carry[54][6]),
    .sum(inter[55][5]),
    .c_out(carry[55][5])
  );
  fa fa_55_6 (
    .a(inter[55][5]),
    .b(partial_products[30][25]),
    .c_in(carry[54][7]),
    .sum(inter[55][6]),
    .c_out(carry[55][6])
  );
  fa fa_55_7 (
    .a(inter[55][6]),
    .b(partial_products[31][24]),
    .c_in(carry[54][8]),
    .sum(product[55]),
    .c_out(carry[55][7])
  );

  fa fa_56_0 (
    .a(carry[55][0]),
    .b(partial_products[25][31]),
    .c_in(carry[55][1]),
    .sum(inter[56][0]),
    .c_out(carry[56][0])
  );
  fa fa_56_1 (
    .a(inter[56][0]),
    .b(partial_products[26][30]),
    .c_in(carry[55][2]),
    .sum(inter[56][1]),
    .c_out(carry[56][1])
  );
  fa fa_56_2 (
    .a(inter[56][1]),
    .b(partial_products[27][29]),
    .c_in(carry[55][3]),
    .sum(inter[56][2]),
    .c_out(carry[56][2])
  );
  fa fa_56_3 (
    .a(inter[56][2]),
    .b(partial_products[28][28]),
    .c_in(carry[55][4]),
    .sum(inter[56][3]),
    .c_out(carry[56][3])
  );
  fa fa_56_4 (
    .a(inter[56][3]),
    .b(partial_products[29][27]),
    .c_in(carry[55][5]),
    .sum(inter[56][4]),
    .c_out(carry[56][4])
  );
  fa fa_56_5 (
    .a(inter[56][4]),
    .b(partial_products[30][26]),
    .c_in(carry[55][6]),
    .sum(inter[56][5]),
    .c_out(carry[56][5])
  );
  fa fa_56_6 (
    .a(inter[56][5]),
    .b(partial_products[31][25]),
    .c_in(carry[55][7]),
    .sum(product[56]),
    .c_out(carry[56][6])
  );

  fa fa_57_0 (
    .a(carry[56][0]),
    .b(partial_products[26][31]),
    .c_in(carry[56][1]),
    .sum(inter[57][0]),
    .c_out(carry[57][0])
  );
  fa fa_57_1 (
    .a(inter[57][0]),
    .b(partial_products[27][30]),
    .c_in(carry[56][2]),
    .sum(inter[57][1]),
    .c_out(carry[57][1])
  );
  fa fa_57_2 (
    .a(inter[57][1]),
    .b(partial_products[28][29]),
    .c_in(carry[56][3]),
    .sum(inter[57][2]),
    .c_out(carry[57][2])
  );
  fa fa_57_3 (
    .a(inter[57][2]),
    .b(partial_products[29][28]),
    .c_in(carry[56][4]),
    .sum(inter[57][3]),
    .c_out(carry[57][3])
  );
  fa fa_57_4 (
    .a(inter[57][3]),
    .b(partial_products[30][27]),
    .c_in(carry[56][5]),
    .sum(inter[57][4]),
    .c_out(carry[57][4])
  );
  fa fa_57_5 (
    .a(inter[57][4]),
    .b(partial_products[31][26]),
    .c_in(carry[56][6]),
    .sum(product[57]),
    .c_out(carry[57][5])
  );

  fa fa_58_0 (
    .a(carry[57][0]),
    .b(partial_products[27][31]),
    .c_in(carry[57][1]),
    .sum(inter[58][0]),
    .c_out(carry[58][0])
  );
  fa fa_58_1 (
    .a(inter[58][0]),
    .b(partial_products[28][30]),
    .c_in(carry[57][2]),
    .sum(inter[58][1]),
    .c_out(carry[58][1])
  );
  fa fa_58_2 (
    .a(inter[58][1]),
    .b(partial_products[29][29]),
    .c_in(carry[57][3]),
    .sum(inter[58][2]),
    .c_out(carry[58][2])
  );
  fa fa_58_3 (
    .a(inter[58][2]),
    .b(partial_products[30][28]),
    .c_in(carry[57][4]),
    .sum(inter[58][3]),
    .c_out(carry[58][3])
  );
  fa fa_58_4 (
    .a(inter[58][3]),
    .b(partial_products[31][27]),
    .c_in(carry[57][5]),
    .sum(product[58]),
    .c_out(carry[58][4])
  );

  fa fa_59_0 (
    .a(carry[58][0]),
    .b(partial_products[28][31]),
    .c_in(carry[58][1]),
    .sum(inter[59][0]),
    .c_out(carry[59][0])
  );
  fa fa_59_1 (
    .a(inter[59][0]),
    .b(partial_products[29][30]),
    .c_in(carry[58][2]),
    .sum(inter[59][1]),
    .c_out(carry[59][1])
  );
  fa fa_59_2 (
    .a(inter[59][1]),
    .b(partial_products[30][29]),
    .c_in(carry[58][3]),
    .sum(inter[59][2]),
    .c_out(carry[59][2])
  );
  fa fa_59_3 (
    .a(inter[59][2]),
    .b(partial_products[31][28]),
    .c_in(carry[58][4]),
    .sum(product[59]),
    .c_out(carry[59][3])
  );

  fa fa_60_0 (
    .a(carry[59][0]),
    .b(partial_products[29][31]),
    .c_in(carry[59][1]),
    .sum(inter[60][0]),
    .c_out(carry[60][0])
  );
  fa fa_60_1 (
    .a(inter[60][0]),
    .b(partial_products[30][30]),
    .c_in(carry[59][2]),
    .sum(inter[60][1]),
    .c_out(carry[60][1])
  );
  fa fa_60_2 (
    .a(inter[60][1]),
    .b(partial_products[31][29]),
    .c_in(carry[59][3]),
    .sum(product[60]),
    .c_out(carry[60][2])
  );

  fa fa_61_0 (
    .a(carry[60][0]),
    .b(partial_products[30][31]),
    .c_in(carry[60][1]),
    .sum(inter[61][0]),
    .c_out(carry[61][0])
  );
  fa fa_61_1 (
    .a(inter[61][0]),
    .b(partial_products[31][30]),
    .c_in(carry[60][2]),
    .sum(product[61]),
    .c_out(carry[61][1])
  );

  fa fa_62_0 (
    .a(carry[61][0]),
    .b(partial_products[31][31]),
    .c_in(carry[61][1]),
    .sum(product[62]),
    .c_out(product[63])
  );

endmodule

module ha (
    input logic a,
    input logic b,
    output logic sum,
    output logic c_out
);
  assign sum = a ^ b;
  assign c_out = a & b;
endmodule

module fa (
    input logic a,
    input logic b,
    input logic c_in,
    output logic sum,
    output logic c_out
);
  assign sum = a ^ b ^ c_in;
  assign c_out = (a & b) | ((a ^ b) & c_in);
endmodule

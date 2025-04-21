`timescale 1ns / 1ps

module addr(
    input [63:0] a,
    input [63:0] b,
    output reg [63:0] out);

always @ (*)
    out <= a + b;
endmodule
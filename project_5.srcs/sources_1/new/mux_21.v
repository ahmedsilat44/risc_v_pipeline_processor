`timescale 1ns / 1ps

module mux_21
(
    input [63:0] a, b,
    input sel,
    output [63:0] dataOut   
);

assign dataOut = sel ? a : b;


endmodule // 

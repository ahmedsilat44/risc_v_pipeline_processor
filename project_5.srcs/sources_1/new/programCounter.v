`timescale 1ns / 1ps

module programCounter(
    input clk, reset,
    input [63:0] PC_In,
    output reg [63:0] PC_Out);

always @ (posedge clk)
begin
if (reset == 1'b1)
    PC_Out <= 64'b0;
else 
    begin
    PC_Out <= PC_In;
    end
end
endmodule

`timescale 1ns / 1ps

module IFID(
input clk, reset, 
input [31:0] Instruction, 
input [63:0] pcOut,
output reg [31:0] IFID_Instruction,
output reg [63:0] IFID_pcOut
); 
 

always @ (posedge clk) begin
    case (reset)
        1'b1: // reset
            begin
            IFID_Instruction <= 0;
            IFID_pcOut <= 0;
            end
        1'b0: // setting values
            begin
            IFID_Instruction <= Instruction;
            IFID_pcOut <= pcOut;
            end
    endcase
end
endmodule
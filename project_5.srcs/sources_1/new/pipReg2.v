`timescale 1ns / 1ps

module IDEX
(
input clk, reset, RegWrite, MemRead, MemToReg, MemWrite, Branch, ALUSrc,
input [1:0] ALUOp,
input [63:0] IFID_pcOut, readData1, readData2, immData, 
input [3:0] Funct, 
input [4:0] rs1, rs2, rd,
output reg IDEX_regWrite, IDEX_memRead, IDEX_memToReg, IDEX_memWrite, IDEX_Branch, IDEX_ALUSrc, 
output reg [1:0] IDEX_ALUOp,
output reg [63:0] IDEX_pcOut, IDEX_readData1, IDEX_readData2, IDEX_immData,
output reg [3:0] IDEX_Funct,
output reg [4:0] IDEX_rs1, IDEX_rs2, IDEX_rd
); 

always @(posedge clk) begin
    case (reset)
        1'b1: // reset 
        begin
            IDEX_regWrite <= 0;
            IDEX_memRead <= 0;
            IDEX_memToReg <= 0;
            IDEX_memWrite <= 0;
            IDEX_Branch <= 0;
            IDEX_ALUSrc <= 0;
            IDEX_ALUOp <= 0; 
            IDEX_pcOut <= 0;
            IDEX_readData1 <= 0;
            IDEX_readData2 <= 0;
            IDEX_immData <= 0;
            IDEX_Funct <= 0; 
            IDEX_rs1 <= 0; 
            IDEX_rs2 <= 0; 
            IDEX_rd <= 0; 
        end
        
        1'b0: // setting values
        begin
            IDEX_regWrite <= RegWrite;
            IDEX_memRead <= MemRead;
            IDEX_memToReg <= MemToReg;
            IDEX_memWrite <= MemWrite;
            IDEX_Branch <= Branch;
            IDEX_ALUSrc <= ALUSrc;
            IDEX_ALUOp <= ALUOp;
            IDEX_pcOut <= IFID_pcOut;
            IDEX_readData1 <= readData1;
            IDEX_readData2 <= readData2;
            IDEX_immData <= immData;
            IDEX_Funct <= Funct;
            IDEX_rs1 <= rs1;
            IDEX_rs2 <= rs2;
            IDEX_rd <= rd;
        end     
    endcase 
      
end
endmodule
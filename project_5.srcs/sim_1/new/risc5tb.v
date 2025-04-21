`timescale 1ns / 1ps

module tbSingle();

    reg clk; 
    reg reset;
    wire [63:0] pcIn, pcOut;
    wire [4:0] rs1, rs2, rd;
    wire [63:0] readData, readData1, readData2, writeData, immData, aluResult; 
    wire [63:0] immLeftShift, dataOut, out1, out2;
    wire [31:0] Instruction;
    wire [6:0] opcode, func7; 
    wire [2:0] func3;
    wire [3:0] Operation, Funct;
    wire [1:0] ALUOp;
    wire MemRead, MemWrite, MemtoReg, RegWrite, ALUSrc, Zero, Branch, BranchSelect; 
    wire [63:0] num1, num2, num3, num4, num5, num6, num7;


SCP scp(clk, reset, pcIn, pcOut, rs1, rs2, rd, readData, readData1, 
    readData2, writeData, immData, aluResult, immLeftShift, dataOut, out1, 
    out2, Instruction, opcode, func7, func3, Operation, Funct, ALUOp, MemRead, 
    MemWrite, MemtoReg, RegWrite, ALUSrc, Zero, Branch, BranchSelect, 
    num1, num2, num3, num4, num5, num6, num7);

initial
begin
reset <= 1; #1; reset <= 0;
end


always
begin
clk <= 1; #1.25; clk <= 0; #1.25;
end
endmodule
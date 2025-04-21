`timescale 1ns / 1ps

module tbPPNF();
//reg clk, reset;
//wire [63:0] PC_in, PC_out, ReadData, ReadData1, ReadData2, WriteData, ImmData, ALU_Result, MEM_WB_ALU_Result;
//wire MEM_WB_MemtoReg;
//wire [31:0] Instruction;
//wire [6:0] opcode, func7;
//wire [2:0] func3;
//wire [4:0] RS1, RS2, RD;
//wire [3:0] Operation, Funct;
//wire [1:0] ALUOp;
//wire RegWrite, MemRead, MemWrite, MemtoReg, ALUSrc, Zero, Branch, BranchSelect;
//wire [63:0] dm1, dm2, dm3, dm4, dm5;
//wire [63:0] reg1, reg2, reg3;
 
//RISC_V_Pipelined RP(clk, reset,PC_in, PC_out, ReadData, ReadData1, ReadData2, WriteData, ImmData,
//ALU_Result,Instruction,opcode, func7,func3,RS1, RS2, RD,Operation, Funct,ALUOp,RegWrite, MemRead,
//MemWrite, MemtoReg, ALUSrc, Zero, Branch, BranchSelect, dm1, dm2, dm3, dm4, dm5,reg1,reg2,reg3);

    reg clk; 
    reg reset;
    wire [63:0] pcIn, pcOut;
    wire [4:0] rs1, rs2, rd;
    wire [63:0] readData, readData1, readData2, writeData, immData, aluResult; 
    wire [31:0] Instruction;
    wire [6:0] opcode, func7; 
    wire [2:0] func3;
    wire [3:0] Operation, Funct;
    wire [1:0] ALUOp;
    wire MemRead, MemWrite, MemtoReg, RegWrite, ALUSrc, Zero, Branch, BranchSelect;
    wire MEMWB_memToReg;
    wire [63:0] num1;
    wire [63:0] MEMWB_aluResult;
    wire [63:0] reg1, reg2;


PPNF ppnf(clk, 
    reset, pcIn, pcOut,rs1, rs2, rd, readData, readData1, readData2, writeData, 
    immData, aluResult, Instruction, opcode, func7, func3, Operation,Funct,
    ALUOp, MemRead, MemWrite, MemtoReg, RegWrite, ALUSrc, Zero, Branch, 
    BranchSelect, MEMWB_memToReg, num1,MEMWB_aluResult,reg1, reg2);

initial begin
    reset <= 1; #2; reset <= 0;
end

always begin
    clk <= 1; 
    #1; clk <= 0; 
    #1;
end
endmodule

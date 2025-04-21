`timescale 1ns / 1ps

module SCP(
    input clk, 
    input reset,
    output [63:0] pcIn, pcOut,
    output [4:0] rs1, rs2, rd,
    output [63:0] readData, readData1, readData2, writeData, immData, aluResult, 
    output [63:0] immLeftShift, dataOut, out1, out2,
    output [31:0] Instruction,
    output [6:0] opcode, func7, 
    output [2:0] func3,
    output [3:0] Operation, Funct,
    output [1:0] ALUOp,
    output MemRead, MemWrite, MemtoReg, RegWrite, ALUSrc, Zero, Branch, BranchSelect, 
    output [63:0] num1, num2, num3, num4, num5, num6, num7
    );
    
// IF
programCounter pc(clk, reset, pcIn, pcOut);
mux_21 branchMux(out2, out1, (Branch & BranchSelect), pcIn);
addr constAdder(pcOut, 64'd4, out1);
instrMem IM(pcOut, Instruction); 
    
// ID    
instrParse ip(Instruction, opcode, rd, func3, rs1, rs2, func7);
immGen ig(Instruction, immData);
controlUnit cu(opcode, ALUOp, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite);
regFile rf(writeData, rs1, rs2, rd, RegWrite, clk, reset, readData1, readData2);
branchUnit bu(func3, readData1, readData2, BranchSelect);

// EX
assign immLeftShift = immData << 1;
addr branchAddr(pcOut, immLeftShift, out2); 
mux_21 aluSrcMux(immData,readData2, ALUSrc, dataOut);
assign Funct = {Instruction[30],Instruction[14:12]};
aluControl aluc(ALUOp, Funct, Operation);
wire greater;
alu64 alu(readData1, dataOut, Operation, aluResult, Zero, greater);
    
// MEM
dataMem dm(aluResult, readData2, clk, MemWrite, MemRead, readData, num1, num2, num3, num4, num5, num6, num7);
    
// WB
mux_21 wbMux(readData, aluResult, MemtoReg, writeData);
    
endmodule
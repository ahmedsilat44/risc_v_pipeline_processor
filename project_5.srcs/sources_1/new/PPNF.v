`timescale 1ns / 1ps

module PPNF(
    input clk, 
    input reset,
    output wire [63:0] pcIn, pcOut,
    output wire [4:0] rs1, rs2, rd,
    output wire [63:0] readData, readData1, readData2, writeData, immData, aluResult, 
    output wire [31:0] Instruction,
    output wire [6:0] opcode, func7, 
    output wire [2:0] func3,
    output wire [3:0] Operation, Funct,
    output wire [1:0] ALUOp,
    output wire MemRead, MemWrite, MemtoReg, RegWrite, ALUSrc, Zero, Branch, BranchSelect,
    output wire MEMWB_memToReg,
    output wire [63:0] num1,
    output wire [63:0] MEMWB_aluResult,
    output wire [63:0] reg1, reg2 
    );
    
    wire [63:0] immLeftShift, dataOut, out1, out2;
    wire [63:0] num2, num3, num4, num5, num6, num7;
    
    wire [63:0] IFID_pcOut;
    wire [31:0] IFID_Instruction;
    wire IDEX_regWrite, IDEX_memRead, IDEX_memToReg, IDEX_memWrite, IDEX_Branch, IDEX_ALUSrc;
    wire [1:0] IDEX_ALUOp; 
    wire [63:0] IDEX_pcOut, IDEX_readData1, IDEX_readData2, IDEX_immData;
    wire [3:0] IDEX_Funct; 
    wire [4:0] IDEX_rs1, IDEX_rs2, IDEX_rd ;
    wire  EXMEM_regWrite, EXMEM_memRead, EXMEM_memToReg, EXMEM_memWrite, EXMEM_Branch, EXMEM_Zero; 
    wire [4:0] EXMEM_rd; 
    wire [63:0] EXMEM_addrOut, EXMEM_aluResult, EXMEM_readData2;
    wire MEMWB_regWrite; 
    wire [4:0] MEMWB_rd;
    wire [63:0] MEMWB_readData;
    
    // IF
programCounter pc(clk, reset, pcIn, pcOut);
mux_21 branchMux(out2, out1, (Branch & BranchSelect), pcIn);
addr constAdder(pcOut, 64'd4, out1);
instrMemPPNF IM(pcOut, Instruction);

IFID pipReg1(clk, reset, Instruction, pcOut , IFID_Instruction, IFID_pcOut );
    
// ID Stage
assign Funct = {IFID_Instruction[30],IFID_Instruction[14:12]};
instrParse ip(IFID_Instruction, opcode, rd, func3, rs1, rs2, func7);
immGen ig(IFID_Instruction, immData);
controlUnit cu(opcode, ALUOp, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite);
regFilePPNF rf(writeData, rs1, rs2, MEMWB_rd, MEMWB_regWrite, clk, reset, readData1, readData2,reg1,reg2);
branchUnit bu(func3, readData1, readData2, BranchSelect);

IDEX pipReg2(clk, reset, 
        RegWrite, MemRead, MemtoReg, MemWrite, Branch, ALUSrc, ALUOp, // control signals
        IFID_pcOut, readData1, readData2, immData, Funct, rs1, rs2, rd,  // inputs
        IDEX_regWrite, IDEX_memRead, IDEX_memToReg, IDEX_memWrite, IDEX_Branch,  IDEX_ALUSrc,IDEX_ALUOp, // control signals
        IDEX_pcOut, IDEX_readData1, IDEX_readData2, IDEX_immData, IDEX_Funct, IDEX_rs1, IDEX_rs2, IDEX_rd 
        ); // outputs
                
// EXE Stage
assign immLeftShift = IDEX_immData << 1;
addr branchAddr(IDEX_pcOut, immLeftShift, out2); 
mux_21 aluSrcMux(IDEX_immData, IDEX_readData2, IDEX_ALUSrc, dataOut);
aluControl aluc(IDEX_ALUOp, IDEX_Funct, Operation);
wire greater;
alu64 alu(IDEX_readData1, dataOut, Operation, aluResult, Zero, greater);

EXMEM pipReg3(clk, reset, 
        IDEX_regWrite, IDEX_memRead, IDEX_memToReg, IDEX_memWrite, IDEX_Branch, // input control signals
        out2, aluResult, BranchSelect, IDEX_readData2, IDEX_rd,  // inaputs
        // BranchSelect instead of Zero 
        EXMEM_regWrite, EXMEM_memRead, EXMEM_memToReg, EXMEM_memWrite, EXMEM_Branch, // output control signals
        EXMEM_Zero, EXMEM_rd, EXMEM_addrOut, EXMEM_aluResult, EXMEM_readData2 // outputs
        );

// MEM Stage
dataMem DM(EXMEM_aluResult, EXMEM_readData2, clk, EXMEM_memWrite, 
EXMEM_memRead, readData, num1, num2, num3, num4, num5, num6, num7);

MEMWB pipReg4(clk, reset, 
        EXMEM_regWrite, EXMEM_memToReg, // input control signals
        EXMEM_rd, readData, EXMEM_aluResult,  // inputs
        MEMWB_regWrite, MEMWB_memToReg, // output control signals
        MEMWB_rd, MEMWB_readData, MEMWB_aluResult  // outputs
        );

// WB
mux_21 wb(MEMWB_readData, MEMWB_aluResult, MEMWB_memToReg, writeData);
    
endmodule

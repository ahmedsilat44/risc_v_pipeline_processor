`timescale 1ns / 1ps



module PPFwd(
    input clk, reset,
    output[63:0] pcOut,
    output [31:0] Instruction,
    output [63:0] num1,num2,num3,num4,num5,num6,num7,
    output wire switch_branch
    );
    
    wire [1:0] forwardA, forwardB;
    wire [6:0] opcode; 
    wire[4:0] rd;
    wire [2:0] funct3;
    wire [6:0] funct7;
    wire [4:0] rs1, rs2;
    wire Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite;
    wire greater;
    wire [1:0] ALUOp;
    wire [63:0] writeData;
    wire [63:0] pcIn;
    wire [3:0] ALU_C_Operation;
    wire [63:0] ReadData1, ReadData2;
    wire [63:0] immData;
    
wire [63:0] fixed_4 = 64'd4;
    wire [63:0] out1;

wire [63:0] alu_mux;

wire [63:0] alu_result;
wire zero;

wire [63:0] imm_to_adder;
wire [63:0] imm_adder_to_mux;

wire [63:0] DM_Read_Data;


wire PCWrite;

//IF_ID WIRES
wire [63:0] IFID_pcAddr;
wire [31:0] IFID_Instruction;
wire IFID_Write;

//ID_EX WIRES

wire IDEX_Branch, IDEX_MemRead, IDEX_MemtoReg;
wire IDEX_MemWrite, IDEX_ALUSrc, IDEX_RegWrite;

wire [63:0] IDEX_pcAddr, IDEX_ReadData1, IDEX_ReadData2, IDEX_immData;
wire [3:0] IDEX_funct_in;
wire [4:0] IDEX_rd, IDEX_rs1, IDEX_rs2;
wire [1:0] IDEX_ALUOp;

assign immLeftShift = IDEX_immData<< 1;


//EX_MEM WIRES
wire EXMEM_Branch, EXMEM_MemRead, EXMEM_MemtoReg;
wire EXMEM_MemWrite, EXMEM_RegWrite; 
wire EXMEM_zero, EXMEM_greater;
wire [63:0] EX_MEM_PC_plus_imm, EX_MEM_alu_result, EX_MEM_ReadData2;
wire [3:0] EX_MEM_funct_in;
wire [4:0] EX_MEM_rd;
wire NOP_Check;

//MEM_WB WIRES
wire MEM_WB_MemtoReg, MEM_WB_RegWrite;
wire [63:0] MEM_WB_DM_Read_Data, MEM_WB_alu_result;
wire [4:0] MEM_WB_rd;


mux_21 pcsrcmux(EX_MEM_PC_plus_imm, out1, switch_branch, pcIn);

pcFwd PC (clk, reset,PCWrite, pcIn,pcOut);

addr pcadder(pcOut, fixed_4, out1);

instrMem insmem(pcOut, Instruction);


//IF_ID STAGE
IFID_Fwd IFIDreg(clk, NOP_Check, IFID_Write, pcOut,Instruction, IFID_pcAddr, IFID_Instruction);

wire controlMuxSel;

hazardDetection hazarddetectionunit(IDEX_rd, rs1, rs2, IDEX_MemRead, controlMuxSel,
                                       IFID_Write, PCWrite);
    


instrParse ip(IFID_Instruction, opcode, rd, funct3, rs1, rs2, funct7);

wire [3:0] funct_in;
//makes a ALU OP
assign funct_in = {IFID_Instruction[30],IFID_Instruction[14:12]};

controlUnit cu(opcode, ALUOp, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite);
 

regFile regFile(writeData, rs1, rs2, MEM_WB_rd, MEM_WB_RegWrite, clk, reset, 
                            ReadData1, ReadData2);


immGen ig(IFID_Instruction, immData);

wire IDEX_MemtoReg, IDEX_RegWrite, IDEX_Branch, IDEX_MemWrite, IDEX_MemRead, IDEX_ALUSrc;
wire [1:0] IDEX_ALUop;

//if a hazard is detected then stop taking in instructions 
assign ID_MemtoReg = controlMuxSel ? MemtoReg : 0;
assign ID_RegWrite = controlMuxSel ? RegWrite : 0;
assign ID_Branch = controlMuxSel ? Branch : 0;
assign ID_MemWrite = controlMuxSel ? MemWrite : 0;
assign ID_MemRead = controlMuxSel ? MemRead : 0;
assign ID_ALUSrc = controlMuxSel ? ALUSrc : 0;
assign ID_ALUop = controlMuxSel ? ALUOp : 2'b00;


// ID/EX STAGE
IDEX_Fwd IDEXreg(clk, NOP_Check, IFID_pcAddr, ReadData1, 
            ReadData2, immData, funct_in, rd, rs1, rs2, ID_MemtoReg, ID_RegWrite, 
            ID_Branch, ID_MemWrite, ID_MemRead, ID_ALUSrc, ID_ALUop,
            IDEX_pcAddr, IDEX_ReadData1, IDEX_ReadData2, IDEX_immData, IDEX_funct_in, 
            IDEX_rd, IDEX_rs1, IDEX_rs2, IDEX_MemtoReg,
            IDEX_RegWrite, IDEX_Branch, IDEX_MemWrite, 
            IDEX_MemRead, IDEX_ALUSrc, IDEX_ALUOp);

aluControl alucontrol(IDEX_ALUOp, IDEX_funct_in, ALU_C_Operation);

wire [63:0] triplemux_to_a, triplemux_to_b;

mux_21 ALU_mux(IDEX_immData, triplemux_to_b, IDEX_ALUSrc, alu_mux);



mux_31 mux_for_a(IDEX_ReadData1, writeData, EX_MEM_alu_result, forwardA, triplemux_to_a);

mux_31 mux_for_b(IDEX_ReadData2, writeData, EX_MEM_alu_result, forwardB, triplemux_to_b);

alu64 alu(triplemux_to_a, alu_mux, ALU_C_Operation, alu_result, zero, greater);



fwdUnit fu(EX_MEM_rd, MEM_WB_rd, IDEX_rs1, IDEX_rs2, EXMEM_RegWrite, 
                        EXMEM_MemtoReg, MEM_WB_RegWrite, forwardA, forwardB);


wire [63:0] out2;

addr branchAddr(IDEX_pcAddr, immLeftShift, out2);

// EX/MEM STAGE

EXMEM_Fwd EXMEMreg(clk,NOP_Check ,IDEX_RegWrite,IDEX_MemtoReg,
                IDEX_Branch,zero,
                IDEX_MemWrite,IDEX_MemRead,greater,out2,
                alu_result,triplemux_to_b,IDEX_funct_in,
                IDEX_rd,
                EXMEM_RegWrite,EXMEM_MemtoReg,
                EXMEM_Branch,EXMEM_zero,
                EXMEM_MemWrite,
                EXMEM_MemRead,EXMEM_greater,
                EX_MEM_PC_plus_imm,
                EX_MEM_alu_result,EX_MEM_ReadData2,
                EX_MEM_funct_in,EX_MEM_rd);



branchControl branchcontrol(EXMEM_Branch, EXMEM_zero, EXMEM_greater,
                                EX_MEM_funct_in,switch_branch,NOP_Check);


dataMem dm(EX_MEM_alu_result, EX_MEM_ReadData2, clk,EXMEM_MemWrite,EXMEM_MemRead,
	DM_Read_Data, num1,num2,num3,num4,num5,num6,num7);



// MEM/WB STAGE

MEMWB_Fwd MEMWBreg(clk, EXMEM_RegWrite, EXMEM_MemtoReg, 
                DM_Read_Data, EX_MEM_alu_result, EX_MEM_rd,
                MEM_WB_RegWrite, MEM_WB_MemtoReg, 
                MEM_WB_DM_Read_Data,MEM_WB_alu_result, 
                MEM_WB_rd);


mux_21 wb(MEM_WB_DM_Read_Data, MEM_WB_alu_result, MEM_WB_MemtoReg, writeData);
    
    
endmodule

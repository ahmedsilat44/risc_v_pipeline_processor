`timescale 1ns / 1ps

module EXMEM(
input clk, reset, IDEX_regWrite, IDEX_memRead, IDEX_memToReg, IDEX_memWrite, IDEX_Branch,
input [63:0] addrOut, aluResult,
input Zero, 
input [63:0] IDEX_readData2,
input [4:0] IDEX_rd,
output reg  EXMEM_regWrite, EXMEM_memRead, EXMEM_memToReg, EXMEM_memWrite, EXMEM_Branch, EXMEM_Zero,
output reg [4:0] EXMEM_rd,
output reg [63:0] EXMEM_addrOut, EXMEM_aluResult, EXMEM_readData2
); 

always @(posedge clk) begin
        case (reset)
        1'b1: // reset 
        begin
            EXMEM_regWrite <= 0;
            EXMEM_memRead <= 0;
            EXMEM_memToReg <= 0;
            EXMEM_memWrite <= 0;
            EXMEM_Branch <= 0;
            EXMEM_Zero <= 0;
            EXMEM_rd <= 0;
            EXMEM_addrOut <= 0;
            EXMEM_aluResult <= 0;
            EXMEM_readData2 <= 0;
        end

        1'b0: // setting values
        begin
            EXMEM_regWrite <= IDEX_regWrite;
            EXMEM_memRead <= IDEX_memRead;
            EXMEM_memToReg <= IDEX_memToReg;
            EXMEM_memWrite <= IDEX_memWrite;
            EXMEM_Branch <= IDEX_Branch;
            EXMEM_Zero <= Zero;
            EXMEM_rd <= IDEX_rd;
            EXMEM_addrOut <= addrOut;
            EXMEM_aluResult <= aluResult;
            EXMEM_readData2 <= IDEX_readData2;
        end
    endcase

end
endmodule

`timescale 1ns / 1ps

module MEMWB(input clk, reset, EXMEM_regWrite, EXMEM_memToReg,
input [4:0] EXMEM_rd,
input [63:0] readData, EXMEM_aluResult,
output reg MEMWB_regWrite, MEMWB_memToReg,
output reg [4:0] MEMWB_rd,
output reg [63:0] MEMWB_readData, MEMWB_aluResult
);



  always @(posedge clk) begin

    case(reset)
          1'b1: //reset on
            begin
                MEMWB_regWrite <= 0;
                MEMWB_memToReg <= 0;
                MEMWB_readData <= 0;
                MEMWB_aluResult <= 0;
                MEMWB_rd <= 0;
            end

          1'b0: // reset off
            begin
                MEMWB_regWrite <= EXMEM_regWrite;
                MEMWB_memToReg <= EXMEM_memToReg;
                MEMWB_readData <= readData;
                MEMWB_aluResult <= EXMEM_aluResult;
                MEMWB_rd <=  EXMEM_rd;
            end
   endcase

end
endmodule
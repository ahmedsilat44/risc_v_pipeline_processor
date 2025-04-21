`timescale 1ns / 1ps

module fwdUnit(
    input [4:0] EXMEM_rd, MEMWB_rd,
    input [4:0] IDEX_rs1, IDEX_rs2,
    input EXMEM_RegWrite, EXMEM_MemtoReg,
    input MEMWB_RegWrite,
    output reg [1:0] forwardA, forwardB
);

always @(*) begin

    if (EXMEM_rd == IDEX_rs1 && EXMEM_RegWrite && EXMEM_rd != 0) 
        begin
            forwardA = 2'b10;
        end
    else if (MEMWB_RegWrite && MEMWB_rd!=0 && MEMWB_rd==IDEX_rs1 )
        begin
            forwardA = 2'b01;
        end
    else
        begin
            forwardA = 2'b00;
        end
    
    if ((EXMEM_rd == IDEX_rs2) && (EXMEM_RegWrite) && (EXMEM_rd != 0))
        begin
            forwardB = 2'b10;
        end
    
    else if (MEMWB_RegWrite && MEMWB_rd!=0 && MEMWB_rd==IDEX_rs2)
        begin
            forwardB = 2'b01;
        end
    
    else 
        begin
            forwardB = 2'b00;
        end
end
endmodule

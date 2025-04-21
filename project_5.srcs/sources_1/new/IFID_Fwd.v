`timescale 1ns / 1ps


module IFID_Fwd(
    input clk, Flush, IFID_Write,
    input [63:0] PC_addr,
    input [31:0] Instruction,
    output reg [63:0] PC_store,
    output reg [31:0] Instr_store
);

always @(posedge clk) begin
    if (Flush) begin
        PC_store = 0;
        Instr_store = 0;
    end


    else if (!IFID_Write) begin
        PC_store = PC_store;
        Instr_store = Instr_store;
    end
    else begin
    PC_store = PC_addr;
    Instr_store = Instruction;
    end
end
endmodule

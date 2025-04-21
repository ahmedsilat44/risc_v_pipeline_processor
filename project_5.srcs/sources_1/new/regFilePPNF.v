`timescale 1ns / 1ps

module regFilePPNF(
    input [63:0] writeData,
    input [4:0] rs1,
    input [4:0] rs2,
    input [4:0] rd,
    input RegWrite,
    input clk,
    input reset,
    output reg [63:0] readData1,
    output reg [63:0] readData2,
    output [63:0] reg1, reg2
    );
//    wire    [63:0] reg1, reg2, reg3;
    reg [63:0] registers [31:0];
    integer k;
    initial begin
        for (k = 0 ; k < 31 ; k = k + 1)
            registers[k] = 0;
    end
    assign reg1 = registers[5];
    assign reg2 = registers[6];
    // writing
        always @(posedge  clk) begin 
           if (RegWrite) begin
                registers[rd] <= writeData;
           end
        end
        
    // reading
    always @(*) begin
        if (reset) begin
           readData1 = 0; 
           readData2 = 0;
       end
       else begin
           // reading the register values and storing
            readData1 <= registers[rs1]; 
            readData2 <= registers[rs2];
        end
      end
endmodule

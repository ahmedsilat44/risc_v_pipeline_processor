`timescale 1ns / 1ps

module regFile
(
    input [63:0] writeData,
    input [4:0] rs1,
    input [4:0] rs2,
    input [4:0] rd,
    input regWrite,
    input clk,
    input reset,
    output reg [63:0] readData1,
    output reg [63:0] readData2);
reg [63:0] registers [31:0];
integer k;
initial begin
    for (k = 0 ; k < 31 ; k = k + 1) begin //setting all regs to 0
        registers[k] = 0;
    end
end
    
always @(*) begin // reading from reg
    if (reset == 1) begin
       readData1 = 0; 
       readData2 = 0;
   end
   else begin 
        readData1 <= registers[rs1]; 
        readData2 <= registers[rs2];
   end
end
  
always @(negedge clk) begin // writing to reg
   if (regWrite == 1) begin
        registers[rd] <= writeData;
   end
end
endmodule

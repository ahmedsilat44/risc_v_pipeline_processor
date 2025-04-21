`timescale 1ns / 1ps

module dataMem
(
    input [63:0] memAddr,
    input [63:0] WriteData,
    input clk,
    input MemWrite,
    input MemRead,
    output reg [63:0] readData,
    output [63:0] num1,
    output [63:0] num2,
    output [63:0] num3,
    output [63:0] num4,
    output [63:0] num5,
    output [63:0] num6,
    output [63:0] num7
    );
    
reg [7:0] memory [1022:0]; 
integer k;
initial begin
    for (k = 0 ; k < 1023 ; k = k + 1) begin
        memory[k] = 0;
    end
  
    memory[256] = 8'd7;
    memory[260] = 8'd6;
    memory[264] = 8'd5;
    memory[268] = 8'd4;
    memory[272] = 8'd3;
    memory[276] = 8'd2;
    memory[280] = 8'd1;
end 


assign num1 = {memory[256]};
assign num2 = {memory[260]};
assign num3 = {memory[264]};
assign num4 = {memory[268]};
assign num5 = {memory[272]};
assign num6 = {memory[272]};
assign num7 = {memory[280]};

always@ (*) begin
    if (MemRead == 1'b1) begin 
         readData[15:0] <= memory[memAddr+0];
         readData[31:16] <= memory[memAddr+1];
         readData[47:32] <= memory[memAddr+2];
         readData[63:48] <= memory[memAddr+3];

    end
end
always@ (posedge clk) begin
    if (MemWrite == 1'b1) begin 
            memory[memAddr] <= WriteData[15:0]; 
            memory[memAddr+1] <= WriteData[31:16]; 
            memory[memAddr+2] <= WriteData[47:32]; 
            memory[memAddr+3] <= WriteData[63:48]; 
    end
end
endmodule
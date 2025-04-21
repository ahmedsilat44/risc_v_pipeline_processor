`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/21/2025 10:12:43 PM
// Design Name: 
// Module Name: tbPPFwd
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tbPPFwd();

reg clk, reset;
wire [63:0] PC_to_INSTMEM;
wire [31:0] instruction;
wire [63:0] index1,index2,index3,index4,index5,index6,index7;
//wire switch_branch;
PPFwd ppfwd(
    clk,
    reset,
    PC_to_INSTMEM,
    instruction,
    index1,
    index2,
    index3, 
    index4,
    index5,
    index6,
    index7,
//    switch_branch
    );

initial 
 
 begin 
  
  clk = 1'b0; 
   
  reset = 1'b1; 
   
  #10 reset = 1'b0; 
 end 
  
  
always  
 
 #5 clk = ~clk; 

endmodule
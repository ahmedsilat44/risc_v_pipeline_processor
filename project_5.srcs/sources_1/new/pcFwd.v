`timescale 1ns / 1ps

module pcFwd(
    input clk, reset, PCWrite, 
    input [63:0] PC_In,
    output reg [63:0] PC_Out
);

reg reset_force; 

initial 
PC_Out <= 64'd0;

always @(posedge clk or posedge reset) begin
    if (reset || reset_force) begin
        PC_Out = 64'd0;
        reset_force <= 0;
        end
    else if (!PCWrite) begin 
        PC_Out = PC_Out;
    end
    else
    PC_Out = PC_In;

end

always @(negedge reset) reset_force <= 1;

endmodule

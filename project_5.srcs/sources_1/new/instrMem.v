`timescale 1ns / 1ps

module instrMem(
    input [63:0] instrAddress,
    output reg [31:0] Instruction);

reg [7:0] memory [128:0];

initial
	begin   
	
    {memory[3], memory[2], memory[1], memory[0]} = 32'h10000913; //limit set to 7
    {memory[7], memory[6], memory[5], memory[4]} = 32'h00700993;
    {memory[11], memory[10], memory[9], memory[8]} = 32'h07340663;
    {memory[15], memory[14], memory[13], memory[12]} = 32'h00000493;
    {memory[19], memory[18], memory[17], memory[16]} = 32'h00000513;
    {memory[23], memory[22], memory[21], memory[20]} = 32'hfff98313;
    {memory[27], memory[26], memory[25], memory[24]} = 32'h40830333;
    {memory[31], memory[30], memory[29], memory[28]} = 32'h04648663; //slli by 2
    {memory[35], memory[34], memory[33], memory[32]} = 32'h00249393;
    {memory[39], memory[38], memory[37], memory[36]} = 32'h012383b3;
    {memory[43], memory[42], memory[41], memory[40]} = 32'h0003a283;
    {memory[47], memory[46], memory[45], memory[44]} = 32'h00148e93; //slli by 2
    {memory[51], memory[50], memory[49], memory[48]} = 32'h002e9e13;
    {memory[55], memory[54], memory[53], memory[52]} = 32'h012e0e33;
    {memory[59], memory[58], memory[57], memory[56]} = 32'h000e2f03; //blt
    {memory[63], memory[62], memory[61], memory[60]} = 32'h005f4663;
    {memory[67], memory[66], memory[65], memory[64]} = 32'h00148493;
    {memory[71], memory[70], memory[69], memory[68]} = 32'hfc000ce3;
    {memory[75], memory[74], memory[73], memory[72]} = 32'h00028f93;
    {memory[79], memory[78], memory[77], memory[76]} = 32'h000f0293;
    {memory[83], memory[82], memory[81], memory[80]} = 32'h0053a023;
    {memory[87], memory[86], memory[85], memory[84]} = 32'h000f8f13;
    {memory[91], memory[90], memory[89], memory[88]} = 32'h01ee2023;
    {memory[95], memory[94], memory[93], memory[92]} = 32'h00100513;
    {memory[99], memory[98], memory[97], memory[96]} = 32'h00148493;
    {memory[103], memory[102], memory[101], memory[100]} = 32'hfa000ce3;
    {memory[107], memory[106], memory[105], memory[104]} = 32'h00140413;
    {memory[111], memory[110], memory[109], memory[108]} = 32'h00050463;
    {memory[115], memory[114], memory[113], memory[112]} = 32'hf8000ce3;
	
	
end

always @(instrAddress)begin
    Instruction[31:24] <= memory[instrAddress + 3];
    Instruction[23:16] <= memory[instrAddress + 2];
    Instruction[15:8] <= memory[instrAddress + 1];
    Instruction[7:0] <= memory[instrAddress];
end
endmodule
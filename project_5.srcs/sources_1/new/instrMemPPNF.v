`timescale 1ns / 1ps

module instrMemPPNF(
    input [63:0] instrAddress,
    output reg [31:0] Instruction);

reg [7:0] inst_mem [128:0];

initial
	begin   
	  {inst_mem[3], inst_mem[2], inst_mem[1], inst_mem[0]} = 32'h00728293; // 1
      {inst_mem[7], inst_mem[6], inst_mem[5], inst_mem[4]} = 32'h00000013; // 2
      {inst_mem[11], inst_mem[10], inst_mem[9], inst_mem[8]} = 32'h00000013; // 3
      {inst_mem[15], inst_mem[14], inst_mem[13], inst_mem[12]} = 32'h00000013; // 4
      {inst_mem[19], inst_mem[18], inst_mem[17], inst_mem[16]} = 32'h00000013; // 5	
      {inst_mem[23], inst_mem[22], inst_mem[21], inst_mem[20]} = 32'h10502023; // 6
      {inst_mem[27], inst_mem[26], inst_mem[25], inst_mem[24]} = 32'h00000013; // 7
      {inst_mem[31], inst_mem[30], inst_mem[29], inst_mem[28]} = 32'h00000013; // 8
      {inst_mem[35], inst_mem[34], inst_mem[33], inst_mem[32]} = 32'h00000013; // 9
      {inst_mem[39], inst_mem[38], inst_mem[37], inst_mem[36]} = 32'h00000013; // 10  0003b283	
      {inst_mem[43], inst_mem[42], inst_mem[41], inst_mem[40]} = 32'h10002303; // 11
      {inst_mem[47], inst_mem[46], inst_mem[45], inst_mem[44]} = 32'h00000013; // 12
      {inst_mem[51], inst_mem[50], inst_mem[49], inst_mem[48]} = 32'h00000013; // 13
      {inst_mem[55], inst_mem[54], inst_mem[53], inst_mem[52]} = 32'h00000013; // 14  000e3f03
      {inst_mem[59], inst_mem[58], inst_mem[57], inst_mem[56]} = 32'h00000013; // 15
      {inst_mem[63], inst_mem[62], inst_mem[61], inst_mem[60]} = 32'h00530333; // 16
      {inst_mem[67], inst_mem[66], inst_mem[65], inst_mem[64]} = 32'h00000013; // 17
      {inst_mem[71], inst_mem[70], inst_mem[69], inst_mem[68]} = 32'h00000013; // 18
      {inst_mem[75], inst_mem[74], inst_mem[73], inst_mem[72]} = 32'h00000013; // 19
      {inst_mem[79], inst_mem[78], inst_mem[77], inst_mem[76]} = 32'h00000013; // 20 0053b023
      {inst_mem[83], inst_mem[82], inst_mem[81], inst_mem[80]} = 32'h10602023; // 21
	
	
	//Working
//      {inst_mem[3], inst_mem[2], inst_mem[1], inst_mem[0]} = 32'h00700993; // 1
//      {inst_mem[7], inst_mem[6], inst_mem[5], inst_mem[4]} = 32'h07340663; // 2
//      {inst_mem[11], inst_mem[10], inst_mem[9], inst_mem[8]} = 32'h00000493; // 3
//      {inst_mem[15], inst_mem[14], inst_mem[13], inst_mem[12]} = 32'h00000513; // 4
//      {inst_mem[19], inst_mem[18], inst_mem[17], inst_mem[16]} = 32'hfff98313; // 5	
//      {inst_mem[23], inst_mem[22], inst_mem[21], inst_mem[20]} = 32'h40830333; // 6
//      {inst_mem[27], inst_mem[26], inst_mem[25], inst_mem[24]} = 32'h04648663; // 7
//      {inst_mem[31], inst_mem[30], inst_mem[29], inst_mem[28]} = 32'h00249393; // 8
//      {inst_mem[35], inst_mem[34], inst_mem[33], inst_mem[32]} = 32'h012383b3; // 9
//      {inst_mem[39], inst_mem[38], inst_mem[37], inst_mem[36]} = 32'h0003a283; // 10  0003b283	
//      {inst_mem[43], inst_mem[42], inst_mem[41], inst_mem[40]} = 32'h00148e93; // 11
//      {inst_mem[47], inst_mem[46], inst_mem[45], inst_mem[44]} = 32'h002e9e13; // 12
//      {inst_mem[51], inst_mem[50], inst_mem[49], inst_mem[48]} = 32'h012e0e33; // 13
//      {inst_mem[55], inst_mem[54], inst_mem[53], inst_mem[52]} = 32'h000e2f03; // 14  000e3f03
//      {inst_mem[59], inst_mem[58], inst_mem[57], inst_mem[56]} = 32'h005f4663; // 15
//      {inst_mem[63], inst_mem[62], inst_mem[61], inst_mem[60]} = 32'h00148493; // 16
//      {inst_mem[67], inst_mem[66], inst_mem[65], inst_mem[64]} = 32'hfc000ce3; // 17
//      {inst_mem[71], inst_mem[70], inst_mem[69], inst_mem[68]} = 32'h00028f93; // 18
//      {inst_mem[75], inst_mem[74], inst_mem[73], inst_mem[72]} = 32'h000f0293; // 19
//      {inst_mem[79], inst_mem[78], inst_mem[77], inst_mem[76]} = 32'h0053a023; // 20 0053b023
//      {inst_mem[83], inst_mem[82], inst_mem[81], inst_mem[80]} = 32'h000f8f13; // 21
//      {inst_mem[87], inst_mem[86], inst_mem[85], inst_mem[84]} = 32'h01ee2023; // 22 01ee3023
//      {inst_mem[91], inst_mem[90], inst_mem[89], inst_mem[88]} = 32'h00100513; // 23
//      {inst_mem[95], inst_mem[94], inst_mem[93], inst_mem[92]} = 32'h00148493; // 24
//      {inst_mem[99], inst_mem[98], inst_mem[97], inst_mem[96]} = 32'hfa000ce3; // 25
//      {inst_mem[103], inst_mem[102], inst_mem[101], inst_mem[100]} = 32'h00140413; // 26
//      {inst_mem[107], inst_mem[106], inst_mem[105], inst_mem[104]} = 32'h00050463; // 27
//      {inst_mem[111], inst_mem[110], inst_mem[109], inst_mem[108]} = 32'hf8000ce3; // 28

//        {inst_mem[3], inst_mem[2], inst_mem[1], inst_mem[0]} = 32'h00700993;
//        {inst_mem[7], inst_mem[6], inst_mem[5], inst_mem[4]} = 32'h07340663;
//        {inst_mem[11], inst_mem[10], inst_mem[9], inst_mem[8]} = 32'h00000493;
//        {inst_mem[15], inst_mem[14], inst_mem[13], inst_mem[12]} = 32'h00000513;
//        {inst_mem[19], inst_mem[18], inst_mem[17], inst_mem[16]} = 32'hfff98313;
//        {inst_mem[23], inst_mem[22], inst_mem[21], inst_mem[20]} = 32'h40830333;
//        {inst_mem[27], inst_mem[26], inst_mem[25], inst_mem[24]} = 32'h04648663;
//        {inst_mem[31], inst_mem[30], inst_mem[29], inst_mem[28]} = 32'h00249393;
//        {inst_mem[35], inst_mem[34], inst_mem[33], inst_mem[32]} = 32'h012383b3;
//        {inst_mem[39], inst_mem[38], inst_mem[37], inst_mem[36]} = 32'h0003a283;
//        {inst_mem[43], inst_mem[42], inst_mem[41], inst_mem[40]} = 32'h00148e93;
//        {inst_mem[47], inst_mem[46], inst_mem[45], inst_mem[44]} = 32'h002e9e13;
//        {inst_mem[51], inst_mem[50], inst_mem[49], inst_mem[48]} = 32'h012e0e33;
//        {inst_mem[55], inst_mem[54], inst_mem[53], inst_mem[52]} = 32'h000e2f03;
//        {inst_mem[59], inst_mem[58], inst_mem[57], inst_mem[56]} = 32'h005f4663;
//        {inst_mem[63], inst_mem[62], inst_mem[61], inst_mem[60]} = 32'h00148493;
//        {inst_mem[67], inst_mem[66], inst_mem[65], inst_mem[64]} = 32'hfc000ce3;
//        {inst_mem[71], inst_mem[70], inst_mem[69], inst_mem[68]} = 32'h00028f93;
//        {inst_mem[75], inst_mem[74], inst_mem[73], inst_mem[72]} = 32'h000f0293;
//        {inst_mem[79], inst_mem[78], inst_mem[77], inst_mem[76]} = 32'h0053a023;
//        {inst_mem[83], inst_mem[82], inst_mem[81], inst_mem[80]} = 32'h000f8f13;
//        {inst_mem[87], inst_mem[86], inst_mem[85], inst_mem[84]} = 32'h01ee2023;
//        {inst_mem[91], inst_mem[90], inst_mem[89], inst_mem[88]} = 32'h00100513;
//        {inst_mem[95], inst_mem[94], inst_mem[93], inst_mem[92]} = 32'h00148493;
//        {inst_mem[99], inst_mem[98], inst_mem[97], inst_mem[96]} = 32'hfa000ce3;
//        {inst_mem[103], inst_mem[102], inst_mem[101], inst_mem[100]} = 32'h00140413;
//        {inst_mem[107], inst_mem[106], inst_mem[105], inst_mem[104]} = 32'h00050463;
//        {inst_mem[111], inst_mem[110], inst_mem[109], inst_mem[108]} = 32'hf8000ce3;
end

always @(instrAddress)begin
    Instruction[31:24] <= inst_mem[instrAddress + 3];
    Instruction[23:16] <= inst_mem[instrAddress + 2];
    Instruction[15:8] <= inst_mem[instrAddress + 1];
    Instruction[7:0] <= inst_mem[instrAddress];
end
endmodule

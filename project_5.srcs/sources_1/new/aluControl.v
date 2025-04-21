`timescale 1ns / 1ps

module aluControl
(ALUOp, Funct, Operation);

input [1:0] ALUOp;
input [3:0] Funct;
output reg [3:0] Operation;

always@ (*)
begin
    case (ALUOp)
        2'b00: 
            begin
            case (Funct[2:0])
                3'b001 : 
                    Operation = 4'b0111; // slli 
                default: 
                   Operation = 4'b0010; // sd n ld 
            endcase
            end
        2'b01: // SB Type
            begin
                case ({Funct[2:0]})
                    3'b000: 
                        Operation = 4'b0110; //BEQ
                    3'b001: 
                        Operation = 4'b0110; //BNE
                    3'b101: 
                        Operation = 4'b0110; //BGE
                    3'b100: 
                        Operation = 4'b0110; //BLT
                endcase
                
                 
            end
        2'b10: // R Type
            begin
                case (Funct)
                    4'b0000:
                        Operation = 4'b0010; // add
                    4'b1000:
                        Operation = 4'b0110; // sub
                    4'b0111:
                        Operation = 4'b0000; // and
                    4'b0110:
                        Operation = 4'b0001; // or
                 endcase
            end
    endcase
end
endmodule

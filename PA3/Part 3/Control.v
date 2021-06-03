// I-type sub
`define I_type_sub 2'b00
// I-type add  
`define I_type_add 2'b01
module Control(
    input   [5:0]   OpCode,
    output reg          RegWrite,
    output reg  [1:0]   ALUOp,
    output reg          RegDst,
    output reg          ALUSrc,
    output reg          MemWrite, // write memory or not.
    output reg          MemRead,
    output reg          MemtoReg 
);

always@(OpCode)
    begin
        case (OpCode)
            6'd 4:  
                begin
                    RegWrite =  1'b 1; // R format.
                    ALUOp = 2'b 10;
                    RegDst = 1; // R format.
                    ALUSrc = 0;
                    MemWrite = 0;
                    MemRead = 0;
                    MemtoReg = 0;
                end
            // I format.
            6'd 12: // addiu
                begin
                    RegWrite = 1'b 1;
                    ALUOp = `I_type_add;
                    RegDst = 0; // I format -> write into Rt
                    ALUSrc = 1;
                    MemWrite = 0;
                    MemRead = 0;
                    MemtoReg = 0;
                end
            6'd 13: // subiu
                begin
                    RegWrite = 1'b 1;
                    ALUOp = `I_type_sub;
                    RegDst = 0; // I format -> write into Rt
                    ALUSrc = 1;
                    MemWrite=0;
                    MemRead = 0;
                    MemtoReg = 0;
                end
            6'd 16: // sw
                begin
                    RegWrite = 1'b 0;
                    ALUOp = `I_type_add;
                    RegDst = 0; // I format -> write into Rt
                    ALUSrc = 1;
                    MemWrite = 1;
                    MemRead = 0;
                    MemtoReg = 0; // Since the SW would not read the value from memory.
                end
            6'd 17: // lw
                begin
                    RegWrite = 1'b 1;
                    ALUOp = `I_type_add;
                    RegDst = 0; // I format -> write into Rt
                    ALUSrc = 1;
                    MemWrite = 0;
                    MemRead = 1;
                    MemtoReg= 1;
                end
            default:
                begin
                    MemWrite = 0;
                    RegWrite = 0;
                end
        endcase
    
    end

endmodule
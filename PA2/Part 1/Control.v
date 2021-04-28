module Control(
    input   [5:0]   OpCode,
    output reg          RegWrite,
    output reg  [1:0]   ALUOp
);

always@(OpCode)
    begin
        case (OpCode)
            6'd 4:  
                begin
                    RegWrite =  1'b 1; // R format.
                    ALUOp = 2'b10;
                end
            default:
                begin
                    RegWrite = 0; // no this opcode.
                    ALUOp = 2'b00;
                end
        endcase
    
    end

endmodule
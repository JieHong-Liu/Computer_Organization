module tb_Control;

    reg     [5:0] OpCode;
    wire          RegWrite;
    wire    [1:0] ALUOp;
    wire          RegDst;
    wire          ALUSrc;
    wire          MemWrite;
    wire          MemRead;
    wire          MemtoReg;

    Control controller(
        .OpCode(OpCode),
        .RegWrite(RegWrite),
        .ALUOp(ALUOp),
        .RegDst(RegDst),
        .ALUSrc(ALUSrc),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .MemtoReg(MemtoReg)
    );

    initial #40 $finish;

    initial fork
        #0 OpCode = 6'd 0; // Not working

        #5 OpCode = 6'd 4;

        #10 OpCode = 6'd 12;

        #15 OpCode = 6'd 13;

        #20 OpCode = 6'd 16;

        #25 OpCode = 6'd 17;

    join
endmodule
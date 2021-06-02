module tb_Control;

    reg     [5:0] OpCode;
    wire          RegWrite;
    wire    [1:0] ALUOp;

    Control controller(
        .OpCode(OpCode),
        .RegWrite(RegWrite),
        .ALUOp(ALUOp)
    );

    initial #20 $finish;

    initial fork
        #0 OpCode = 6'd 0;

        #5 OpCode = 6'd 4;

        #10 OpCode = 6'd 5;
    join

endmodule
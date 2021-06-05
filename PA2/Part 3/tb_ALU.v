`define addu 6'b 001001
`define subu 6'b 001010
`define AND  6'b 010001
`define sll  6'b 100001

module tb_ALU;

    reg     [31:0]  Src1;
    reg     [31:0]  Src2;
    reg     [4:0]   Shamt;
    reg     [5:0]   Funct;
    wire    [31:0]  result;
    wire            Zero;
    ALU A1(
        .Src1(Src1),
        .Src2(Src2),
        .Shamt(Shamt),
        .Funct(Funct),
        .result(result),
        .Zero(Zero)
    );

    initial #25 $finish;
    initial  fork
        #0 Src1 = 32'd 0;
        #0 Src2 = 32'd 10;
        #0 Funct = `addu;
        #0 Shamt = 5'd 5; // result shoud be a(hex).

        #5 Src1 = 32'd 10;
        #5 Src2 = 32'd 5;
        #5 Funct = `subu;

        #10 Src1 = 32'd 7;  // 0111
        #10 Src2 = 32'd 14; // 1110
        #10 Funct = `AND;

        #15 Src1 = 32'd 10; // 1010
        #15 Src2 = 32'd 100; // This value would not affect the result.
        #15 Funct = `sll; // shift left logic

        #20 Src1 = 32'd 5;
        #20 Src2 = 32'd 5;
        #20 Funct = `subu;
    join
endmodule
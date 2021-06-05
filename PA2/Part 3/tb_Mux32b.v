module tb_Mux32b;

    reg [31:0]Src1;
    reg [31:0]Src2;
    reg choose;
    wire [31:0] result;

    Mux32b mux(
    .Src1(Src1),//0
    .Src2(Src2),//1
    .choose(choose),
    .result(result)
);

    initial #20 $finish;

    initial fork
        
        #0 Src1 = 32'h 12345;
        #0 Src2 = 32'h 54321;
        #0 choose = 0;

        #10 Src1 = 32'h 6789A;
        #10 Src2 = 32'h A9876;
        #10 choose = 1;

    join



endmodule
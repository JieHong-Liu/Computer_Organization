module tb_Mux5b;

    reg [4:0]Src1;
    reg [4:0]Src2;
    reg choose;
    wire [4:0] result;

    Mux5b mux(
    .Src1(Src1),//0
    .Src2(Src2),//1
    .choose(choose),
    .result(result)
);

    initial #20 $finish;

    initial fork
        
        #0 Src1 = 5'h 7;
        #0 Src2 = 5'h 8;
        #0 choose = 0;

        #10 Src1 = 5'h 9;
        #10 Src2 = 5'h A;
        #10 choose = 1;

    join



endmodule
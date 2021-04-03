module tb_ALU();

reg [31:0]Src1;
reg [31:0]Src2;
reg [5:0]Funct;

wire [31:0]Result;
wire Carry;


ALU Arithemetic_Logical_Unit(
    .Src1(Src1),
    .Src2(Src2),
    .Funct(Funct),
    .Result(Result),
    .Carry(Carry)
);

initial #20 $finish;
initial fork
#0 Funct = 6'b 001010; // HW1 所規定的減法function code
#5 Src1 = 32'h 0; // 第一個測資們，我讓他們爆炸
#5 Src2 = 32'h FFFF_FFFF; // 因為是Src1 - Src2

#10 Funct = 6'b 001010;
#10 Src1 = 32'h 1800;
#10 Src2 = 32'h 200; // 第二個測資Result應該等於 1600h

#15 Funct = 6'b 0; // 如果funct不為MIPS所規定的function code，那Result與Carry就該為0。
#15 Src1 = 32'h 10;
#15 Src2 = 32'h 20;
join
endmodule

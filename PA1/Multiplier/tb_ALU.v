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
#0 Funct = 6'b 0; //' 一開始不動作

#5 Funct = 6'b 001001; // 依照HW1規定的ADDU function code
#5 Src1 = 32'h 0F0F_0F1F; // 第一個測資們，我讓他們爆炸
#5 Src2 = 32'h F0F0_F0F0;

#10 Funct = 6'b 0;// 如果funct不為MIPS所規定的function code，那Result與Carry就該為0。

#15 Funct = 6'b 001001;
#15 Src1 = 32'h 200;  // 第二個就用正常的測資
#15 Src2 = 32'h 1800; 

join
endmodule

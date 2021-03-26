module ALU(Src1, Src2,Result,Carry);
input [31:0]Src1;
input [31:0]Src2;
output [31:0]Result;
output Carry;

assign {Carry,Result} = Src1 + Src2;
endmodule

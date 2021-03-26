module ALU(Src1, Src2,Result,Carry,Funct);
input [31:0]Src1;
input [31:0]Src2;
input [5:0]Funct;
output reg [31:0]Result;
output reg Carry;

always@(Src1 or Src2 or Funct)
begin
    case (Funct)
    6'd1: {Carry,Result} = Src1 + Src2;
    default: // 全部都沒變
    begin
        Carry = Carry;
        Result = Result;
    end
    endcase
end

endmodule

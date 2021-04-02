module ALU(Src1, Src2,Result,Carry,Funct);
input [31:0]Src1;
input [31:0]Src2;
input [5:0]Funct;
output reg [31:0]Result;
output reg Carry;

always@(Funct)
begin
    //  I use case to implement ALU, because ALU usually do a lot of jobs.
    case (Funct[5:0])
    6'b 001001: {Carry,Result} = Src1 + Src2;
    6'b 001010: {Carry,Result} = Src1 - Src2;
    default: // 如果今天LSB==0->不用加的話，就不要加。
    begin
        Carry = 0;
        Result = 0;
    end
    endcase
end
    
endmodule

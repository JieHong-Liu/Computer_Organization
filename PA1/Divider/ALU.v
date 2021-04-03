module ALU(Src1, Src2,Result,Carry,Funct);
input [31:0]Src1;
input [31:0]Src2;
input [5:0]Funct;
output reg [31:0]Result;
output reg Carry;

always@(Src1 or Src2 or Funct)
begin
    //  I use case to implement ALU, because ALU usually do a lot of jobs.
    case (Funct[5:0])
    // 6'b 001001: {Carry,Result} = Src1 + Src2;
    6'b 001010: 
        begin
            {Carry,Result} = Src2 - Src1;
            if(Carry == 1)
                begin
                    Result = Src1;
                end
            else
                begin
                    Result = Result;
                end
        end
    default: // 如果今天Funct是別的東西就不用減。
        begin
            Carry = 0;
            Result = 0;
        end
    endcase
end
    
endmodule

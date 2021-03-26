`define SLL     6'b100001
`define AND     6'b010001
`define subu    6'b001010
`define addu    6'b001001
module ALU 
(
input [31:0] Src1,
input [31:0] Src2,
input [4:0] Shamt, 
input [5:0] Funct, 
output reg [31:0] Result, 
output Zero,
output reg Carry
);

assign Zero = !(Result);

// operation  triggered by Inputs
always@(Src1 or Src2 or Shamt or Funct)
begin
    case (Funct)
        `SLL:   {Carry,Result} <= (Src1 << Shamt);
        `AND:   {Carry,Result} <= (Src1 & Src2);
        `subu:  
            begin
                if(Src1 < Src2)
                begin
                    Carry = 1'b1;
                end
                else begin
                    Carry = Carry;
                end
                {Carry,Result} <= (Src1 - Src2);
            end
        `addu:  {Carry,Result} <= (Src1 + Src2);
        default:{Carry,Result} <= 0;
    endcase

end


endmodule

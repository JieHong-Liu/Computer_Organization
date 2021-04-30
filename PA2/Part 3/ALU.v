`define addu 6'b 001001
`define subu 6'b 001010
`define AND  6'b 010001
`define sll  6'b 100001

module ALU(
    input    [31:0]  Src1,
    input    [31:0]  Src2,
    input    [4:0]   Shamt,
    input    [5:0]   Funct,
    output  reg  [31:0]  result,
    output  reg  Zero
);

always@(Funct or Shamt or Src1 or Src2)
    begin
        case (Funct)
            `addu : result = Src1 +  Src2;
            `subu : result = Src1 -  Src2;
            `AND  : result = Src1 &  Src2;
            `sll  : result = Src1 << Shamt;
            default: result = result; // if Funct is not same as above, then the result will be the same value.
        endcase
        if(result == 0)
            Zero = 1;
        else
            Zero = 0;
    end


endmodule
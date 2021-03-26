module Product(SRL_ctrl,W_ctrl,Ready,Reset,clk,ALU_carry,ALU_Result,Multiplier_in,Product_out);
input SRL_ctrl;
input W_ctrl;
input Ready;
input Reset;
input clk;
input ALU_carry;
input [31:0]ALU_Result;
input [31:0]Multiplier_in;
output [63:0]Product_out;

always@(Multiplier_in)
begin
    if(Product_out[0] == 1)
    begin
        Product_out[63:32] += Multiplicand_out;
    end
end
endmodule

module Product(SRL_ctrl,W_ctrl,Ready,Reset,clk,ALU_carry,ALU_Result,Multiplier_in,Product_out);
input SRL_ctrl;
input W_ctrl;
input Ready;
input Reset;
input clk;
input ALU_carry;
input [31:0]ALU_Result;
input [31:0]Multiplier_in;
output reg[63:0]Product_out;
always@(W_ctrl or SRL_ctrl)
begin
    if(W_ctrl == 1)
    begin
        Product_out[31:0] = Multiplier_in[31:0];
    end
    if(SRL_ctrl == 1) // 代表LSB == 1
    begin
        Product_out[63:32] = ALU_Result[31:0];        
    end
    Product_out = Product_out >> 1;

end
endmodule

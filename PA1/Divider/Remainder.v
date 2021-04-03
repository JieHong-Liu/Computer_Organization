module Remainder(SRL_ctrl,SLL_ctrl,W_ctrl,Ready,Reset,clk,ALU_carry,ALU_result,Dividend_in,Remainder_out);

input SRL_ctrl,SLL_ctrl;
input W_ctrl;
input Ready;
input Reset;
input clk;
input ALU_carry;
input [31:0]ALU_result;
input [31:0]Dividend_in;
output reg[63:0]Remainder_out;

always@(negedge clk or posedge Reset)
begin
    if (Reset == 1 && W_ctrl == 1)
        begin
            Remainder_out = 64'b0;
            Remainder_out[31:0] = Dividend_in[31:0];
        end
    else if(SLL_ctrl == 1 && Ready == 0) 
        begin
                if(Remainder_out[63] == 0) // means that Remainder >= 0;
                    begin
                        Remainder_out = Remainder_out << 1;
                        Remainder_out[0] = 1;                        
                    end
                Product_out = Product_out >> 1; // 只有shift訊號為1的時候才可以做shift    
                Product_out[63] = ALU_carry;// shift 完以後把carry放到第63個bit
        end
    else if(Ready == 1)
        begin
            Product_out = Product_out ;
        end
    else;
end
endmodule

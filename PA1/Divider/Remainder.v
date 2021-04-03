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
                else
                    begin
                        Remainder_out = Remainder_out << 1;
                        Remainder_out[0] = 0;
                    end
        end
    else if (SRL_ctrl == 1 && Ready == 0)
        begin
            Remainder_out[63:32] = Remainder_out[63:32] << 1;
        end
    else if(Ready == 1)
        begin
            Remainder_out = Remainder_out;
        end
    else;
end
endmodule

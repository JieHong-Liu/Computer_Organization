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
reg [31:0]Remainder_reg;
reg counting; // start to count or not.
reg first;
always@(negedge clk or posedge Reset)
    begin
        if (Reset == 1 && W_ctrl == 1)
            begin
                Remainder_out = 64'b0;
                Remainder_reg[31:0] = Dividend_in[31:0];
                counting = 0;
                first = 1;
            end
        else if(SLL_ctrl == 1 && Ready == 0) 
            begin
                if(first == 1)
                    begin
                        first = 0;
                        Remainder_out[31:0] = Remainder_reg[31:0];
                    end
                if(counting == 0)
                    begin
                        if(SLL_ctrl == 1)
                            begin
                                Remainder_out = Remainder_out << 1;
                                counting = 1;
                            end                        
                    end
                else // start to count 32 times
                    begin
                        Remainder_out[63:32] = ALU_result[31:0]; 
                        /*
                            Subtract Divisor register from the
                            left half of Remainder register, and place the
                            result in the left half of Remainder register
                        */  
                        Remainder_out = Remainder_out << 1;
                        if(ALU_carry == 0) // means that Remainder >= 0;
                            begin
                                Remainder_out[0] = 1;                        
                            end
                        else
                            begin
                                Remainder_out[0] = 0;
                            end
                    end
            end
        else if (SRL_ctrl == 1 && Ready == 0)
            begin
                Remainder_out[63:32] = Remainder_out[63:32] >> 1;
            end
        else if(Ready == 1)
            begin
                Remainder_out = Remainder_out;
            end
        else;
    end
endmodule

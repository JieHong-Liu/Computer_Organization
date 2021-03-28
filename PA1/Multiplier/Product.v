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

always@(negedge clk or posedge Reset)
begin
    if (Reset == 1 && W_ctrl == 1)
        begin
            Product_out = 64'b0;
            Product_out[31:0] = Multiplier_in[31:0];
        end
    else if(SRL_ctrl == 1 && Ready == 0) 
        begin
            if(ALU_carry == 1)
                begin
                    Product_out = 64'bZ;// it means that the output is overflow and the ans must be wrong
                end
            else // ALU_Carry != 1
                begin
                    Product_out[63:32] = Product_out[63:32] + ALU_Result[31:0];
                    Product_out = Product_out >> 1; // 只有shift訊號為1的時候才可以做shift    
                end
    
        end
    else if(Ready == 1)
        begin
            Product_out = Product_out ;
        end
end
endmodule

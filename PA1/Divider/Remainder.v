module Product(SRL_ctrl,W_ctrl,Ready,Reset,clk,ALU_carry,ALU_result,Multiplier_in,Product_out);

input SRL_ctrl;
input W_ctrl;
input Ready;
input Reset;
input clk;
input ALU_carry;
input [31:0]ALU_result;
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
                if(Product_out[0] == 1) // means that LSB = 1;
                    begin
                        Product_out[63:32] =  ALU_result[31:0]; // 才要把Result放進Product_out               
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

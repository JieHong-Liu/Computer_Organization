module CompMultiplier(clk,Reset,Run,Multiplier_in,Multiplicand_in,Product_out);
input clk;
input Reset;
input Run;
input [31:0] Multiplier_in;
input [31:0] Multiplicand_in;
output [63:0]Product_out;
output Ready;
// Multiplicand
wire W_ctrl;
wire [31:0]Multiplicand_out;
// for Product
wire SRL_ctrl,Ready,Reset,ALU_carry;
wire [31:0]ALU_Result;
wire [31:0]Multiplier_in;
wire [63:0]Product_out;
Multiplicand A(Reset,W_ctrl,Multiplicand_in[31:0],Multiplicand_out[31:0]);// 被乘數
ALU Arithemetic_Logical_Unit(Product_out[63:32], Multiplicand[31:0],ALU_result[31:0],ALU_carry,ADDU_ctrl[5:0]);
Product P(SRL_ctrl,W_ctrl,Ready,Reset,clk,ALU_carry,ALU_Result,Multiplier_in[31:0],Product_out[63:0]);
Control C(Run,Reset,clk,Product_out[0],W_ctrl,ADDU_ctrl,SRL_ctrl,Ready);

endmodule

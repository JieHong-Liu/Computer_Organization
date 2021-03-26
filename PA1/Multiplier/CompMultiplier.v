module CompMultiplier(
    input clk,
    input Reset,
    input Run,
    input [31:0] Multiplier_in,
    input [31:0] Multiplicand_in,
    output [63:0]Product_out,
    output Ready
);
// Multiplicand
wire W_ctrl;
wire [31:0]Multiplicand_out;
// for Product
wire SRL_ctrl,Ready,Reset,ALU_carry;
wire [31:0]ALU_Result;
wire [31:0]Multiplier_in;
wire [63:0]Product_out;
Multiplicand A(Reset,W_ctrl,Multiplicand_in,Multiplicand_out);// 被乘數
Product B(SRL_ctrl, W_ctrl,Ready,Reset,ALU_carry,ALU_Result, Multiplier_in,Product_out);// 乘數

endmodule

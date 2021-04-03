module CompDivider(clk,Reset,Run,Divisor_in,Dividend_in,Remainder_out,Ready,ALU_result);
input clk;
input Reset;
input Run;
input [31:0] Divisor_in;
input [31:0] Dividend_in;
output [63:0]Remainder_out_reg;
output [31:0]Remainder_out;
output [31:0]Quotient_out;
output Ready;
// Divisor
wire W_ctrl;
wire [31:0]Divisor_in;
wire [31:0]Divisor_out;
// for Remainder
wire SRL_ctrl,Ready,Reset,ALU_carry;
output [31:0]ALU_result;
wire [31:0]Multiplier_in;
wire [5:0]SUBU_ctrl;
// control unit
Control controller
(
    .Run(Run),
    .Reset(Reset),
    .clk(clk),
    .MSB(Product_out[0]),
    .W_ctrl(W_ctrl),
    .SUBU_ctrl(SUBU_ctrl[5:0]),
    .SRL_ctrl(SRL_ctrl),
    .Ready(Ready)
);

// 被除數
Divisor divisor 
(
    .Reset(Reset),
    .W_ctrl(W_ctrl),
    .Divisor_in(Divisor_in[31:0]),
    .Divisor_out(Divisor_out[31:0])
);

// ALU
ALU Arithemetic_Logical_Unit
(
    .Src1(Remainder_out[31:0]),
    .Src2(Divisor_out[31:0]),
    .Funct(SUBU_ctrl[5:0]),
    .Carry(ALU_carry),
    .Result(ALU_result[31:0])
);

// remain unit
Remainder remain_unit
(
    .SRL_ctrl(SRL_ctrl),
    .SLL_ctrl(SLL_ctrl),
    .W_ctrl(W_ctrl),
    .Ready(Ready),
    .Reset(Reset),
    .clk(clk),
    .ALU_carry(ALU_carry),
    .ALU_result(ALU_result[31:0]),
    .Dividend_in(Dividend_in[31:0]),
    .Remainder_out(Remainder_out_reg[63:0])
);

assign Remainder_out[31:0] = Remainder_out_reg[63:32];
assign Quotient_out[31:0] = Remainder_out_reg[31:0];

endmodule

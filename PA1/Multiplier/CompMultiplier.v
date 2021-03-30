module CompMultiplier(clk,Reset,Run,Multiplier_in,Multiplicand_in,Product_out,Ready);
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
wire [31:0]ALU_result;
wire [31:0]Multiplier_in;
wire [63:0]Product_out;
wire [5:0]ADDU_ctrl;

// control unit
Control controller
(
    .Run(Run),
    .Reset(Reset),
    .clk(clk),
    .LSB(Product_out[0]),
    .W_ctrl(W_ctrl),
    .ADDU_ctrl(ADDU_ctrl[5:0]),
    .SRL_ctrl(SRL_ctrl),
    .Ready(Ready)
);

// 被乘數
Multiplicand multiplicand 
(
    .Reset(Reset),
    .W_ctrl(W_ctrl),
    .Multiplicand_in(Multiplicand_in[31:0]),
    .Multiplicand_out(Multiplicand_out[31:0])
);

// ALU
ALU Arithemetic_Logical_Unit
(
    .Src1(Product_out[63:32]),
    .Src2(Multiplicand_out[31:0]),
    .Funct(ADDU_ctrl[5:0]),
    .Carry(ALU_carry),
    .Result(ALU_result[31:0])
);

// product unit
Product product_unit
(
    .SRL_ctrl(SRL_ctrl),
    .W_ctrl(W_ctrl),
    .Ready(Ready),
    .Reset(Reset),
    .clk(clk),
    .ALU_carry(ALU_carry),
    .ALU_result(ALU_result[31:0]),
    .Multiplier_in(Multiplier_in[31:0]),
    .Product_out(Product_out[63:0])
);

endmodule

module tb_Remainder();
reg SRL_ctrl;
reg SLL_ctrl;
reg W_ctrl;
reg Ready;
reg Reset;
reg clk;
reg ALU_carry;
reg [31:0]ALU_result;
reg [31:0]Dividend_in;
wire [63:0]Remainder_out;

Remainder remain
(
    .SRL_ctrl(SRL_ctrl),
    .SLL_ctrl(SLL_ctrl),
    .W_ctrl(W_ctrl),
    .Ready(Ready),
    .Reset(Reset),
    .clk(clk),
    .ALU_carry(ALU_carry),
    .ALU_result(ALU_result),
    .Dividend_in(Dividend_in),
    .Remainder_out(Remainder_out)
);

initial #100 $finish;


initial begin
#0 clk = 0;
forever #5 clk = ~clk;
end


initial fork
    // 初始化
    #0 ALU_result = 32'd10;
    #0 W_ctrl = 0;
    #0 Reset = 0;
    #0 Ready = 0;
    #0 SRL_ctrl = 0;
    #0 SLL_ctrl = 0;
    #0 ALU_carry = 0;
    #0 Dividend_in = 0;

    // 系統開始初始化，remainder_out[31:0] = Dividend_in [31:0] << 1
    #15 Reset = 1;
    #15 W_ctrl =1;
    #15 Dividend_in = 32'h FFFF_FFFF;
    #15 SLL_ctrl = 1; // start to run
    
    // 系統開始執行
    #30 Reset = 0;
    #30 SRL_ctrl = 0;
    #30 SLL_ctrl = 1; // Remainder_out = Remainder_out << 1; 
    #40 ALU_result = 32'h FF00_F0F0; // 此時的remainder out 會等於 ALU_Result << 1
    #40 ALU_carry = 0; // remainder_out[0] = 1;

    #50 ALU_carry = 1; // remainder_out[0] = 0;

    #60 SRL_ctrl = 1; // Remainder_out[63:32] = Remainder_out[63:32] >> 1;
    #60 SLL_ctrl = 0; 
    #80 Ready = 1; // 讓輸出維持不變

join    



endmodule

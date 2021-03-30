module tb_Product();
reg SRL_ctrl;
reg W_ctrl;
reg Ready;
reg Reset;
reg clk;
reg ALU_carry;
reg [31:0]ALU_result;
reg [31:0]Multiplier_in;
wire [63:0]Product_out;

Product pro
(
    .SRL_ctrl(SRL_ctrl),
    .W_ctrl(W_ctrl),
    .Ready(Ready),
    .Reset(Reset),
    .clk(clk),
    .ALU_carry(ALU_carry),
    .ALU_result(ALU_result),
    .Multiplier_in(Multiplier_in),
    .Product_out(Product_out)
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
    #0 ALU_carry = 0;
    #0 Multiplier_in = 0;
 
    // 系統開始初始化，product_out[31:0] = Multipler_in[31:0]
    #15 Reset = 1;
    #15 W_ctrl =1;
    #15 Multiplier_in = 32'h FFFF_FFFF;

    // 系統開始執行
    #30 Reset = 0;
    #30 SRL_ctrl = 1;
    #30 ALU_carry = 1; // 這裡的話輸出應該會是高阻抗，因為overflow了
    
    #40 ALU_carry = 0; // 到這裡才會恢復正常(負緣觸發)
    #40 Reset = 1; // 因為要把Product_out歸0，所以要重新Reset
    #40 W_ctrl = 1;
    
    #50 Reset = 0;
    #50 W_ctrl = 0;
    #50 Ready = 0; //這時候要讓輸出乘法器工作

    #80 Ready = 1; // 讓輸出維持不變

join    



endmodule
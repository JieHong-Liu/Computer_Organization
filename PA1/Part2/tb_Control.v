module tb_Control();

reg Run,Reset,clk,MSB;
wire W_ctrl,SRL_ctrl,SLL_ctrl,Ready;
wire [5:0]SUBU_ctrl;

Control controller(
    .Run(Run),
    .Reset(Reset),
    .clk(clk),
    .MSB(MSB),
    .W_ctrl(W_ctrl),
    .SUBU_ctrl(SUBU_ctrl),
    .SRL_ctrl(SRL_ctrl),
    .SLL_ctrl(SLL_ctrl),
    .Ready(Ready)
);

initial #400 $finish;

initial begin
    #0 clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    #0 MSB = 0;
    forever #10 MSB = ~MSB;
end


initial fork
    #0 Run = 0;
    #0 Reset = 0;

    #5 Reset = 1;   // 以reset為主，所以下面為多少理論上都不會影響
    #5 Run = 1;

    #15 Reset = 0;
    #15 Run = 0; 

    #25 Run = 1;    //從這裡開始計數32次 -> 10*32=320，320+20 = 340(10秒為放shift left，另一個10秒為最後做完32次要在right shift)，340 + 25 = 365 在355的時候，Ready應該要跳1，這時候W_ctrl =0, SUBU_ctrl = 0, SRL_ctrl = 0, SLL_ctrl = 0, Ready = 1
join

endmodule

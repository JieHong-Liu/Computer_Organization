module tb_Control();

reg Run,Reset,clk,LSB;
wire W_ctrl,SRL_ctrl,Ready;
wire [5:0]ADDU_ctrl;

Control controller(
    .Run(Run),
    .Reset(Reset),
    .clk(clk),
    .LSB(LSB),
    .W_ctrl(W_ctrl),
    .ADDU_ctrl(ADDU_ctrl),
    .SRL_ctrl(SRL_ctrl),
    .Ready(Ready)
);

initial #350 $finish;

initial begin
    #0 clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    #0 LSB = 0;
    forever #10 LSB = ~LSB;
end


initial fork
    #0 Run = 0;
    #0 Reset = 0;

    #5 Reset = 1;   // 以reset為主，所以下面為多少理論上都不會影響
    #5 Run = 1;

    #15 Reset = 0;
    #15 Run = 0; 

    #25 Run = 1;    //從這裡開始計數32次 -> 10*32=320，在345的時候，Ready應該要跳1
join

endmodule
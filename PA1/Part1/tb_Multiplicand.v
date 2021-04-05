module tb_Multiplicand();

reg Reset,W_ctrl;
reg [31:0]Multiplicand_in;
wire [31:0]Multiplicand_out;

Multiplicand multiplicand(
    .Reset(Reset),
    .W_ctrl(W_ctrl),
    .Multiplicand_in(Multiplicand_in),
    .Multiplicand_out(Multiplicand_out)
);

initial #30 $finish;
initial fork
#0 Reset = 0; // 因為W_ctrl是由Controller所發送，所以一定會與Reset相同，那在這裡
#0 W_ctrl = 0;// 我們就依照我們設計正確的前提下，去進行test bench的測試
#0 Multiplicand_in = 32'h FFFF_FFFF; // 兩者皆為0的時候改任何值，輸出都不應該改變

#10 Reset = 1;
#10 W_ctrl = 1;
#12 Multiplicand_in = 32'h FF00_F0F0; 
// 與上面兩行時間不同，是因為輸入有可能不一樣，且這個輸出應該為0

#15 Reset = 0; 
#15 W_ctrl = 0;
#15 Multiplicand_in = 32'h 00FF_00FF;
// 以下測試為，系統錯誤時會發生的狀況，也就是Reset與W_ctrl不同步。
#20 Reset = 1;
#20 W_ctrl = 0;
#20 Multiplicand_in = 32'h 0;

#25 Reset = 0;
#25 W_ctrl = 1;
#25 Multiplicand_in = 32'h 0;

join

endmodule
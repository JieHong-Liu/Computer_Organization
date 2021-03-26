module Control(Run,Reset,clk,LSB,W_ctrl,ADDU_ctrl,SRL_ctrl,Ready);
input Run;
input Reset;
input clk;
input LSB;
output reg W_ctrl;
output reg [5:0]ADDU_ctrl;
output reg SRL_ctrl;
output reg Ready;
integer counter = 0;
always@(posedge clk or posedge Reset or posedge Run)
begin
    if(Reset == 1)
    begin
        W_ctrl = 0;
        ADDU_ctrl = 0;
        SRL_ctrl = 0;
        Ready = 0;
    end
    else if (Run == 1)
    begin
        counter = counter + 1;
    end

    if (LSB == 1)
    begin
                W_ctrl = 1; // ；Run 訊號觸發讀取乘數與被乘數
        ADDU_ctrl = 1; // 並開始執行運算。 
        SRL_ctrl = 1; // 將結果暫存器左半累加被乘數
    end

    if(counter == 32)
    begin
        Ready = 1;
    end
end


endmodule

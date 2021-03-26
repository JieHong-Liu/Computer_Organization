module Control(Run,Reset,clk,LSB,W_ctrl,ADDU_ctrl,SRL_ctrl,Ready);
input Run;
input Reset;
input clk;
input LSB;
output W_ctrl;
output [5:0]ADDU_ctrl;
output SRL_ctrl;
output Ready;
always@(posedge clk or posedge Reset or posedge Run)
begin
    if(Reset == 1)
    begin
        
    end
    else if (Run == 1)
    begin
        
    end


end


endmodule

module Control(Run,Reset,clk,W_ctrl,SUBU_ctrl,SRL_ctrl,SLL_ctrl,Ready,MSB);
input Run;
input Reset;
input clk;
input MSB;

output reg W_ctrl; // Write control
output reg [5:0]SUBU_ctrl;
output reg SRL_ctrl;
output reg SLL_ctrl;
output reg Ready;
reg [5:0]counter; // counter for 32 times;
reg counting;
always@(posedge clk or  posedge Reset)
begin
    if(Reset == 1)
        begin
            W_ctrl = 1; // Write control -> 是否要取新的值進來
            SUBU_ctrl = 6'b0; // Function -> ALU要不要工作
            SRL_ctrl = 0; // Shift right control -> 要不要shift
            SLL_ctrl = 0; // Shift left control 
            Ready = 0; // Ready signal -> 結果完成
            counter = 0;
            counting = 0;
        end
    else if (Run == 1 && Ready == 0)
        begin
            if(counter == 32) // for (counter = 0 ; counter < 32; counter ++)
                begin
                    if(SRL_ctrl == 0)
                        begin
                            SLL_ctrl = 0;
                            SRL_ctrl = 1;
                        end
                    else
                        begin
                            SRL_ctrl = 0;
                            Ready = 1;
                        end
                end
            else 
                begin
                    if(counting == 0)
                        begin
                            SLL_ctrl = 1;
                            counting = 1;
                        end
                    else
                        begin // start to count.
                            W_ctrl = 0;   // 在Run的時候不要取新的值進來
                            SUBU_ctrl = 6'b 001010;
                            if(MSB == 0) // 代表Remainder >= 0
                                begin
                                    SLL_ctrl = 1; // 3.a -> Remainder[0] = 1;              
                                end
                            else // Remainder < 0
                                begin
                                    SLL_ctrl = 1; // 3.b -> Remainder[0] = 0;
                                end
                            counter = counter + 1;
                        end 
                end
        end
    else // Ready = 1;
        begin
            W_ctrl = 0 ; // Write control -> 是否要取新的值進來 -> 因為有可能Reset完，Run還沒跳起來
            SUBU_ctrl = 0; // Function -> ALU要不要工作
            SRL_ctrl = 0 ; // Shift right control -> 要不要shift
            SLL_ctrl = 0 ; // Shift left control 
            Ready = Ready; // Ready signal -> 結果完成
            counter = counter;
            counting = counting;
        end
end


endmodule

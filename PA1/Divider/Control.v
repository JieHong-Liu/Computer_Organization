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
always@(posedge clk or  posedge Reset)
begin
    if(Reset == 1)
        begin
            W_ctrl = 1; // Write control -> 是否要取新的值進來
            SUBU_ctrl = 6'b0; // Function -> ALU要不要工作
            SRL_ctrl = 0; // Shift right control -> 要不要shift
            SLL_ctrl = 1; // Shift left control 
            Ready = 0; // Ready signal -> 結果完成
            counter = 0;
        end
    else if (Run == 1 && Ready == 0)
        begin
            if(counter == 32) // for (counter = 0 ; counter < 32; counter ++)
                begin
                    Ready = 1; // 告訴系統我們完成了
                end
            else 
                begin
                    W_ctrl = 0;      // 在Run的時候不要取新的值進來
                    SUBU_ctrl = 6'b 001010;
                    if(MSB == 0) // 代表Remainder >= 0
                        begin
                            SLL_ctrl = 1;                       
                        end
                    else // Remainder < 0
                        begin
                            ADDU_ctrl = 
                        end
                    // SRL_ctrl = 1;   // 將結果暫存器左半累加被乘數
                    // if (MSB == 1)   // Product[0] == 1 -> ALU要工作，所以我讓ADDU_ctrl = 1;
                    //     begin
                    //         SUBU_ctrl = 6'b001001;  // 並開始執行運算。 
                    //     end
                    // else if (MSB == 0)  // ALU不用工作
                    //     begin
                    //         ADDU_ctrl = 6'b0;
                    //     end
                    counter = counter + 1;
                end
        end
    else 
        begin
            W_ctrl = 0 ; // Write control -> 是否要取新的值進來 -> 因為有可能Reset完，Run還沒跳起來
            SUBU_ctrl = SUBU_ctrl; // Function -> ALU要不要工作
            SRL_ctrl = SRL_ctrl ; // Shift right control -> 要不要shift
            SLL_ctrl = SLL_ctrl ; // Shift left control 
            Ready = Ready; // Ready signal -> 結果完成
            counter = counter;
        end
end


endmodule

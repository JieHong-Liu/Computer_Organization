module Divisor(Reset,W_ctrl,Divisor_in,Divisor_out);
input Reset;
input W_ctrl;
input [31:0]Divisor_in;
reg [31:0]Divisor_reg;
output reg [31:0]Divisor_out;

always@(Reset or W_ctrl or Divisor_in)
begin
    if(Reset == 1 && W_ctrl == 1)
        begin
            Divisor_reg = Divisor_in ;
            Divisor_out = 0; // 把值讀進來，但不輸出or輸出為0
        end
    // 在設計沒有錯誤的情況下，W_ctrl應該會與Reset連動，所以我將這兩個logic AND 起來
    else if (W_ctrl == 0 && Reset == 0) // means that the system is running 
        begin
            Divisor_out = Divisor_reg; // let output = reg
        end
    else 
        begin
            Divisor_out = 32'bZ; // it means that the design is failed.
        end
end


endmodule

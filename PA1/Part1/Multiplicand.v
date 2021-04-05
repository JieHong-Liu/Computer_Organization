module Multiplicand(Reset,W_ctrl,Multiplicand_in,Multiplicand_out);
input Reset;
input W_ctrl;
input [31:0]Multiplicand_in;
reg [31:0]Multiplicand_reg;
output reg [31:0]Multiplicand_out;

always@(Reset or W_ctrl or Multiplicand_in)
begin
    if(Reset == 1 && W_ctrl == 1)
        begin
            Multiplicand_reg = Multiplicand_in ;
            Multiplicand_out = 0; // 把值讀進來，但不輸出or輸出為0
        end
    // 在設計沒有錯誤的情況下，W_ctrl應該會與Reset連動，所以我將這兩個logic AND 起來
    else if (W_ctrl == 0 && Reset == 0) // means that the system is running 
        begin
            Multiplicand_out = Multiplicand_reg; // let output = reg
        end
    else 
        begin
            Multiplicand_out = 32'bZ; // it means that the design is failed.
        end
end


endmodule

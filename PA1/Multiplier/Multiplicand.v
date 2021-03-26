module Multiplicand(Reset,W_ctrl,Multiplicand_in,Multiplicand_out);
input Reset;
input W_ctrl;
input [31:0]Multiplicand_in;
output reg [31:0]Multiplicand_out;

always@(Reset or W_ctrl)
begin
    if(Reset == 1)
    begin
        Multiplicand_out=0;
    end
    else if (W_ctrl == 1)
    begin
        Multiplicand_out = Multiplicand_in;
    end

end


endmodule

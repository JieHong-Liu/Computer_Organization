module MUX3to1(
    input [31:0] Src1,
    input [31:0] Src2,
    input [31:0] Src3,
    input [1:0] choose,
    output reg [31:0]result
);

always@(*)
begin
    case(choose)
        2'b00:result = Src1;
        2'b01:result = Src2;
        2'b10:result = Src3;
        default:;
    endcase
end

endmodule
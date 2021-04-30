module Mux32b(
    input [31:0]Src1, // 0 
    input [31:0]Src2, // 1
    input choose,
    output [31:0]result
);

assign result = choose? Src2:Src1;

endmodule
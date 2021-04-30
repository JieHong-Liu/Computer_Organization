module Mux5b(
    input [4:0]Src1,//0
    input [4:0]Src2,//1
    input choose,
    output [4:0]result
);

assign result = choose? Src2:Src1;

endmodule
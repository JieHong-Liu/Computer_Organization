module Adder
(
    input   [31:0]  Src1,
    input   [31:0]  Src2,
    output  [31:0]  DataOut
);

    assign DataOut = Src1 + Src2;

endmodule

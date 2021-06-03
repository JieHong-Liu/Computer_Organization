module Adder
(
    input   [31:0]  AddrIn,
    output  [31:0]  AddrOut
);

    assign AddrOut = AddrIn + 32'd 4;

endmodule

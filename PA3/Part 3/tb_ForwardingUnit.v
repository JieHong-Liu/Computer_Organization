module tb_ForwardingUnit(
    output [1:0] ForwardA,
    output [1:0] ForwardB
);

    reg EX_MEM_RegWrite;
    reg  [4:0] EX_MEM_RegisterRd;
    reg  [4:0] ID_EX_RegisterRs;
    reg  [4:0] ID_EX_RegisterRt;
    wire [1:0] ForwardA;
    wire [1:0] ForwardB;

    // Mem hazard
    reg MEM_WB_RegWrite;
    wire [4:0] MEM_WB_RegisterRd;

endmodule
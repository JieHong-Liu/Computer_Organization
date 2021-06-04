module ForwardingUnit(

    // EX hazard
    input EX_MEM_RegWrite,
    input [4:0] EX_MEM_RegisterRd,
    input [4:0] ID_EX_RegisterRs,
    input [4:0] ID_EX_RegisterRt,
    output reg [1:0] ForwardA,
    output reg [1:0] ForwardB,

    // Mem hazard
    input MEM_WB_RegWrite,
    input [4:0] MEM_WB_RegisterRd

);

// EX hazard
always@(*)
    begin
        ForwardA =2'b00;
        ForwardB = 2'b00;
        if(EX_MEM_RegWrite && EX_MEM_RegisterRd != 0 && (EX_MEM_RegisterRd  == ID_EX_RegisterRs))
            begin
                ForwardA = 2'b10;
            end
        if(EX_MEM_RegWrite && EX_MEM_RegisterRd != 0 && (EX_MEM_RegisterRd  == ID_EX_RegisterRt))
            begin
                ForwardB = 2'b10;
            end
// MEM hazard.
        if(MEM_WB_RegWrite && MEM_WB_RegisterRd != 0 && (MEM_WB_RegisterRd == ID_EX_RegisterRs))
            begin
                ForwardA = 2'b01;
            end        
        if(MEM_WB_RegWrite && MEM_WB_RegisterRd != 0 && (MEM_WB_RegisterRd == ID_EX_RegisterRt))
            begin
                ForwardB = 2'b01;
            end
    end


endmodule


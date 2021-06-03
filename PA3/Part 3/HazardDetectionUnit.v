module HazardDetectionUnit(
    input ID_EX_MemRead, // if 1, indicats a load instruction.
    input [4:0] ID_EX_RegisterRt,
    input [4:0] IF_ID_RegisterRs,
    input [4:0] IF_ID_RegisterRt,
    output reg Stall,
    output reg PCWrite,
    output reg IF_ID_Write
);
initial begin
    Stall = 0;
    IF_ID_Write = 1;
    PCWrite = 1;
end
always@(*)
    begin
        PCWrite = 1;
        IF_ID_Write = 1;
        Stall = 0;
        if(ID_EX_MemRead && ((ID_EX_RegisterRt == IF_ID_RegisterRs) || (ID_EX_RegisterRt == IF_ID_RegisterRt)))
        begin
                Stall = 1;
                IF_ID_Write = 0;
                PCWrite = 0; // do stall
        end

    end

endmodule
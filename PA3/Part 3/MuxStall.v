module MuxStall(
input RegDst_in,
input MemRead_in,
input MemtoReg_in,
input[1:0] ALUOp_in,
input MemWrite_in,
input ALUSrc_in,
input RegWrite_in,
input Stall_choose,
output reg RegDst_out,
output reg MemRead_out,
output reg MemtoReg_out,
output reg[1:0] ALUOp_out,
output reg MemWrite_out,
output reg ALUSrc_out,
output reg RegWrite_out
);

always@(*) begin

    if (Stall_choose==0)
    begin
        RegDst_out	=RegDst_in;
        MemRead_out	=MemRead_in;
        MemtoReg_out	=MemtoReg_in;
        ALUOp_out	=ALUOp_in;
        MemWrite_out	=MemWrite_in;
        ALUSrc_out	=ALUSrc_in;
        RegWrite_out	=RegWrite_in;
    end

    if (Stall_choose==1)
    begin
        RegDst_out	=0;
        MemRead_out	=0;
        MemtoReg_out	=0;
        ALUOp_out	=2'd0;
        MemWrite_out	=0;
        ALUSrc_out	=0;
        RegWrite_out	=0;
    end


end
endmodule

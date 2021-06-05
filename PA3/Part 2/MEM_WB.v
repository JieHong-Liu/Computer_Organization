module MEM_WB(
    // Write Back.
    input RegWrite_in, // WB
    input Mem2Reg_in,  //WB
    output reg RegWrite_out, // WB
    output reg Mem2Reg_out,// WB
    // Others.
    input clk,
    input [31:0] MemAddr_in,
    input [4:0] RdAddr_in,
    input [31:0] MemReadData_in,
    output reg [31:0] MemReadData_out,
    output reg [4:0] RdAddr_out,
    output reg [31:0] MemAddr_out
);
    // Temp register part.
    // Write Back.
    reg RegWrite_reg;
    reg Mem2Reg_reg;
    // Others.
    reg [5:0] RdAddr_reg;
    reg [31:0] MemAddr_reg;
    reg [31:0] MemReadData_reg;

always@(posedge clk or negedge clk)
    begin
        if(clk == 1) // put them in to the reg
            begin
                // Write Back.
                RegWrite_reg = RegWrite_in;
                Mem2Reg_reg = Mem2Reg_in;

                // Others
                RdAddr_reg = RdAddr_in;
                MemAddr_reg = MemAddr_in;
                MemReadData_reg = MemReadData_in;
            end
        else
            begin
                // Write Back.
                RegWrite_out = RegWrite_reg;
                Mem2Reg_out = Mem2Reg_reg;

                // Others
                RdAddr_out = RdAddr_reg;
                MemAddr_out = MemAddr_reg;
                MemReadData_out = MemReadData_reg;
            end
    end


endmodule
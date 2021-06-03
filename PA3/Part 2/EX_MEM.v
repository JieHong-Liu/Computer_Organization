module EX_MEM(

    // Write Back.
    input RegWrite_in, // WB
    input Mem2Reg_in,  //WB

    output reg RegWrite_out, // WB
    output reg Mem2Reg_out,// WB

    // Memory
    input MemRead_in,  
    input MemWrite_in, 
    output reg MemWrite_out,
    output reg MemRead_out,

    // Others.

    input clk,
    input [31:0] ALU_result_in,
    input [4:0] RdAddr_in,
    input [31:0] RtData_in,
    output reg [31:0] RtData_out,
    output reg [4:0] RdAddr_out,
    output reg [31:0] ALU_result_out
);

    // Temp register part.
    
    // Write Back.
    reg RegWrite_reg;
    reg Mem2Reg_reg;
    // Memory
    reg MemRead_reg;
    reg MemWrite_reg;
    // Others.
    reg [5:0] RdAddr_reg;
    reg [31:0] RtData_reg;
    reg [31:0] ALU_result_reg;



always@(posedge clk or negedge clk)
    begin
        if(clk == 1) // put them in to the reg
            begin
                // Write Back.
                RegWrite_reg = RegWrite_in;
                Mem2Reg_reg = Mem2Reg_in;
                // Memory.
                RegWrite_reg = RegWrite_in;
                Mem2Reg_reg = Mem2Reg_in;
                MemRead_reg = MemRead_in;
                MemWrite_reg = MemWrite_in;
                // Others
                RdAddr_reg = RdAddr_in;
                ALU_result_reg = ALU_result_in;
                RtData_reg = RtData_in;

            end
        else
            begin
                // Write Back.
                RegWrite_out = RegWrite_reg;
                Mem2Reg_out = Mem2Reg_reg;
                // Memory
                RegWrite_out = RegWrite_reg;
                Mem2Reg_out = Mem2Reg_reg;
                MemRead_out = MemRead_reg;
                MemWrite_out = MemWrite_reg;
                // Others
                RdAddr_out = RdAddr_reg;
                ALU_result_out = ALU_result_reg;
                RtData_out = RtData_reg;

            end
    end


endmodule
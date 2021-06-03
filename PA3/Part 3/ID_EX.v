module ID_EX(
    
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

    // EX.
    input [1:0] ALUOp_in, // EX
    input RegDst_in,
    input ALU_Src_in,

    output reg [1:0] ALUOp_out, //EX
    output reg RegDst_out,
    output reg ALU_Src_out,

    // Others.
    input clk,
    input [4:0] RdAddr_in,
    input [4:0] RtAddr_in,
    input [4:0] RsAddr_in,
    input [31:0] RsData_in,
    input [31:0] RtData_in,
    input [31:0] immediate_in,

    output reg [31:0] immediate_out,
    output reg [31:0] RsData_out,
    output reg [31:0] RtData_out,
    output reg [4:0] RdAddr_out,
    output reg [4:0] RtAddr_out,
    output reg [4:0] RsAddr_out

);
    // Temp register part.
    
    // Write Back.
    reg RegWrite_reg;
    reg Mem2Reg_reg;
    // Memory
    reg MemRead_reg;
    reg MemWrite_reg;
    // Execution.
    reg [1:0] ALUOp_reg; // EX
    reg RegDst_reg;
    reg ALU_Src_reg;
    // Others.
    reg [4:0] RdAddr_reg;
    reg [4:0] RtAddr_reg;
    reg [4:0] RsAddr_reg;
    reg [31:0] RsData_reg;
    reg [31:0] RtData_reg;
    reg [31:0] immediate_reg;


always@(posedge clk or negedge clk)
    begin
        if(clk == 1) // put them in to the reg
            begin
                // Write Back.
                Mem2Reg_reg = Mem2Reg_in;
                RegWrite_reg = RegWrite_in;
                // Memory.
                MemRead_reg = MemRead_in;
                MemWrite_reg = MemWrite_in;
                // Execution
                ALUOp_reg = ALUOp_in;
                RegDst_reg = RegDst_in;
                ALU_Src_reg =ALU_Src_in;
                // Others.
                RdAddr_reg = RdAddr_in;
                RtAddr_reg = RtAddr_in;
                RsAddr_reg = RsAddr_in;

                RsData_reg = RsData_in;
                RtData_reg = RtData_in;
                immediate_reg = immediate_in;
            end
        else
            begin
                // Write Back.
                RegWrite_out = RegWrite_reg;
                Mem2Reg_out = Mem2Reg_reg; 
                // Memory.
                MemRead_out = MemRead_reg;
                MemWrite_out = MemWrite_reg;
                // Execution
                ALUOp_out = ALUOp_reg;
                RegDst_out = RegDst_reg;
                ALU_Src_out =ALU_Src_reg;
                // Others.
                RdAddr_out = RdAddr_reg;
                RtAddr_out = RtAddr_reg;
                RsAddr_out = RsAddr_reg;

                RsData_out = RsData_reg;
                RtData_out = RtData_reg;
                immediate_out = immediate_reg;
            end
    end



endmodule
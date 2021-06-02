module ID_EX(
    
    input RegWrite_in, // WB
    input clk,
    input [1:0] ALUOp_in, // EX
    input [5:0] funct_in,
    input [4:0] shamt_in,
    input [4:0] RdAddr_in,
    input [31:0] RsData_in,
    input [31:0] RtData_in,
    
    output reg [1:0] ALUOp_out, //EX
    output reg [31:0] RsData_out,
    output reg [31:0] RtData_out,
    output reg [4:0] RdAddr_out,
    output reg [5:0] funct_out,
    output reg [4:0] shamt_out, 
    output reg RegWrite_out // WB

);

    reg WB;
    reg [1:0] EX;
    reg [5:0] RdAddr_reg;
    reg [5:0] funct_reg;
    reg [5:0] shamt_reg;
    reg [31:0] RsData_reg;
    reg [31:0] RtData_reg;


always@(posedge clk or negedge clk)
    begin
        if(clk == 1) // put them in to the reg
            begin
                WB = RegWrite_in;
                EX = ALUOp_in;
                RdAddr_reg = RdAddr_in;
                funct_reg = funct_in;
                shamt_reg = shamt_in;
                RsData_reg = RsData_in;
                RtData_reg = RtData_in;
            end
        else
            begin
                RegWrite_out = WB;
                ALUOp_out = EX;
                RdAddr_out = RdAddr_reg;
                funct_out = funct_reg;
                shamt_out = shamt_reg;
                RsData_out = RsData_reg;
                RtData_out = RtData_reg;
            end
    end



endmodule
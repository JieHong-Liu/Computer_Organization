module EX_MEM(

    input clk,
    input RegWrite_in, // WB
    input [31:0] ALU_result_in,
    input [4:0] RdAddr_in,

    output reg [4:0] RdAddr_out,
    output reg [31:0] ALU_result_out,
    output reg RegWrite_out // WB

);

    reg WB;
    reg [4:0] RdAddr_reg;
    reg [31:0] ALU_result_reg;



always@(posedge clk or negedge clk)
    begin
        if(clk == 1) // put them in to the reg
            begin
                WB = RegWrite_in;
                RdAddr_reg = RdAddr_in;
                ALU_result_reg = ALU_result_in;

            end
        else
            begin
                RegWrite_out = WB;
                RdAddr_out = RdAddr_reg;
                ALU_result_out = ALU_result_reg;

            end
    end


endmodule
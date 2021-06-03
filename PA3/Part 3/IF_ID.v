module IF_ID(
    input [31:0] Instr,
    input clk,
    input IF_ID_Write,
    output reg [31:0] InstrOut
);
    reg [31:0] Instr_reg;

always@(posedge clk or negedge clk) 
    begin
        if(clk == 1 && IF_ID_Write == 1)  //when posedge clk, store the instruction to the reg.
            Instr_reg = Instr;
        else // when negedge clk, output the instruction reg to the instruction out.
            InstrOut = Instr_reg;
    end
    


endmodule
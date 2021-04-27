module ALU_Control(
    input   wire  [5:0] funct,
    input   wire        ALUOp,
    output  reg   [5:0] Funct
) ;

always@(funct or ALUOp)
    begin
        if(ALUOp == 1)
            begin
                Funct[5:0] = funct[5:0];
            end
        else
            begin
                Funct[5:0] = funct[5:0];
            end
    end
endmodule
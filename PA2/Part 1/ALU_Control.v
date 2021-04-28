`define addu 6'b 001001
`define subu 6'b 001010
`define AND  6'b 010001
`define sll  6'b 100001
`define R_type 2'b10
module ALU_Control(
    input     [5:0] funct,
    input     [1:0] ALUOp,
    output  reg   [5:0] Funct
);

always@(funct or ALUOp)
    begin
        case(ALUOp)
            `R_type:
                begin
                    case(funct)
                        6'b 001011 : Funct = `addu;
                        6'b 001101 : Funct = `subu;
                        6'b 010010 : Funct = `AND;
                        6'b 100110 : Funct = `sll;
                    endcase
                end
        endcase
    end
endmodule
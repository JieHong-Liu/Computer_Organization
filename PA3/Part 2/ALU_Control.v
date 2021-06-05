`define addu 6'b 001011
`define subu 6'b 001101
`define AND  6'b 010010
`define sll  6'b 100110
`define input_addu 6'b 001011
`define input_subu 6'b 001101
`define input_and  6'b 010010
`define input_sll  6'b 100110
`define R_type 2'b10
// I-type sub
`define I_type_sub 2'b00
// I-type add  
`define I_type_add 2'b01
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
                        `input_addu : Funct = `addu;
                        `input_subu : Funct = `subu;
                        `input_and  : Funct = `AND;
                        `input_sll  : Funct = `sll;
                        default: Funct = 0;
                    endcase
                end
            `I_type_sub:
                begin
                    Funct = `subu;
                end
            `I_type_add:
                begin
                    Funct = `addu;
                end
            default:;
        endcase
    end
endmodule
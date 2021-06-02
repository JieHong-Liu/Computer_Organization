`define addu 6'b 001001
`define subu 6'b 001010
`define AND  6'b 010001
`define sll  6'b 100001

`define input_addu 6'b 001011
`define input_subu 6'b 001101
`define input_and  6'b 010010
`define input_sll  6'b 100110
`define R_type 2'b10

module tb_ALU_Control;

reg     [5:0] funct;
reg     [1:0] ALUOp;
wire    [5:0] Funct;


ALU_Control alu_controller(
    .funct(funct),
    .ALUOp(ALUOp),
    .Funct(Funct)
);

initial #25 $finish;

initial fork
    #0 ALUOp = 2'b0;
    #0 funct = `input_addu; // Funct = 0;
    
    #5 ALUOp = 2'b10;
    #5 funct = `input_subu; // Funct = a;

    #10 funct = `input_and; // Funct = 11h

    #15 funct = `input_sll; // Funct = 21h

    #20 funct = `input_addu; // Funct = 9h
join

endmodule
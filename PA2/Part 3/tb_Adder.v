module tb_Adder;

    wire [31:0] DataOut;
    reg  [31:0] Src1; 
    reg  [31:0] Src2;
	
    Adder A(
		// Outputs
        .DataOut(DataOut),
		// Inputs
        .Src1(Src1),
        .Src2(Src2)
	);

    initial #20 $finish;
    initial fork
        #0 Src1 = 32'd 0;
        #0 Src2 = 32'h FFFF_FFFF;
        
        #10 Src1 = 32'h FFFF_FFFF;
        #10 Src2 = 32'h 0000_0004;
    join 

endmodule
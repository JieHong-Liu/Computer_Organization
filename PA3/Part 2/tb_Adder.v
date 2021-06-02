module tb_Adder;

    wire [31:0] AddrOut;
    reg  [31:0] AddrIn; 
	
    Adder A(
		// Outputs
        .AddrOut(AddrOut),
		// Inputs
        .AddrIn(AddrIn)
	);

    initial #20 $finish;
    initial fork
        #0 AddrIn = 32'd 0;

        #10 AddrIn = 32'h FFFF_FFFF;
    join 

endmodule
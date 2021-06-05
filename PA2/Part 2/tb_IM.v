`define INSTR_FILE		"testbench/IM.dat"
`define INSTR_MAX		128	// bytes
`define INSTR_SIZE		8	// bit width


module tb_IM;

	integer i;
    reg     [31:0]  InstrAddr;
    wire    [31:0]  Instr;
    reg [`INSTR_SIZE-1	:0]	instrMem	[0:`INSTR_MAX-1];

    IM Instruction_Memory(
        .InstrAddr(InstrAddr),
        .Instr(Instr)
    );

    initial begin : Preprocess
    	
        $readmemh(`INSTR_FILE,	instrMem);// put the value into instrMem
        // Initialize intruction memory
		for (i = 0; i < `INSTR_MAX; i = i + 1)
		begin
			Instruction_Memory.InstrMem[i] = instrMem[i];
		end
    end

    initial #20 $finish;

    initial fork
        #0 InstrAddr = 8;// Instr should be 7000_0000.
        #10 InstrAddr = 2; // Instr should be 00_EE_12_62
    join


endmodule
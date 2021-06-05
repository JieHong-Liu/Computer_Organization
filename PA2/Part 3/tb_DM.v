`define DATA_SIZE		8	// bit width
`define DATA_MAX		128	// bytes
`define DATA_FILE		"testbench/DM.dat"
`define DELAY			5	// # * timescale

module tb_DM();
    reg clk;
    reg [31:0] MemAddr;
    reg [31:0] MemWriteData;
    reg MemWrite;
    reg MemRead;
    wire [31:0] MemReadData;
	reg [`DATA_SIZE-1	:0]	dataMem		[0:`DATA_MAX-1];
    integer i;

DM Data_Memory(
    .MemAddr(MemAddr),
    .MemWriteData(MemWriteData),
    .MemWrite(MemWrite),
    .MemRead(MemRead),
    .clk(clk),
    .MemReadData(MemReadData)
);

    initial begin: Preprocess

        clk = 0;

        $readmemh(`DATA_FILE,	dataMem);
		// Initialize data memory
		for (i = 0; i < `DATA_MAX; i = i + 1)
		begin
			Data_Memory.DataMem[i] = dataMem[i];
		end

    end

    always begin : ClockGenerator
		#`DELAY;
		clk <= ~clk;
	end

    initial #20 $finish;

    initial fork 
        #0 MemWriteData = 32'h 1234_5678;
        #0 MemAddr = 32'h 0000_0000;
        #0 MemWrite = 1;
        #0 MemRead = 0;
        
        #10 MemRead = 1;
        #10 MemWrite = 0;

    join

endmodule
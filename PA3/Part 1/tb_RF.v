`define DELAY			5	// # * timescale
`define REG_SIZE		32	// bit width
`define REG_MAX			32	// words
`define REG_FILE		"testbench/RF.dat"

module tb_RF;

    // Inputs
    reg RegWrite;
    reg clk;
    reg [4:0] RsAddr;
    reg [4:0] RtAddr;
    reg [4:0] RdAddr;
    reg [31:0] RdData;

    // Outputs
    wire [31:0] RsData;
    wire [31:0] RtData;

    integer i;
    integer output_reg;
	reg [`REG_SIZE-1	:0]	regMem		[0:`REG_MAX-1];

    RF Register_File(
    // Outputs
        .RsData(RsData),
        .RtData(RtData),
    // Inputs
        .RegWrite(RegWrite),
        .clk(clk),
        .RsAddr(RsAddr),
        .RtAddr(RtAddr),
        .RdAddr(RdAddr),
        .RdData(RdData)
);

    initial begin: Preprocess
        // Initialize inputs
        clk = 0;
        RegWrite = 1;
        RsAddr = 5'd 1; // Register R[1]
        RtAddr = 5'd 3; // R[3]
        RdAddr = 5'd 5; // R[5]
        RdData = 32'h f0f0_0f0f;

		$readmemh(`REG_FILE,regMem);

        // Initialize register file
		for (i = 0; i < `REG_MAX; i = i + 1)
		begin
			Register_File.R[i] = regMem[i];
		end
    end

    initial #20 $finish;

	always	begin : ClockGenerator
		#`DELAY;
		clk <= ~clk;
	end

    initial fork
        #0 RegWrite = 1;
        #0 RsAddr = 5'd 1;
        #0 RtAddr = 5'd 3; 
        #0 RdAddr = 5'd 5;
        #0 RdData = 32'h F0F0_0F0F;

        #10 RegWrite = 0;
        #10 RsAddr = 5'd 5; // to show where R[5] is been written or not.
        #10 RtAddr = 5'd 3; 
        #10 RdAddr = 5'd 17;
        #10 RdData = 32'h 1234_5678;
        #15 RsAddr = 5'd 17; // to show where R[17] is been written or not.
    join

endmodule
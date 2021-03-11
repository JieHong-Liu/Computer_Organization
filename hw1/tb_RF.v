/*
 *	Testbench for Homework 1
 *	Copyright (C) 2021  Lee Kai Xuan or any person belong ESSLab.
 *	All Right Reserved.
 *
 *	This program is free software: you can redistribute it and/or modify
 *	it under the terms of the GNU General Public License as published by
 *	the Free Software Foundation, either version 3 of the License, or
 *	(at your option) any later version.
 *
 *	This program is distributed in the hope that it will be useful,
 *	but WITHOUT ANY WARRANTY; without even the implied warranty of
 *	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *	GNU General Public License for more details.
 *
 *	You should have received a copy of the GNU General Public License
 *	along with this program.  If not, see <https://www.gnu.org/licenses/>.
 *
 *	This file is for people who have taken the cource (1092 Computer
 *	Organizarion) to use.
 *	We (ESSLab) are not responsible for any illegal use.
 *
 *	NOTE	: FOR COMPATIBILITY OF YOUR CODE, PLEASE DONT MODIFY ANY THING
 *			  IN THIS FILE!
 *
 */

// Setting timescale
`timescale 10 ns / 1 ns

// Configuration
`define DELAY			1	// # * timescale
`define REGISTER_SIZE	32	// bit width
`define MAX_REGISTER	32	// index
`define DATA_FILE		"testbench/RF.dat"
`define OUTPUT_FILE		"testbench/tb_RF.out"

// Declaration
`define LOW		1'b0
`define HIGH	1'b1

module tb_RF;

	// Inputs
	reg [4:0] Addr1;
	reg [4:0] Addr2;
	
	// Outputs
	wire [31:0] Src1;
	wire [31:0] Src2;
	
	// Clock
	reg clk = `LOW;
	
	// Testbench variables
	reg [`REGISTER_SIZE-1:0] register [0:`MAX_REGISTER-1];
	integer output_file;
	integer i;
	
	// Instantiate the Unit Under Test (UUT)
	RF UUT(
		// Inputs
		.Addr1(Addr1),
		.Addr2(Addr2),
		// Outputs
		.Src1(Src1),
		.Src2(Src2)
	);
	
	initial
	begin : Preprocess
		// Initialize inputs
		Addr1 = 32'b0;
		Addr2 = 32'b0;

		// Initialize testbench files
		$readmemh(`DATA_FILE, register);
		output_file = $fopen(`OUTPUT_FILE);
		
		// Initialize internal register
		for (i = 0; i < `MAX_REGISTER; i = i + 1)
		begin
			UUT.R[i] = register[i];
		end

		#`DELAY;	// Wait for global reset to finish
	end
	
	always
	begin : ClockGenerator
		#`DELAY;
		clk <= ~clk;
	end
	
	always
	begin : StimuliProcess
		// Start testing
		for (i = 0; i < `MAX_REGISTER; i = i + 1)
		begin
			Addr1 = i[`REGISTER_SIZE-1:0];
			Addr2 = `REGISTER_SIZE'd`MAX_REGISTER-1 - i[`REGISTER_SIZE-1:0];
			@(clk);	// Wait clock
			$display("Addr1:%h, Addr2:%h", Addr1, Addr2);
			$display("Src1:%h, Src2:%h", Src1, Src1);
			$fdisplay(output_file, "%t,%h,%h", $time, Src1, Src2);
		end

		// Close output file for safety
		$fclose(output_file);

		// Stop the simulation
		$stop();
	end

endmodule

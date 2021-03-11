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

// Declarations
`define DELAY			1	// # * timescale
`define REGISTER_SIZE	32	// bit width
`define MAX_REGISTER	32	// index
`define DATA_FILE		"testbench/RF.dat"
`define INPUT_FILE		"testbench/tb_CompALU.in"
`define OUTPUT_FILE		"testbench/tb_CompALU.out"

// Declaration
`define LOW		1'b0
`define HIGH	1'b1

module tb_CompALU;

	// Inputs
	reg [31:0] Instr;
	
	// Outputs
	wire [31:0] Result;
	wire Zero;
	wire Carry;
	
	// Clock
	reg clk = `LOW;

	// Testbench variables
	reg [`REGISTER_SIZE-1:0] register [0:`MAX_REGISTER-1];
	reg [31:0] read_data;
	integer input_file;
	integer output_file;
	integer i;
	
	// Instantiate the Unit Under Test (UUT)
	CompALU UUT(
		// Inputs
		.Instr(Instr),
		// Outputs
		.Result(Result),
		.Zero(Zero),
		.Carry(Carry)
	);
	
	initial
	begin : Preprocess
		// Initialize inputs
		// Format: OpCode_Src1addr_Src2addr_RESERVED_shamt_funct
		Instr = 32'b000000_00000_00000_00000_00000_000000;

		// Initialize testbench files
		$readmemh(`DATA_FILE, register);
		input_file	= $fopen(`INPUT_FILE, "r");
		output_file	= $fopen(`OUTPUT_FILE);
		
		// Initialize internal register
		for (i = 0; i < `MAX_REGISTER; i = i + 1)
		begin
			UUT.Register_File.R[i] = register[i];
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
		while (!$feof(input_file))
		begin
			$fscanf(input_file, "%b\n", read_data);
			@(posedge clk);	// Wait clock
			Instr = read_data;
			@(negedge clk);	// Wait clock
			$display("Instr:%b", read_data);
			$display("Result:%d, Z:%b, C:%b", Result, Zero, Carry);
			$fdisplay(output_file, "%t,%b,%b,%b", $time, Result, Zero, Carry);
		end

		// Close output file for safety
		$fclose(output_file);

		// Stop the simulation
		$stop();
	end
	
endmodule

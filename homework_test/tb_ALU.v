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
`define INPUT_FILE		"testbench/tb_ALU.in"
`define OUTPUT_FILE		"testbench/tb_ALU.out"

// Declaration
`define LOW		1'b0
`define HIGH	1'b1

module tb_ALU;

	// Inputs
	reg [31:0] Src1;
	reg [31:0] Src2;
	reg [4:0] Shamt;
	reg [5:0] Funct;
	
	// Outputs
	wire [31:0] Result;
	wire Zero;
	wire Carry;
	
	// Clock
	reg clk = `LOW;
	
	// Testbench variables
	reg [74:0] read_data;
	integer input_file;
	integer output_file;
	integer i;
	
	// Instantiate the Unit Under Test (UUT)
	ALU UUT(
		// Inputs
		.Src1(Src1),
		.Src2(Src2),
		.Shamt(Shamt),
		.Funct(Funct),
		// Outputs
		.Result(Result),
		.Zero(Zero),
		.Carry(Carry)
	);
	
	initial
	begin : Preprocess
		// Initialize inputs
		Src1	= 32'b0;
		Src2	= 32'b0;
		Shamt	= 5'b0;
		Funct	= 6'b0;

		// Initialize testbench files
		input_file	= $fopen(`INPUT_FILE, "r");
		output_file	= $fopen(`OUTPUT_FILE);

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
			{Src1, Src2, Shamt, Funct} = read_data;
			@(negedge clk);	// Wait clock
			$display("Src1:%b, Src2:%b, Shamt:%b, Funct:%b", Src1, Src2, Shamt, Funct);
			$display("Result:%d, Z:%b, C:%b", Result, Zero, Carry);
			$fdisplay(output_file, "%t,%b,%b,%b", $time, Result, Zero, Carry);
		end

		// Close output file for safety
		$fclose(output_file);

		// Stop the simulation
		$stop();
	end
	
endmodule

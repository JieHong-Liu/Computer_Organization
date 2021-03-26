/*
 *	Testbench for Project 1
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
 *	NOTE	: FOR COMPATIBILITY OF YOUR CODE, PLEASE DONT CHANGE ANY THING
 *			  IN THIS FILE!
 *
 */
 
 // Setting timescale
`timescale 10 ns / 1 ns

// Declarations
`define LOW		1'b0
`define HIGH	1'b1

module tb_SimpleTestbench;

	// Inputs
	reg Reset = `LOW;
	reg W_ctrl = `LOW;
	reg [31:0] Multiplicand_in = 32'b0;
	
	// Outputs
	wire [31:0] Multiplicand_out;
	
	// Clock
	reg clk = `LOW;
	
	// Instantiate the Unit Under Test (UUT)
	Multiplicand UUT(
		// Outputs
		.Multiplicand_out(Multiplicand_out),
		// Inputs
		.Multiplicand_in(Multiplicand_in),
		.Reset(Reset),
		.W_ctrl(W_ctrl)
	);
	
	// Generate Clock
	always
	begin : ClockGenerator
		#1 clk <= ~clk;		// toggle clock signal evergy one timescale delay
	end
	
	initial begin
		// Wait positive edge of clock signal
		@(posedge clk);
		
		// Reset UUT
		Reset <= `HIGH;
		
		// Wait negative edge of clock signal
		@(negedge clk);
		
		// Write data into Multiplicand Register
		Multiplicand_in <= 32'd125;
		W_ctrl <= `HIGH;
		
		// Wait some time
		#2;
		
		// Stop the simulation
		$stop();
	end

endmodule

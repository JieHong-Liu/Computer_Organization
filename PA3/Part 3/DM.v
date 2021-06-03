/*
 *	Template for Project 2 Part 3
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
 */
 
/*
 * Macro of size declaration of data memory
 * CAUTION: DONT MODIFY THE NAME AND VALUE.
 */
`define DATA_MEM_SIZE	128	// Bytes

/*
 * Declaration of Data Memory for this project.
 * CAUTION: DONT MODIFY THE NAME.
 */
module DM(
	// Outputs
	output [31:0] MemReadData, 
	// Inputs
	input [31:0] MemAddr,
	input [31:0] MemWriteData,
	input MemWrite,
	input MemRead,
	input clk
);

	/* 
	 * Declaration of data memory.
	 * CAUTION: DONT MODIFY THE NAME AND SIZE.
	 */
	reg [7:0]DataMem[0:`DATA_MEM_SIZE - 1];

	assign MemReadData = MemRead? {DataMem[MemAddr],DataMem[MemAddr+1],DataMem[MemAddr+2],DataMem[MemAddr+3]}:32'b0;

	always@(posedge clk)
		begin
			if(MemWrite == 1)
				begin
					{DataMem[MemAddr],DataMem[MemAddr+1],DataMem[MemAddr+2],DataMem[MemAddr+3]} = MemWriteData;
				end
			else;
		end

endmodule

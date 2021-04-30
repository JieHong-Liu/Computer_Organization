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
 * Macro of size declaration of instruction memory
 * CAUTION: DONT MODIFY THE NAME AND VALUE.
 */
`define INSTR_MEM_SIZE	128	// Bytes

/*
 * Declaration of Instruction Memory for this project.
 * CAUTION: DONT MODIFY THE NAME.
 */
module IM(
	// Outputs
	output reg [31:0]	Instr,
	// Inputs
	input  [31:0]	InstrAddr
);

	/* 
	 * Declaration of instruction memory.
	 * CAUTION: DONT MODIFY THE NAME AND SIZE.
	 */
	reg [7:0]	InstrMem[0:`INSTR_MEM_SIZE - 1];

	always@(InstrAddr)
		begin
			Instr[31:0] = {InstrMem[InstrAddr], InstrMem[InstrAddr+1],InstrMem[InstrAddr+2],InstrMem[InstrAddr+3]};
		end

endmodule

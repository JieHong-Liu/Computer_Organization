/*
 *	Template for Project 2 Part 1
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
 * Declaration of top entry for this project.
 * CAUTION: DONT MODIFY THE NAME AND I/O DECLARATION.
 */
module R_FormatCPU(
	// Outputs
	output	wire	[31:0]	AddrOut,
	// Inputs
	input	wire	[31:0]	AddrIn,
	input	wire			clk
);
	wire [31:0] Instr;
	wire [31:0] ALU_result;
	wire [31:0] RsData;
	wire [31:0] RtData;
	wire [1:0] ALUOp;
	wire [5:0] Funct;
	wire RegWrite;
	/* 
	 * Declaration of Instruction Memory.
	 * CAUTION: DONT MODIFY THE NAME.
	 */
	IM Instr_Memory(
		// Outputs
		.Instr(Instr),
		// Inputs
		.InstrAddr(AddrIn)
	);

	/* 
	 * Declaration of Register File.
	 * CAUTION: DONT MODIFY THE NAME.
	 */
	RF Register_File(
		// Outputs
		.RsData(RsData),
		.RtData(RtData),
		// Inputs
		.clk(clk),
		.RegWrite(RegWrite),
		.RsAddr(Instr[25:21]),
		.RtAddr(Instr[20:16]),
		.RdAddr(Instr[15:11]),
		.RdData(ALU_result[31:0])
	);

	Adder adder(
		// Outputs
		.AddrOut(AddrOut),
		// Inputs
		.AddrIn(AddrIn)
	);

	ALU alu(
		// Inputs
		.Src1(RsData[31:0]),
		.Src2(RtData[31:0]),
		.Shamt(Instr[10:6]),
		.Funct(Funct[5:0]),
		// Outputs
		.result(ALU_result[31:0])
	);

	Control controller(
		// Inputs
		.OpCode(Instr[31:26]),
		// Outputs
		.RegWrite(RegWrite),
		.ALUOp(ALUOp[1:0])
	);

	ALU_Control ALU_controller(
		// Inputs
		.funct(Instr[5:0]),
		.ALUOp(ALUOp[1:0]),
		// Outputs
		.Funct(Funct[5:0])
	);

endmodule

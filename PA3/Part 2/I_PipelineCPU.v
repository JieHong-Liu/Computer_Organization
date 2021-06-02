/*
 *	Template for Project 3 Part 2
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
module I_PipelineCPU(
	// Outputs
	output	wire	[31:0]	AddrOut,
	// Inputs
	input	wire	[31:0]	AddrIn,
	input	wire			clk
);

//  Instruction Memory	
	wire [31:0] Instr;
	wire [31:0] Instr_out;

// ID/EX.
	wire [31:0] ALU_result;
	wire [31:0] RsData;
	wire [31:0] RsData_out;
	wire [31:0] RtData;
	wire [31:0] RtData_out;
	wire [1:0] ALUOp;
	wire [1:0] ALUOp_out;

	wire [4:0] RdAddr_out;


// EX/MEM
	wire RegWrite_mem_out;
	wire Mem2Reg_out;
	wire [31:0] MemAddr;
	wire [4:0] RdAddr_mem_out;
	wire [31:0] MemWriteData;

// MEM/WB
	wire RegWrite_wb_out;
	wire [31:0] ALU_result_wb_out;
	wire [4:0] RdAddr_wb_out;

// Controller
	wire RegWrite;
	wire RegWrite_out;

	wire RegDst;
	wire RegDst_out;
	
	wire ALUSrc;
	wire ALSrc_out;

	wire MemWrite;
	wire MemWrite_out;

	wire MemRead;
	wire MemRead_out;

	wire MemtoReg;
	wire MemtoReg_out;
// ALUOp
	wire [5:0]Funct;	
// MUX
	wire [31:0]	MUX32A_result;
	wire [31:0]	MUX32B_result;
	wire [4:0]  MUX5_result;

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

	Adder adder(
		// Outputs
		.AddrOut(AddrOut),
		// Inputs
		.AddrIn(AddrIn)
	);

	IF_ID Fetch_Decode(
		.Instr(Instr),
		.InstrOut(Instr_out),
		.clk(clk)
	);

	Control controller(
		.OpCode(Instr_out[31:26]),
		.RegWrite(RegWrite),
		.RegDst(RegDst),
		.ALUSrc(ALUSrc),
		.MemWrite(MemWrite),
		.MemRead(MemRead),
		.MemtoReg(MemtoReg),
		.ALUOp(ALUOp)
	);

	/* 
	 * Declaration of Register File.
	 * CAUTION: DONT MODIFY THE NAME.
	 */
	RF Register_File(
		// Outputs

		// Inputs

	);

endmodule

/*
 *	Template for Project 3 Part 1
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
module R_PipelineCPU(
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
	wire [5:0] funct_out;
	wire [4:0] shamt_out;
	wire [5:0] Funct;
	wire [4:0] RdAddr_out;
	wire RegWrite;
	wire RegWrite_out;

// EX/MEM
	wire RegWrite_mem_out;
	wire [31:0] ALU_result_mem_out;
	wire [4:0] RdAddr_mem_out;


// EX/MEM
	wire RegWrite_wb_out;
	wire [31:0] ALU_result_wb_out;
	wire [4:0] RdAddr_wb_out;




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

	ID_EX Decode_Execute(
		// Inputs
		.RegWrite_in(RegWrite),
		.clk(clk),
		.ALUOp_in(ALUOp),
		.RsData_in(RsData),
		.RtData_in(RtData),
		.funct_in(Instr_out[5:0]),
		.shamt_in(Instr_out[10:6]),
		.RdAddr_in(Instr_out[15:11]),
		// Outputs
		.ALUOp_out(ALUOp_out),
		.RsData_out(RsData_out),
		.RtData_out(RtData_out),
		.funct_out(funct_out),
		.shamt_out(shamt_out),
		.RdAddr_out(RdAddr_out),
		.RegWrite_out(RegWrite_out)
	);

	Control controller(
		// Inputs
		.OpCode(Instr_out[31:26]),
		// Outputs
		.RegWrite(RegWrite), // To ID/EX.
		.ALUOp(ALUOp) // To ID/EX.
	);

	/* 
	 * Declaration of Register File.
	 * CAUTION: DONT MODIFY THE NAME.
	 */
	RF Register_File(
		// Outputs
		.RsData(RsData),// TO ID/EX.
		.RtData(RtData),// TO ID/EX.
		// Inputs
		.clk(clk),
		.RegWrite(RegWrite_wb_out), // From MEM/WB. 
		.RsAddr(Instr_out[25:21]),
		.RtAddr(Instr_out[20:16]),
		.RdAddr(RdAddr_wb_out),
		.RdData(ALU_result_wb_out) // From MEM/WB.
	);

	ALU alu(
		// Inputs
		.Src1(RsData_out),
		.Src2(RtData_out),
		.Shamt(shamt_out),
		.Funct(Funct),
		// Outputs
		.result(ALU_result)
	);

	ALU_Control ALU_controller(
		// Inputs
		.funct(funct_out),
		.ALUOp(ALUOp_out),
		// Outputs
		.Funct(Funct)
	);

	EX_MEM Execute_Memory(
		// Inputs
		.clk(clk),
		.ALU_result_in(ALU_result),
		.RdAddr_in(RdAddr_out),
		.RegWrite_in(RegWrite_out),
		//Outputs
		.RdAddr_out(RdAddr_mem_out),
		.ALU_result_out(ALU_result_mem_out),
		.RegWrite_out(RegWrite_mem_out)
	);

	MEM_WB Memory_WriteBack(
		// Inputs
		.clk(clk),
		.ALU_result_in(ALU_result_mem_out),
		.RdAddr_in(RdAddr_mem_out),
		.RegWrite_in(RegWrite_mem_out),
		//Outputs
		.RdAddr_out(RdAddr_wb_out),
		.ALU_result_out(ALU_result_wb_out),
		.RegWrite_out(RegWrite_wb_out)
	);

endmodule

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
 * Declaration of top entry for this project.
 * CAUTION: DONT MODIFY THE NAME AND I/O DECLARATION.
 */
module SimpleCPU(
	// Outputs
	output	wire	[31:0]	AddrOut,
	// Inputs
	input	wire	[31:0]	AddrIn,
	input	wire			clk
);

	// Adder
		wire [31:0] AdderDataOut1;
		wire [31:0] AdderDataOut2; 

	// ALU
		wire [31:0] ALU_result;	
		wire 		zeroFlag;

	// ALU controller
		wire [5:0] Funct;

	// MUX
		wire [31:0] MUX32A_result;// middle left
		wire [31:0] MUX32B_result;// middle right
		wire [31:0] MUX32C_result;// top left
		wire [31:0] MUX32D_result;// top right
		wire [4:0]  MUX5_result;
		wire [31:0] Sign_Extend; // input for mux and Adder

	// Register File
		wire [31:0] RsData;
		wire [31:0] RtData;

	// Controller
		wire RegWrite;
		wire RegDst;
		wire ALUSrc;
		wire MemWrite;
		wire MemRead;
		wire MemtoReg;
		wire Jump;
		wire Branch;
		wire [1:0] ALUOp;

	// Data Memory
		wire [31:0] MemReadData;
	// IM
		wire [31:0] Instr;


	assign 	Sign_Extend = {16'h0000,Instr[15:0]};

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

	Adder adder1(
		// Outputs
		.DataOut(AdderDataOut1),
		// Inputs
		.Src1(32'd4),
		.Src2(AddrIn)
	);

	Adder adder2(
		// Outputs
		.DataOut(AdderDataOut2),
		// Inputs
		.Src1(AdderDataOut1),
		.Src2(Sign_Extend << 2)
	);

	Mux5b mux5b(
		.Src1(Instr[20:16]),
		.Src2(Instr[15:11]),
		.choose(RegDst),
		.result(MUX5_result)
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
		.RdAddr(MUX5_result),
		.RdData(MUX32B_result)
	);

	Mux32b A32(
		.Src1(RtData),
		.Src2(Sign_Extend),
		.result(MUX32A_result),
		.choose(ALUSrc)
	);

	ALU alu(
		.Src1(RsData),
		.Src2(MUX32A_result),
		.Shamt(Instr[10:6]),
		.Funct(Funct),
		.result(ALU_result),
		.Zero(zeroFlag)
	);

	Mux32b B32(
		.Src1(ALU_result),
		.Src2(MemReadData),
		.choose(MemtoReg),
		.result(MUX32B_result)
	);
	Mux32b C32(
		.Src1(AdderDataOut1),
		.Src2(AdderDataOut2),
		.result(MUX32C_result),
		.choose(Branch & zeroFlag)
	);

	Mux32b D32(
		.Src1(MUX32C_result),
		.Src2({4'b0000,Instr[25:0],2'b00}),// 4 + 26 + 2 = 32;
		.result(AddrOut),
		.choose(Jump)
	);
	/* 
	 * Declaration of Data Memory.
	 * CAUTION: DONT MODIFY THE NAME.
	 */
	DM Data_Memory(
		// Outputs
		.MemReadData(MemReadData),
		// Inputs
		.MemAddr(ALU_result),
		.MemWriteData(RtData),
		.MemWrite(MemWrite),
		.MemRead(MemRead),
		.clk(clk)
	);

	Control controller(
		.OpCode(Instr[31:26]),
		.RegDst(RegDst),
		.Branch(Branch),
		.RegWrite(RegWrite),
		.ALUSrc(ALUSrc),
		.MemWrite(MemWrite),
		.MemRead(MemRead),
		.MemtoReg(MemtoReg),
		.Jump(Jump),
		.ALUOp(ALUOp)
	);
	
	ALU_Control alu_controller(
		.funct(Instr[5:0]),
		.ALUOp(ALUOp),
		.Funct(Funct)
	);
endmodule

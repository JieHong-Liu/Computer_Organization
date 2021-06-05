/*
 *	Template for Project 3 Part 3
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
module FinalCPU(
	// Outputs
	output 	wire 			PCWrite,
	output	wire	[31:0]	AddrOut,
	// Inputs
	input	wire	[31:0]	AddrIn,
	input	wire			clk
);

// HazardDetectionUnit
	wire Stall;
	wire IF_ID_Write;

// Forwarding Unit
	wire [1:0] ForwardA;
	wire [1:0] ForwardB;
	wire [31:0] MUX3to1A_result;
	wire [31:0] MUX3to1B_result;
//  Instruction Memory	
	wire [31:0] Instr;
	wire [31:0] Instr_out;
// ID/EX.

	// WB

	wire RegWrite;
	wire RegWrite_in; // MUXSTALL
	wire RegWrite_out;
	wire MemtoReg;
	wire MemtoReg_in;
	wire MemtoReg_out;
	// memory.
	wire MemWrite;
	wire MemWrite_in;
	wire MemWrite_out;

	wire MemRead;
	wire MemRead_in;
	wire MemRead_out;

	// EX.
	wire [1:0] ALUOp;
	wire [1:0] ALUOp_in;
	wire [1:0] ALUOp_out;

	wire RegDst;
	wire RegDst_in;
	wire RegDst_out;
	
	wire ALUSrc;
	wire ALUSrc_in;
	wire ALUSrc_out;

	// Others.
	wire [31:0] RsData;
	wire [31:0] RsData_out;
	wire [31:0] RtData;
	wire [31:0] RtData_out;
	wire [31:0] Sign_Extend; // immediate_in
	wire [31:0] immediate_out; 
	wire [4:0] RdAddr_out;
	wire [4:0] RtAddr_out;
	wire [4:0] RsAddr_out;
// EX/MEM

	//WB.
	wire RegWrite_mem_out;
	wire MemtoReg_mem_out;
	//Memory
	wire MemWrite_mem_out;
	wire MemRead_mem_out;
	// Others.
	wire [31:0] ALU_result;
	wire [31:0] MemAddr;

	wire [31:0] MemWriteData; // RtData_out

	wire [4:0] RdAddr_mem_out;

// MEM/WB

	// WB.
	wire RegWrite_wb_out;
	wire MemtoReg_wb_out;
	// Others
	wire [31:0] MemAddr_wb_out;
	wire [4:0] RdAddr_wb_out;
	wire [31:0] MemReadData;
	wire [31:0] MemReadData_wb_out;



// ALU controller
	wire [5:0]Funct;	
// MUX
	wire [4:0]  MUX5_result;

	wire [31:0]	MUX32A_result;
	wire [31:0] MUX32B_result;
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
		.IF_ID_Write(IF_ID_Write),
		.clk(clk)
	);

	HazardDetectionUnit HDU(
		// Inputs.
		.ID_EX_MemRead(MemRead_out),
		.ID_EX_RegisterRt(RtAddr_out),
		.IF_ID_RegisterRs(Instr_out[25:21]),
		.IF_ID_RegisterRt(Instr_out[20:16]),
		// Outputs
		.Stall(Stall),
		.PCWrite(PCWrite),
		.IF_ID_Write(IF_ID_Write)
	);

	Control controller(
		// Inputs
		.OpCode(Instr_out[31:26]),
		// Outputs
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
		.RsData(RsData),// TO ID/EX.
		.RtData(RtData),// TO ID/EX.
		// Inputs
		.clk(clk),
		.RegWrite(RegWrite_wb_out), // From MEM/WB. 
		.RsAddr(Instr_out[25:21]),
		.RtAddr(Instr_out[20:16]),
		.RdAddr(RdAddr_wb_out),
		.RdData(MUX32B_result) // From MEM/WB.
	);
	assign Sign_Extend[31:0] = Instr_out[15]?{16'hFFFF,Instr_out[15:0]}:{16'h0000,Instr_out[15:0]};

	MuxStall MS(
		// inputs.
		.RegDst_in(RegDst),
		.MemRead_in(MemRead),
		.MemtoReg_in(MemtoReg),
		.ALUOp_in(ALUOp),
		.MemWrite_in(MemWrite),
		.ALUSrc_in(ALUSrc),
		.RegWrite_in(RegWrite),
		.Stall_choose(Stall),
		// Outputs
		.RegDst_out(RegDst_in),
		.MemRead_out(MemRead_in),
		.MemtoReg_out(MemtoReg_in),
		.ALUOp_out(ALUOp_in),
		.MemWrite_out(MemWrite_in),
		.ALUSrc_out(ALUSrc_in),
		.RegWrite_out(RegWrite_in)
	);

	ID_EX Decode_Execute(
		// Inputs
		.clk(clk),
		//WB
			.RegWrite_in(RegWrite_in),
			.Mem2Reg_in(MemtoReg_in),
		// Memory
			.MemRead_in(MemRead_in),
			.MemWrite_in(MemWrite_in),
		// EX
			.ALUOp_in(ALUOp_in),
			.RegDst_in(RegDst_in),
			.ALU_Src_in(ALUSrc_in),
		// Others.
			.RsData_in(RsData),
			.RtData_in(RtData),
			.immediate_in(Sign_Extend),
			.RdAddr_in(Instr_out[15:11]),
			.RtAddr_in(Instr_out[20:16]),
			.RsAddr_in(Instr_out[25:21]),
		// Outputs

		//WB
			.RegWrite_out(RegWrite_out),
			.Mem2Reg_out(MemtoReg_out),
		// Memory
			.MemRead_out(MemRead_out),
			.MemWrite_out(MemWrite_out),
		// EX
			.ALUOp_out(ALUOp_out),
			.RegDst_out(RegDst_out),
			.ALU_Src_out(ALUSrc_out),
		// Others
			.RsData_out(RsData_out),
			.RtData_out(RtData_out),
			.immediate_out(immediate_out),
			.RdAddr_out(RdAddr_out),
			.RtAddr_out(RtAddr_out),
			.RsAddr_out(RsAddr_out)
	);

	MUX3to1 A(
		.Src1(RsData_out),
		.Src2(MUX32B_result),
		.Src3(MemAddr),
		.choose(ForwardA),
		.result(MUX3to1A_result)
	);

	MUX3to1 B(
		.Src1(RtData_out),
		.Src2(MUX32B_result),
		.Src3(MemAddr),
		.choose(ForwardB),
		.result(MUX3to1B_result)
	);

	Mux32b A32(
		.Src1(MUX3to1B_result),
		.Src2(immediate_out),
		.result(MUX32A_result),
		.choose(ALUSrc_out)
	);

	ALU alu(
		// Inputs
		.Src1(MUX3to1A_result),
		.Src2(MUX32A_result),
		.Shamt(immediate_out[10:6]),
		.Funct(Funct),
		// Outputs
		.result(ALU_result)
	);

	ALU_Control ALU_controller(
		// Inputs
		.funct(immediate_out[5:0]),
		.ALUOp(ALUOp_out),
		// Outputs
		.Funct(Funct)
	);

	Mux5b mux5b(
		.Src1(RtAddr_out),
		.Src2(RdAddr_out),
		.choose(RegDst_out),
		.result(MUX5_result)
	);

	ForwardingUnit FU(
		.EX_MEM_RegWrite(RegWrite_mem_out),
		.EX_MEM_RegisterRd(RdAddr_mem_out),
		.ID_EX_RegisterRs(RsAddr_out),
		.ID_EX_RegisterRt(RtAddr_out),
		.MEM_WB_RegWrite(RegWrite_wb_out),
		.MEM_WB_RegisterRd(RdAddr_wb_out),
		.ForwardA(ForwardA[1:0]),
		.ForwardB(ForwardB[1:0])
	);

	EX_MEM Execute_Memory(
		// Inputs
			.clk(clk),
		// WB
			.RegWrite_in(RegWrite_out),
			.Mem2Reg_in(MemtoReg_out),
		// MEM
			.MemRead_in(MemRead_out),
			.MemWrite_in(MemWrite_out),
		// Others
			.ALU_result_in(ALU_result),
			.RtData_in(MUX3to1B_result),
			.RdAddr_in(MUX5_result),
			
		//Outputs

		// WB
			.RegWrite_out(RegWrite_mem_out),
			.Mem2Reg_out(MemtoReg_mem_out),
		// Memory
			.MemRead_out(MemRead_mem_out),
			.MemWrite_out(MemWrite_mem_out),
		// Others
			.ALU_result_out(MemAddr),
			.RtData_out(MemWriteData),
			.RdAddr_out(RdAddr_mem_out)
	);

	
	DM Data_Memory(
		// Outputs
		.MemReadData(MemReadData),
		// Inputs
		.MemAddr(MemAddr),
		.MemWriteData(MemWriteData),
		.MemWrite(MemWrite_mem_out),
		.MemRead(MemRead_mem_out),
		.clk(clk)
	);

	MEM_WB Memory_WriteBack(
		// Inputs
		.clk(clk),
		// WB
			.RegWrite_in(RegWrite_mem_out),
			.Mem2Reg_in(MemtoReg_mem_out),
		// Others.
			.MemAddr_in(MemAddr),
			.MemReadData_in(MemReadData),
			.RdAddr_in(RdAddr_mem_out),
	
		//Outputs

		//WB
			.RegWrite_out(RegWrite_wb_out),
			.Mem2Reg_out(MemtoReg_wb_out),
		// Others
			.MemAddr_out(MemAddr_wb_out),
			.MemReadData_out(MemReadData_wb_out),
			.RdAddr_out(RdAddr_wb_out)
	);

	Mux32b B32(
		.Src1(MemAddr_wb_out),
		.Src2(MemReadData_wb_out),
		.result(MUX32B_result),
		.choose(MemtoReg_wb_out)
	);


endmodule


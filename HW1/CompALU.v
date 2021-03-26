/*
 *	Template for Homework 1
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
module CompALU(
	//	Outputs
	Result, Zero, Carry,
	//	Inputs
	Instr
);
// Ports declaration
input Instr;
output Result,Zero, Carry;

// Type declaration

wire [31:0] Instr;
wire [31:0] Result;
wire [31:0] inner_Src1;
wire [31:0] inner_Src2;
/* 
* Declaration of Register File.
* CAUTION: DONT MODIFY THE NAME.
*/
RF Register_File(
    //Inputs
    .Addr1(Instr[25:21]),
    .Addr2(Instr[20:16]),
    //Outputs
    .Src1(inner_Src1),
    .Src2(inner_Src2)
);

ALU Arithemetic_Logical_Unit(
    //Inputs
    .Src1(inner_Src1),
    .Src2(inner_Src2),
    .Shamt(Instr[10:6]),
    .Funct(Instr[5:0]),
    .Zero(Zero),
    .Carry(Carry),
    //Outputs
    .Result(Result)
);


endmodule



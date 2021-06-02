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
 * Macro of size declaration of register memory
 * CAUTION: DONT MODIFY THE NAME AND VALUE.
 */
`define REG_MEM_SIZE	32	// Words

/*
 * Declaration of Register File for this project.
 * CAUTION: DONT MODIFY THE NAME.
 */
module RF(
	// Outputs
	output [31:0] RsData,
	output [31:0] RtData,
	// Inputs
	input RegWrite,
	input clk,
	input [4:0]	 RsAddr,
	input [4:0]	 RtAddr,
	input [4:0]	 RdAddr,
	input [31:0] RdData
);

	/* 
	 * Declaration of inner register.
	 * CAUTION: DONT MODIFY THE NAME AND SIZE.
	 */
	reg [31:0]R[0:`REG_MEM_SIZE - 1];
	
	assign	RsData 	= R[RsAddr];
	assign	RtData 	= R[RtAddr];
	
	always@(posedge clk)
		begin		
			if(RegWrite == 1)
				begin
					R[RdAddr] = RdData;
				end
			else
				begin
					R[RdAddr] = R[RdAddr];
				end
		end


endmodule

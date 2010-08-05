`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    05:55:41 10/14/2008 
// Design Name: 
// Module Name:    rom 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module audi_rom (
	i_rom_address , // Address input(input)
	o_rom_data ,    // Data output (output)
	c_rom_read_en , // Read Enable (control)
	c_rom_ce        // Chip Enable (control)
	);
	
	parameter M1 = 12;
	parameter M2 = 4;
	
	input [M2-1:0] i_rom_address;
	wire [M2-1:0] i_rom_address;
	
	input c_rom_read_en;
	wire c_rom_read_en;
	
	input c_rom_ce;
	wire c_rom_ce;
	
	output [M1-1:0] o_rom_data;
	wire [M1-1:0] o_rom_data;
	
	reg [M1-1:0] rom_mem_reg;
	
	assign o_rom_data = rom_mem_reg;
	
	always @ (c_rom_read_en or i_rom_address) begin 
		case(i_rom_address)
		  //7 bit representation of angles
			4'b0000: rom_mem_reg <= 12'b001011010000;   //45.0000
			4'b0001: rom_mem_reg <= 12'b000110101001;   //26.5651
			4'b0010: rom_mem_reg <= 12'b000011100000;   //14.0362
			4'b0011: rom_mem_reg <= 12'b000001110010;   //7.1250
			4'b0100: rom_mem_reg <= 12'b000000111001;   //3.5763
			4'b0101: rom_mem_reg <= 12'b000000011100;   //1.7899
			4'b0110: rom_mem_reg <= 12'b000000001110;   //0.8952
			4'b0111: rom_mem_reg <= 12'b000000000111;   //0.4476
			4'b1000: rom_mem_reg <= 12'b000000000011;   //0.2238
			4'b1001: rom_mem_reg <= 12'b000000000001;   //0.1119
		endcase 
	end
endmodule
  
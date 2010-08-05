`include "00defines.v"


/*Defines have been used to specify address and data widths. use 00defines.v with this.
Twiddle factors of size DATA_WIDTH are stored in ADD_WIDTH locations.
This is a hardcoded file since this is specific to N=64
The ROM_Generator Program might help. Infact, check whether the addwidths and datawidths are matching with the defines and the program!
*/
module ROM (
i_rom_address , // Address input(input)
o_rom_data    , // Data output  (output)
c_rom_read_en , // Read Enable  (control)
c_rom_ce      , // Chip Enable  (control)
c_rom_tri_output//tristate cotrol
);

input [`ROM_ADD_WIDTH - 1:0] i_rom_address;
input c_rom_read_en; 
input c_rom_ce;
input c_rom_tri_output;
output [`ROM_DATA_WIDTH - 1:0] o_rom_data;

wire [`ROM_ADD_WIDTH - 1:0] i_rom_address;
wire c_rom_read_en;
wire c_rom_ce;
wire c_rom_tri_output;
wire [`ROM_DATA_WIDTH -1:0] o_rom_data; //CAUTION: Output wired!!

reg [`ROM_DATA_WIDTH -1:0] rom_mem_reg;

assign o_rom_data = (~c_rom_tri_output) ? rom_mem_reg : `ROM_DATA_WIDTH'bz;

always @ (c_rom_read_en or i_rom_address or c_rom_ce)
begin
	if(~c_rom_ce)
		rom_mem_reg <= `ROM_DATA_WIDTH'bz;
	else case(i_rom_address)
		`ROM_ADD_WIDTH'b000000:	rom_mem_reg <= `ROM_DATA_WIDTH'b0111111111111111;
		`ROM_ADD_WIDTH'b000001:	rom_mem_reg <= `ROM_DATA_WIDTH'b0000000000000000;
		`ROM_ADD_WIDTH'b000010:	rom_mem_reg <= `ROM_DATA_WIDTH'b0111111101100010;
		`ROM_ADD_WIDTH'b000011:	rom_mem_reg <= `ROM_DATA_WIDTH'b1111001101110101;
		`ROM_ADD_WIDTH'b000100:	rom_mem_reg <= `ROM_DATA_WIDTH'b0111110110001010;
		`ROM_ADD_WIDTH'b000101:	rom_mem_reg <= `ROM_DATA_WIDTH'b1110011100001000;
		`ROM_ADD_WIDTH'b000110:	rom_mem_reg <= `ROM_DATA_WIDTH'b0111101001111101;
		`ROM_ADD_WIDTH'b000111:	rom_mem_reg <= `ROM_DATA_WIDTH'b1101101011011000;
		`ROM_ADD_WIDTH'b001000:	rom_mem_reg <= `ROM_DATA_WIDTH'b0111011001000001;
		`ROM_ADD_WIDTH'b001001:	rom_mem_reg <= `ROM_DATA_WIDTH'b1100111100000101;
		`ROM_ADD_WIDTH'b001010:	rom_mem_reg <= `ROM_DATA_WIDTH'b0111000011100010;
		`ROM_ADD_WIDTH'b001011:	rom_mem_reg <= `ROM_DATA_WIDTH'b1100001110101010;
		`ROM_ADD_WIDTH'b001100:	rom_mem_reg <= `ROM_DATA_WIDTH'b0110101001101101;
		`ROM_ADD_WIDTH'b001101:	rom_mem_reg <= `ROM_DATA_WIDTH'b1011100011100100;
		`ROM_ADD_WIDTH'b001110:	rom_mem_reg <= `ROM_DATA_WIDTH'b0110001011110001;
		`ROM_ADD_WIDTH'b001111:	rom_mem_reg <= `ROM_DATA_WIDTH'b1010111011001101;
		`ROM_ADD_WIDTH'b010000:	rom_mem_reg <= `ROM_DATA_WIDTH'b0101101010000010;
		`ROM_ADD_WIDTH'b010001:	rom_mem_reg <= `ROM_DATA_WIDTH'b1010010101111110;
		`ROM_ADD_WIDTH'b010010:	rom_mem_reg <= `ROM_DATA_WIDTH'b0101000100110011;
		`ROM_ADD_WIDTH'b010011:	rom_mem_reg <= `ROM_DATA_WIDTH'b1001110100001110;
		`ROM_ADD_WIDTH'b010100:	rom_mem_reg <= `ROM_DATA_WIDTH'b0100011100011100;
		`ROM_ADD_WIDTH'b010101:	rom_mem_reg <= `ROM_DATA_WIDTH'b1001010110010011;
		`ROM_ADD_WIDTH'b010110:	rom_mem_reg <= `ROM_DATA_WIDTH'b0011110001010110;
		`ROM_ADD_WIDTH'b010111:	rom_mem_reg <= `ROM_DATA_WIDTH'b1000111100011110;
		`ROM_ADD_WIDTH'b011000:	rom_mem_reg <= `ROM_DATA_WIDTH'b0011000011111011;
		`ROM_ADD_WIDTH'b011001:	rom_mem_reg <= `ROM_DATA_WIDTH'b1000100110111111;
		`ROM_ADD_WIDTH'b011010:	rom_mem_reg <= `ROM_DATA_WIDTH'b0010010100100111;
		`ROM_ADD_WIDTH'b011011:	rom_mem_reg <= `ROM_DATA_WIDTH'b1000010110000011;
		`ROM_ADD_WIDTH'b011100:	rom_mem_reg <= `ROM_DATA_WIDTH'b0001100011111000;
		`ROM_ADD_WIDTH'b011101:	rom_mem_reg <= `ROM_DATA_WIDTH'b1000001001110110;
		`ROM_ADD_WIDTH'b011110:	rom_mem_reg <= `ROM_DATA_WIDTH'b0000110010001011;
		`ROM_ADD_WIDTH'b011111:	rom_mem_reg <= `ROM_DATA_WIDTH'b1000000010011110;
		`ROM_ADD_WIDTH'b100000:	rom_mem_reg <= `ROM_DATA_WIDTH'b0000000000000000;
		`ROM_ADD_WIDTH'b100001:	rom_mem_reg <= `ROM_DATA_WIDTH'b1000000000000000;
		`ROM_ADD_WIDTH'b100010:	rom_mem_reg <= `ROM_DATA_WIDTH'b1111001101110101;
		`ROM_ADD_WIDTH'b100011:	rom_mem_reg <= `ROM_DATA_WIDTH'b1000000010011110;
		`ROM_ADD_WIDTH'b100100:	rom_mem_reg <= `ROM_DATA_WIDTH'b1110011100001000;
		`ROM_ADD_WIDTH'b100101:	rom_mem_reg <= `ROM_DATA_WIDTH'b1000001001110110;
		`ROM_ADD_WIDTH'b100110:	rom_mem_reg <= `ROM_DATA_WIDTH'b1101101011011000;
		`ROM_ADD_WIDTH'b100111:	rom_mem_reg <= `ROM_DATA_WIDTH'b1000010110000100;
		`ROM_ADD_WIDTH'b101000:	rom_mem_reg <= `ROM_DATA_WIDTH'b1100111100000101;
		`ROM_ADD_WIDTH'b101001:	rom_mem_reg <= `ROM_DATA_WIDTH'b1000100110111111;
		`ROM_ADD_WIDTH'b101010:	rom_mem_reg <= `ROM_DATA_WIDTH'b1100001110101010;
		`ROM_ADD_WIDTH'b101011:	rom_mem_reg <= `ROM_DATA_WIDTH'b1000111100011110;
		`ROM_ADD_WIDTH'b101100:	rom_mem_reg <= `ROM_DATA_WIDTH'b1011100011100011;
		`ROM_ADD_WIDTH'b101101:	rom_mem_reg <= `ROM_DATA_WIDTH'b1001010110010011;
		`ROM_ADD_WIDTH'b101110:	rom_mem_reg <= `ROM_DATA_WIDTH'b1010111011001101;
		`ROM_ADD_WIDTH'b101111:	rom_mem_reg <= `ROM_DATA_WIDTH'b1001110100001111;
		`ROM_ADD_WIDTH'b110000:	rom_mem_reg <= `ROM_DATA_WIDTH'b1010010101111110;
		`ROM_ADD_WIDTH'b110001:	rom_mem_reg <= `ROM_DATA_WIDTH'b1010010101111110;
		`ROM_ADD_WIDTH'b110010:	rom_mem_reg <= `ROM_DATA_WIDTH'b1001110100001110;
		`ROM_ADD_WIDTH'b110011:	rom_mem_reg <= `ROM_DATA_WIDTH'b1010111011001101;
		`ROM_ADD_WIDTH'b110100:	rom_mem_reg <= `ROM_DATA_WIDTH'b1001010110010011;
		`ROM_ADD_WIDTH'b110101:	rom_mem_reg <= `ROM_DATA_WIDTH'b1011100011100100;
		`ROM_ADD_WIDTH'b110110:	rom_mem_reg <= `ROM_DATA_WIDTH'b1000111100011110;
		`ROM_ADD_WIDTH'b110111:	rom_mem_reg <= `ROM_DATA_WIDTH'b1100001110101010;
		`ROM_ADD_WIDTH'b111000:	rom_mem_reg <= `ROM_DATA_WIDTH'b1000100110111111;
		`ROM_ADD_WIDTH'b111001:	rom_mem_reg <= `ROM_DATA_WIDTH'b1100111100000101;
		`ROM_ADD_WIDTH'b111010:	rom_mem_reg <= `ROM_DATA_WIDTH'b1000010110000011;
		`ROM_ADD_WIDTH'b111011:	rom_mem_reg <= `ROM_DATA_WIDTH'b1101101011011001;
		`ROM_ADD_WIDTH'b111100:	rom_mem_reg <= `ROM_DATA_WIDTH'b1000001001110110;
		`ROM_ADD_WIDTH'b111101:	rom_mem_reg <= `ROM_DATA_WIDTH'b1110011100001000;
		`ROM_ADD_WIDTH'b111110:	rom_mem_reg <= `ROM_DATA_WIDTH'b1000000010011110;
		`ROM_ADD_WIDTH'b111111:	rom_mem_reg <= `ROM_DATA_WIDTH'b1111001101110101;

	endcase
end

endmodule


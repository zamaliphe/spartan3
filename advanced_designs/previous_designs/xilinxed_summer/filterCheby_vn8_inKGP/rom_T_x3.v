/*
theja@mit.edu
v32:2009-05-28
 this is the basic rom file which will be modified to host the Ti's
*/
module rom_T_x3 (
i_rom_address , // Address input(input)
o_rom_data    , // Data output  (output)
c_rom_read_en , // Read Enable  (control)
c_rom_ce      , // Chip Enable  (control)
c_rom_tri_output//tristate cotrol
);

input [3-1:0] i_rom_address;
input c_rom_read_en; 
input c_rom_ce;
input c_rom_tri_output;
output [16-1:0] o_rom_data;

wire [3-1:0] i_rom_address;
wire c_rom_read_en;
wire c_rom_ce;
wire c_rom_tri_output;
wire [16-1:0] o_rom_data; //CAUTION: Output wired!!

reg [16-1:0] rom_mem_reg;

assign o_rom_data = (~c_rom_tri_output) ? rom_mem_reg : 16'bz;

always @ (c_rom_read_en or i_rom_address or c_rom_ce)
begin
	if(~c_rom_ce)
		rom_mem_reg <= 16'bz;
	else case(i_rom_address)
3'b000: rom_mem_reg <= 16'h7FFF;//T(0)_x(3) . Single Quotes Missing!
3'b001: rom_mem_reg <= 16'hF000;//T(1)_x(3) . Single Quotes Missing!
3'b010: rom_mem_reg <= 16'h8400;//T(2)_x(3) . Single Quotes Missing!
3'b011: rom_mem_reg <= 16'h2EFF;//T(3)_x(3) . Single Quotes Missing!
3'b100: rom_mem_reg <= 16'h703F;//T(4)_x(3) . Single Quotes Missing!
3'b101: rom_mem_reg <= 16'hB4F0;//T(5)_x(3) . Single Quotes Missing!
3'b110: rom_mem_reg <= 16'hA284;//T(6)_x(3) . Single Quotes Missing!
3'b111: rom_mem_reg <= 16'h626E;//T(7)_x(3) . Single Quotes Missing!
	endcase
end

endmodule
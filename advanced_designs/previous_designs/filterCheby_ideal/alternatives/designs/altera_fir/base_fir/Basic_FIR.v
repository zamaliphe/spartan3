module Basic_FIR(
	clock,
	reset,
	clk_ena,
	data_in,
	fir_result
);

input	clock;
input	reset;
input	clk_ena;
input	[17:0] data_in;
output	[37:0] fir_result;

wire	[17:0] coeff_0;
wire	[17:0] coeff_1;
wire	[17:0] coeff_2;
wire	[17:0] coeff_3;
wire	[17:0] coeff_4;
wire	[17:0] coeff_5;
wire	[17:0] coeff_6;
wire	[17:0] coeff_7;
wire	[37:0] mult_add_result0;
wire	[37:0] mult_add_result1;
wire	[17:0] shift_data;

mult_add	mult_add_1(.clock0(clock),.aclr3(reset),.ena0(clk_ena),.dataa_0(data_in),.datab_0(coeff_0),.datab_1(coeff_1),.datab_2(coeff_2),.datab_3(coeff_3),.result(mult_add_result0),.shiftouta(shift_data));

mult_add	mult_add_2(.clock0(clock),.aclr3(reset),.ena0(clk_ena),.dataa_0(shift_data),.datab_0(coeff_4),.datab_1(coeff_5),.datab_2(coeff_6),.datab_3(coeff_7),.result(mult_add_result1));

coeff_rom_0_7	coeff_rom_0(.clock(clock),.address(0),.q(coeff_0));

coeff_rom_1_6	coeff_rom_1(.clock(clock),.address(0),.q(coeff_1));

coeff_rom_2_5	coeff_rom_2(.clock(clock),.address(0),.q(coeff_2));

coeff_rom_3_4	coeff_rom_3(.clock(clock),.address(0),.q(coeff_3));

coeff_rom_3_4	coeff_rom_4(.clock(clock),.address(0),.q(coeff_4));

coeff_rom_2_5	coeff_rom_5(.clock(clock),.address(0),.q(coeff_5));

coeff_rom_1_6	coeff_rom_6(.clock(clock),.address(0),.q(coeff_6));

coeff_rom_0_7	coeff_rom_7(.clock(clock),.address(0),.q(coeff_7));

adder	adder_1(.clock(clock),.dataa(mult_add_result0),.datab(mult_add_result1),.result(fir_result));

endmodule

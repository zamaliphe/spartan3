module citi (xin, yout, clk30x, timing, rst);

input [15:0] xin;	//will be the coefficients
input [32-1:0] timing;
output [15:0] yout;	//will be the interplated values
input clk30x;		//required to do the sequential multiplication
input rst;

reg [15:0] yout;
wire [32-1:0] timing;
wire [15:0] xin;
wire clk30x;
wire rst;

//filter related
wire [16-1:0] coeff [0:7];
wire [16-1:0] intermediate[0:7];
wire [16-1:0] outputword_pe[0:7];
wire [16-1:0] loop_selector[0:7];
reg [16-1:0] xin_d[0:7];
reg [16-1:0] prevOutputword_pe[0:7];
wire busy_coeff[0:7];
reg [32-1:0] count;
reg [2:0] wordIndex;
wire [2:0] romAddr[0:7];
wire [16-1:0] youtWire;
wire start_mult;
reg c_rom_read_en;
reg c_rom_ce;
reg c_rom_tri_output;

mult m0(intermediate[0],xin_d[0],coeff[0],clk30x,busy_coeff[0],start_mult);
mult m1(intermediate[1],xin_d[1],coeff[1],clk30x,busy_coeff[1],start_mult);
mult m2(intermediate[2],xin_d[2],coeff[2],clk30x,busy_coeff[2],start_mult);
mult m3(intermediate[3],xin_d[3],coeff[3],clk30x,busy_coeff[3],start_mult);
mult m4(intermediate[4],xin_d[4],coeff[4],clk30x,busy_coeff[4],start_mult);
mult m5(intermediate[5],xin_d[5],coeff[5],clk30x,busy_coeff[5],start_mult);
mult m6(intermediate[6],xin_d[6],coeff[6],clk30x,busy_coeff[6],start_mult);
mult m7(intermediate[7],xin_d[7],coeff[7],clk30x,busy_coeff[7],start_mult);

multALU adder0(outputword_pe[0], intermediate[0], loop_selector[0], 1'b0);
multALU adder1(outputword_pe[1], intermediate[1], loop_selector[1], 1'b0);
multALU adder2(outputword_pe[2], intermediate[2], loop_selector[2], 1'b0);
multALU adder3(outputword_pe[3], intermediate[3], loop_selector[3], 1'b0);
multALU adder4(outputword_pe[4], intermediate[4], loop_selector[4], 1'b0);
multALU adder5(outputword_pe[5], intermediate[5], loop_selector[5], 1'b0);
multALU adder6(outputword_pe[6], intermediate[6], loop_selector[6], 1'b0);
multALU adder7(outputword_pe[7], intermediate[7], loop_selector[7], 1'b0);


rom_T_x0 r0( romAddr[0] , coeff[0], c_rom_read_en , c_rom_ce, c_rom_tri_output);
rom_T_x1 r1( romAddr[1] , coeff[1], c_rom_read_en , c_rom_ce, c_rom_tri_output);
rom_T_x2 r2( romAddr[2] , coeff[2], c_rom_read_en , c_rom_ce, c_rom_tri_output);
rom_T_x3 r3( romAddr[3] , coeff[3], c_rom_read_en , c_rom_ce, c_rom_tri_output);
rom_T_x4 r4( romAddr[4] , coeff[4], c_rom_read_en , c_rom_ce, c_rom_tri_output);
rom_T_x5 r5( romAddr[5] , coeff[5], c_rom_read_en , c_rom_ce, c_rom_tri_output);
rom_T_x6 r6( romAddr[6] , coeff[6], c_rom_read_en , c_rom_ce, c_rom_tri_output);
rom_T_x7 r7( romAddr[7] , coeff[7], c_rom_read_en , c_rom_ce, c_rom_tri_output);

assign romAddr[0] = wordIndex + 3'b000;
assign romAddr[1] = wordIndex + 3'b111;
assign romAddr[2] = wordIndex + 3'b110;
assign romAddr[3] = wordIndex + 3'b101;
assign romAddr[4] = wordIndex + 3'b100;
assign romAddr[5] = wordIndex + 3'b011;
assign romAddr[6] = wordIndex + 3'b010;
assign romAddr[7] = wordIndex + 3'b001;

assign start_mult = (count==0)?1:0;
assign youtWire = (wordIndex==7)?outputword_pe[0]:(wordIndex==0)?outputword_pe[1]:
					(wordIndex==1)?outputword_pe[2]:(wordIndex==2)?outputword_pe[3]:
					(wordIndex==3)?outputword_pe[4]:(wordIndex==4)?outputword_pe[5]:
					(wordIndex==5)?outputword_pe[6]:outputword_pe[7];

//
assign loop_selector[0] = (wordIndex== 0)?0:prevOutputword_pe[0];
assign loop_selector[1] = (wordIndex== 1)?0:prevOutputword_pe[1];
assign loop_selector[2] = (wordIndex== 2)?0:prevOutputword_pe[2];
assign loop_selector[3] = (wordIndex== 3)?0:prevOutputword_pe[3];
assign loop_selector[4] = (wordIndex== 4)?0:prevOutputword_pe[4];
assign loop_selector[5] = (wordIndex== 5)?0:prevOutputword_pe[5];
assign loop_selector[6] = (wordIndex== 6)?0:prevOutputword_pe[6];
assign loop_selector[7] = (wordIndex== 7)?0:prevOutputword_pe[7];


always @ (posedge clk30x)
begin
	if (rst==1)
	begin
		count 	 <=-1;
		wordIndex<= 0;
		yout 	 <= 0;
		xin_d[0] <= 0;
		xin_d[1] <= 0;
		xin_d[2] <= 0;
		xin_d[3] <= 0;
		xin_d[4] <= 0;
		xin_d[5] <= 0;
		xin_d[6] <= 0;
		xin_d[7] <= 0;
		prevOutputword_pe[0]	<= 0;
		prevOutputword_pe[1]	<= 0;
		prevOutputword_pe[2]	<= 0;
		prevOutputword_pe[3]	<= 0;
		prevOutputword_pe[4]	<= 0;
		prevOutputword_pe[5]	<= 0;
		prevOutputword_pe[6]	<= 0;
		prevOutputword_pe[7]	<= 0;
		c_rom_read_en		<= 0;
		c_rom_ce			<= 0;
		c_rom_tri_output	<= 1;
	end
	else
	begin
		c_rom_read_en	<= 1;
		c_rom_ce		<= 1;
		c_rom_tri_output<= 0;
		xin_d[0]	<= xin;
		
		if(count!=timing)//some random count actually. Am lazy to know the exact counting required for the seq. mults to work.
		begin
			count <= count + 1;
		end
		else
		begin
			count <= 0;
			wordIndex <= wordIndex + 1'b1;
			
			xin_d[1] 	<= xin_d[0];
			xin_d[2]	<= xin_d[1];
			xin_d[3]	<= xin_d[2];
			xin_d[4]	<= xin_d[3];
			xin_d[5]	<= xin_d[4];
			xin_d[6]	<= xin_d[5];
			xin_d[7]	<= xin_d[6];
			yout 		<= youtWire;
			
			prevOutputword_pe[0] <= outputword_pe[0];
			prevOutputword_pe[1] <= outputword_pe[1];
			prevOutputword_pe[2] <= outputword_pe[2];
			prevOutputword_pe[3] <= outputword_pe[3];
			prevOutputword_pe[4] <= outputword_pe[4];
			prevOutputword_pe[5] <= outputword_pe[5];
			prevOutputword_pe[6] <= outputword_pe[6];
			prevOutputword_pe[7] <= outputword_pe[7];
		end
	end
end
endmodule

/*
v1: 2009-05-28 this is a systolic element only. Uses `include to put the right coeffs.
also makes use of mult and multALU units.


v0 2009-05-26: not taking care of positioning (2t/L-1)

*/
module systolic_PE1(inputword,outputword,clk30x, reset);

parameter WORDLENGTH = 16;


//IO Declarations
input clk30x;	//clock for input word
input reset;	//resets the module, active high, synchronous
input [WORDLENGTH-1:0] inputword;//sampled non-uniform signal value
output [WORDLENGTH-1:0] outputword;//interpolated signal value
wire clk30x;
wire reset;
wire [WORDLENGTH-1:0] inputword;
wire [WORDLENGTH-1:0] outputword;


//Local nets
wire [WORDLENGTH-1:0] C_row[0:7];
wire multBusyFlag;
wire [WORDLENGTH-1:0] chosen_coeff;
wire [WORDLENGTH-1:0] intermediate[1:2];
wire start_mult;
reg [4:0] count;
reg [2:0] wordIndex;
wire [2:0] startIndex;
reg [WORDLENGTH-1:0] previousOutputword;


//Assignments
`include "C_row1.v"

assign start_mult = (count==0)?1:0;
assign chosen_coeff = (wordIndex== startIndex+0)?C_row[0]:(wordIndex==startIndex+1)?C_row[1]:
					(wordIndex==startIndex+2)?C_row[2]:(wordIndex==startIndex+3)?C_row[3]:
					(wordIndex==startIndex+4)?C_row[4]:(wordIndex==startIndex+5)?C_row[5]:
					(wordIndex==startIndex+6)?C_row[6]:C_row[7];
//
assign intermediate[2] = (wordIndex== startIndex+0)?0:previousOutputword;

//Instantiations
multALU adder(outputword, intermediate[1], intermediate[2], 1'b0);
mult multiplier(intermediate[1],inputword,chosen_coeff,clk30x,multBusyFlag,start_mult);

//Logic
always @(posedge clk30x)
begin
	if (reset) 
	begin
		wordIndex = 0;
		count <= -1;
		previousOutputword <= 0;
	end
	else
	begin
	   if(count!=29)//some random count actually. Am lazy to know the exact counting required for the seq. mults to work.
		begin
			count <= count + 1;
		end
		else
		begin
			count <= 0;
			wordIndex <= wordIndex + 1'b1;
			previousOutputword <= outputword;
		end
	end
end

endmodule

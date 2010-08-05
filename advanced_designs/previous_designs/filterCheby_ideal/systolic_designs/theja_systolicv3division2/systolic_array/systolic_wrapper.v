/*
2009-05-28 v3
this will instantiate the autonomous processing elements. PE1,PE2...PE8
this will also haev the delay line.
Don't think any other control is necessary at this level.
Output muxing to take output from relevant PEs needs to be done.

*/


module systolic_wrapper(inputword,outputword,clk30x, reset);

parameter WORDLENGTH = 16;


//IO Declarations
input clk30x;	//clock for input word
input reset;	//resets the module, active high, synchronous
input [WORDLENGTH-1:0] inputword;//sampled non-uniform signal value
output [WORDLENGTH-1:0] outputword;//interpolated signal value
wire clk30x;
wire reset;
wire [WORDLENGTH-1:0] inputword;
reg [WORDLENGTH-1:0] outputword;


//Local nets
reg [WORDLENGTH-1:0] inputword_pe[1:7];
wire [WORDLENGTH-1:0] outputword_pe[0:7];
reg [4:0] count;
reg [2:0] wordIndex;
wire [2:0] startIndex;
reg [WORDLENGTH-1:0] inputwordReg;
wire [WORDLENGTH-1:0] outputwordWire;


assign startIndex = -1;	//chosen so as to get the correct outputword in the correct word index, based on modelsim waves.
assign outputwordWire = (wordIndex==7)?outputword_pe[0]:(wordIndex==0)?outputword_pe[1]:
					(wordIndex==1)?outputword_pe[2]:(wordIndex==2)?outputword_pe[3]:
					(wordIndex==3)?outputword_pe[4]:(wordIndex==4)?outputword_pe[5]:
					(wordIndex==5)?outputword_pe[6]:outputword_pe[7];
//

//Instantiations
systolic_PE1 pe1(inputword,outputword_pe[0],clk30x, reset);
systolic_PE2 pe2(inputword_pe[1],outputword_pe[1],clk30x, reset);
systolic_PE3 pe3(inputword_pe[2],outputword_pe[2],clk30x, reset);
systolic_PE4 pe4(inputword_pe[3],outputword_pe[3],clk30x, reset);
systolic_PE5 pe5(inputword_pe[4],outputword_pe[4],clk30x, reset);
systolic_PE6 pe6(inputword_pe[5],outputword_pe[5],clk30x, reset);
systolic_PE7 pe7(inputword_pe[6],outputword_pe[6],clk30x, reset);
systolic_PE8 pe8(inputword_pe[7],outputword_pe[7],clk30x, reset);

//Logic
always @(posedge clk30x)
begin
	if (reset) 
	begin
		wordIndex = 0;
		count <= -1;
		inputword_pe[1] <= 0;
		inputword_pe[2] <= 0;
		inputword_pe[3] <= 0;
		inputword_pe[4] <= 0;
		inputword_pe[5] <= 0;
		inputword_pe[6] <= 0;
		inputword_pe[7] <= 0;
		outputword <= 0;
		inputwordReg <=0;
	end
	else
	begin
		inputwordReg <= inputword;
		if(count!=29)//some random count actually. Am lazy to know the exact counting required for the seq. mults to work.
		begin
			count <= count + 1;
		end
		else
		begin
			count <= 0;
			wordIndex <= wordIndex + 1'b1;
			inputword_pe[1] <= inputwordReg;
			inputword_pe[2]	<= inputword_pe[1];
			inputword_pe[3]	<= inputword_pe[2];
			inputword_pe[4]	<= inputword_pe[3];
			inputword_pe[5]	<= inputword_pe[4];
			inputword_pe[6]	<= inputword_pe[5];
			inputword_pe[7]	<= inputword_pe[6];
			outputword <= outputwordWire;
		end
	end
end

endmodule

/*
2009-06-01 v4
timing will be removed. so will the count thing.
added a donext input... it should be precisely for 1 clk30x cycle only!!!

2009-05-28 v3
this will instantiate the autonomous processing elements. PE1,PE2...PE8
this will also haev the delay line.
Don't think any other control is necessary at this level.
Output muxing to take output from relevant PEs needs to be done.

*/


module systolic_wrapper(inputword,outputword,inputword_delayed,clk30x, donext, reset);

parameter WORDLENGTH = 16;


//IO Declarations
input 					clk30x				;	//clock for input word
input 					reset				;	//resets the module, active high, synchronous
input [WORDLENGTH-1:0] 	inputword			;	//sampled non-uniform signal value
input 					donext				;	//the trigger to change to next wordCycle.
output[WORDLENGTH-1:0] 	outputword			;	//interpolated signal value
output[WORDLENGTH-1:0] 	inputword_delayed	;	//input delayed signal value
wire 					clk30x				;
wire 					reset				;
wire  [WORDLENGTH-1:0] 	inputword			;
wire 					donext				;
reg   [WORDLENGTH-1:0] 	outputword			;
wire  [WORDLENGTH-1:0] 	inputword_delayed	;

//Local signals/nets
reg  [WORDLENGTH-1:0] 	inputword_pe[0:7]	;
wire [WORDLENGTH-1:0] 	outputword_pe[0:7]	;
reg  [2:0] 				wordIndex			;	//3 bits because we have a 8 point interpolator here.
wire [WORDLENGTH-1:0] 	outputwordWire		;


assign outputwordWire = (wordIndex==7)?outputword_pe[0]:(wordIndex==0)?outputword_pe[1]:
						(wordIndex==1)?outputword_pe[2]:(wordIndex==2)?outputword_pe[3]:
						(wordIndex==3)?outputword_pe[4]:(wordIndex==4)?outputword_pe[5]:
						(wordIndex==5)?outputword_pe[6]:outputword_pe[7];
//
assign inputword_delayed = inputword_pe[7];


//Instantiations
systolic_PE1 pe1(inputword_pe[0],outputword_pe[0],clk30x,donext, reset);	//scope for error: wired input inputword!!!
systolic_PE2 pe2(inputword_pe[1],outputword_pe[1],clk30x,donext, reset);
systolic_PE3 pe3(inputword_pe[2],outputword_pe[2],clk30x,donext, reset);
systolic_PE4 pe4(inputword_pe[3],outputword_pe[3],clk30x,donext, reset);
systolic_PE5 pe5(inputword_pe[4],outputword_pe[4],clk30x,donext, reset);
systolic_PE6 pe6(inputword_pe[5],outputword_pe[5],clk30x,donext, reset);
systolic_PE7 pe7(inputword_pe[6],outputword_pe[6],clk30x,donext, reset);
systolic_PE8 pe8(inputword_pe[7],outputword_pe[7],clk30x,donext, reset);

//Logic
always @(posedge clk30x)
begin
	if (reset) 
	begin
		wordIndex 		<=-1;
		inputword_pe[0]	<= 0;
		inputword_pe[1] <= 0;
		inputword_pe[2] <= 0;
		inputword_pe[3] <= 0;
		inputword_pe[4] <= 0;
		inputword_pe[5] <= 0;
		inputword_pe[6] <= 0;
		inputword_pe[7] <= 0;
		outputword 		<= 0;
	end
	else
	begin
		if(donext)//some random cycle input. should happend atleast between a span of 16 (#require for mult) +2 cycles.. which is satisfied here.
		begin
			wordIndex 		<= wordIndex + 1'b1	;
			inputword_pe[0]	<= inputword		;
			inputword_pe[1] <= inputword_pe[0]	;
			inputword_pe[2]	<= inputword_pe[1]	;
			inputword_pe[3]	<= inputword_pe[2]	;
			inputword_pe[4]	<= inputword_pe[3]	;
			inputword_pe[5]	<= inputword_pe[4]	;
			inputword_pe[6]	<= inputword_pe[5]	;
			inputword_pe[7]	<= inputword_pe[6]	;
			outputword 		<= outputwordWire	;
		end
	end
end

endmodule


parameter WORDLENGTH = 16;


//IO Declarations
input 					clk30x		;	//clock for input word
input 					reset		;	//resets the module, active high, synchronous
input [WORDLENGTH-1:0] 	inputword	;	//sampled non-uniform signal value
input 					donext		;
output[WORDLENGTH-1:0] 	outputword	;	//interpolated signal value
wire 					clk30x		;
wire 					reset		;
wire  [WORDLENGTH-1:0] 	inputword	;
wire 					donext		;
wire  [WORDLENGTH-1:0] 	outputword	;


//Local nets
wire [WORDLENGTH-1:0] 	C_row[0:7]			;
wire 					multBusyFlag		;
wire [WORDLENGTH-1:0] 	chosen_coeff		;
wire [WORDLENGTH-1:0] 	intermediate[1:2]	;
wire 					start_mult			;
wire [2:0] 				startIndex			;
reg  [2:0] 				wordIndex			;
reg  [WORDLENGTH-1:0] 	previousOutputword	;
reg						donext_delayed		;
//v0 2009-05-26: not taking care of positioning (2t/L-1)


module systolic(inputword,outputword,inclk,outclk, reset);

parameter WORDLENGTH = 16;


output [WORDLENGTH-1:0] outputword;//interpolated signal value

input [WORDLENGTH-1:0] inputword;//sampled non-uniform signal value
input inclk;	//clock for input word
input outclk;	//clock telling when to output the interpolated signal value words.
input reset;	//resets the module, active high, synchronous

wire inclk;
wire outclk;
wire reset;
wire [WORDLENGTH-1:0] inputword;
wire [WORDLENGTH-1:0] outputword;


//Local wires.



always @(posedge wClk)
begin
   if (reset) 
   begin
	
   end
   else
   begin
	if (count==NBITS) begin
	 xProd <= {A, Q};
	 busy <= 1'b0;
	end
	   else begin
	      case ({Q[0], rSequenceBit})
	         2'b0_1 : {A, Q,rSequenceBit} <= {sum[MBITS-1], sum, Q};
	         2'b1_0 : {A, Q,rSequenceBit} <= {difference[MBITS-1], difference, Q};
	         default: {A, Q,rSequenceBit} <= {A[MBITS-1], A, Q};
	      endcase
	      count <= count + 1'b1;
	   end
end

multALU adder (sum, A, xMpd, 1'b0);
multALU subtracter (difference, A, ~xMpd, 1'b1);

endmodule
